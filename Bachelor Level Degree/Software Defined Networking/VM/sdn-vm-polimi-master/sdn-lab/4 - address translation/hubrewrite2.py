# Questo switch presuppone
# mn --mac --arp --topo linear,3 --controller=remote
# Lo switch 2 dirotta il traffico tcp a h3:80 verso h2:8080

from ryu.base import app_manager
from ryu.controller import ofp_event
from ryu.controller.handler import CONFIG_DISPATCHER, MAIN_DISPATCHER
from ryu.controller.handler import set_ev_cls
from ryu.ofproto import ofproto_v1_3
from ryu.lib.packet import packet
from ryu.lib.packet import ethernet
from ryu.lib.packet import ipv4
from ryu.lib.packet import tcp
# from array import array

class PolimiHubRewrite(app_manager.RyuApp):
    OFP_VERSIONS = [ofproto_v1_3.OFP_VERSION]

    # execute at switch registration
    @set_ev_cls(ofp_event.EventOFPSwitchFeatures, CONFIG_DISPATCHER)
    def switch_features_handler(self, ev):
        datapath = ev.msg.datapath
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser

        # manda al controllore tutti i pacchetti
        match = parser.OFPMatch()
        actions = [parser.OFPActionOutput(
            ofproto.OFPP_CONTROLLER,
            ofproto.OFPCML_NO_BUFFER)]
        inst = [parser.OFPInstructionActions(
            ofproto.OFPIT_APPLY_ACTIONS,
            actions)]
        mod = parser.OFPFlowMod(
            datapath=datapath,
            priority=1,             #c'è la priorità 1 perchè non è possibile mettere NO_BUFFER nella priorità di default 0
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
        out_port = ofproto.OFPP_FLOOD

        pkt = packet.Packet(data=msg.data)

        pkt_ethernet = pkt.get_protocol(ethernet.ethernet)
        pkt_ipv4 = pkt.get_protocol(ipv4.ipv4)
        pkt_tcp = pkt.get_protocol(tcp.tcp)

        if (datapath.id == 2
            and pkt_tcp is not None
            and pkt_ipv4.dst == '10.0.0.3'
            and pkt_tcp.dst_port == 80):

            pkt_ethernet.dst='00:00:00:00:00:02'        #modificando qui nel controller posso assegnari variabili o espressioni o funzioni e non per forza una cosatante come quando si impone nello switch una regola dove ovviamente deve essere costante perchè nello switch non gira l'algoritmo ryu
            pkt_ipv4.dst='10.0.0.2'
            pkt_tcp.dst_port=8080
            pkt_tcp.csum=0 # il checksum va ricalcolato perchè cambi i parametri del pacchetto
            pkt.serialize()         #costruisce l'array di byte del pacchetto

            out_port = 1

        elif (datapath.id == 2
            and pkt_tcp is not None
            and pkt_ipv4.src == '10.0.0.2'
            and pkt_tcp.src_port == 8080):

            pkt_ethernet.src='00:00:00:00:00:03'
            pkt_ipv4.src='10.0.0.3'
            pkt_tcp.src_port=80
            pkt_tcp.csum=0 # il checksum va ricalcolato
            pkt.serialize()

            out_port = 2

        actions = [parser.OFPActionOutput(out_port)]
        data = pkt.data
        out = parser.OFPPacketOut(
            datapath=datapath,
            buffer_id=msg.buffer_id,
            in_port=in_port,
            actions=actions,
            data=data)
        datapath.send_msg(out)
