from ryu.base import app_manager
from ryu.controller import ofp_event
from ryu.controller.handler import CONFIG_DISPATCHER, MAIN_DISPATCHER
from ryu.controller.handler import set_ev_cls
from ryu.ofproto import ofproto_v1_3
from ryu.lib.packet import packet, ethernet

# This implements a learning switch in the of switch
# The switch uses two tables:
#   table 0 for source address
#       if source present -> go to table 1
#       if source mac missing -> send to controller & go to table 1
#   table 1 for destination address
#       if destination present -> send to destination
#       if destination missing -> flood
# Controller adds source mac to both tables
class PsrSwitch(app_manager.RyuApp):
    OFP_VERSIONS = [ofproto_v1_3.OFP_VERSION]
	
    # execute at switch registration
    @set_ev_cls(ofp_event.EventOFPSwitchFeatures, CONFIG_DISPATCHER)
    def switch_features_handler(self, ev):
        datapath = ev.msg.datapath
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser

        match = parser.OFPMatch()
        actions = [
            parser.OFPActionOutput(ofproto.OFPP_CONTROLLER,128)
        ]
        inst = [
            parser.OFPInstructionActions(
                ofproto.OFPIT_APPLY_ACTIONS,
                actions
            ),
            parser.OFPInstructionGotoTable(1)
        ]
        mod = parser.OFPFlowMod(
            datapath=datapath,
            table_id=0,
            priority=0,
            match=match,
            instructions=inst
        )
        datapath.send_msg(mod)

        match = parser.OFPMatch()
        actions = [
            parser.OFPActionOutput(ofproto.OFPP_FLOOD)
        ]
        inst = [
            parser.OFPInstructionActions(
                ofproto.OFPIT_APPLY_ACTIONS,
                actions
            )
        ]
        mod = parser.OFPFlowMod(
            datapath=datapath,
            table_id=1,
            priority=0,
            match=match,
            instructions=inst
        )
        datapath.send_msg(mod)

    @set_ev_cls(ofp_event.EventOFPPacketIn, MAIN_DISPATCHER)
    def _packet_in_handler(self, ev):
        msg = ev.msg
        datapath = msg.datapath
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser
        in_port = msg.match['in_port']
        dpid = datapath.id

        pkt = packet.Packet(msg.data)
        eth = pkt.get_protocol(ethernet.ethernet)

        assert eth is not None
        
        src = eth.src

#        self.logger.info("packet in %s %s %s", dpid, src, in_port)
        
        # add source address to table 0
        # to stop sending to the controller
        match = parser.OFPMatch(eth_src=src)
        inst = [
            parser.OFPInstructionGotoTable(1)
        ]
        mod = parser.OFPFlowMod(
            datapath=datapath,
            table_id=0,
            priority=1,
            match=match,
            instructions=inst
        )
        datapath.send_msg(mod)

        # add source address to table 1
        # to send to the correct port
        match = parser.OFPMatch(eth_dst=src)
        actions = [
            parser.OFPActionOutput(in_port)
        ]        
        inst = [
            parser.OFPInstructionActions(
                ofproto.OFPIT_APPLY_ACTIONS,
                actions
            )
        ]
        mod = parser.OFPFlowMod(
            datapath=datapath,
            table_id=1,
            priority=1,
            match=match,
            instructions=inst
        )
        datapath.send_msg(mod)
        