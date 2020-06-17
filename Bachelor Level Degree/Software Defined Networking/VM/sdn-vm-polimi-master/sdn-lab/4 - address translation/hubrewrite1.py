# Questo switch presuppone
# mn --mac --arp --topo linear,3 --controller=remote
# Lo switch 2 dirotta il traffico tcp a h3:80 verso h2:8080

from ryu.base import app_manager
from ryu.controller import ofp_event
from ryu.controller.handler import CONFIG_DISPATCHER
from ryu.controller.handler import set_ev_cls
from ryu.ofproto import ofproto_v1_3
from ryu.ofproto import inet, ether


class PolimiHubRewrite(app_manager.RyuApp):
    OFP_VERSIONS = [ofproto_v1_3.OFP_VERSION]

    @set_ev_cls(ofp_event.EventOFPSwitchFeatures, CONFIG_DISPATCHER)
    def switch_features_handler(self, ev):
        datapath = ev.msg.datapath
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser

        # table miss flooding per tutti gli switch
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
            priority=0,
            match=match,
            instructions=inst
            )
        datapath.send_msg(mod)

        if datapath.id == 2:

            match = parser.OFPMatch(
                eth_type=ether.ETH_TYPE_IP,
                ipv4_dst="10.0.0.3",                                                            #se non conoscessi gli indirizzi della rete? ping su broadcast per popolare la tabella arp
                ip_proto=inet.IPPROTO_TCP,
                tcp_dst=80)
            # send broadcast
            actions = [
                parser.OFPActionSetField(
                    eth_dst="00:00:00:00:00:02"
                    ),
                parser.OFPActionSetField(ipv4_dst="10.0.0.2"),
                parser.OFPActionSetField(tcp_dst=8080),
                parser.OFPActionOutput(1)
                ]
            inst = [
                parser.OFPInstructionActions(
                    ofproto.OFPIT_APPLY_ACTIONS,
                    actions
                )
            ]
            mod = parser.OFPFlowMod(
                datapath=datapath,
                priority=1,
                match=match,
                instructions=inst
            )
            datapath.send_msg(mod)

            match = parser.OFPMatch(
                eth_type=ether.ETH_TYPE_IP,
                ipv4_src="10.0.0.2",
                ip_proto=inet.IPPROTO_TCP,
                tcp_src=8080)
            # send broadcast
            actions = [
                parser.OFPActionSetField(
                    eth_src="00:00:00:00:00:03"
                    ),
                parser.OFPActionSetField(ipv4_src="10.0.0.3"),
                parser.OFPActionSetField(tcp_src=80),
                parser.OFPActionOutput(2)
                ]
            inst = [
                parser.OFPInstructionActions(
                    ofproto.OFPIT_APPLY_ACTIONS,
                    actions
                )
            ]
            mod = parser.OFPFlowMod(
                datapath=datapath,
                priority=1,
                match=match,
                instructions=inst
            )
            datapath.send_msg(mod)
