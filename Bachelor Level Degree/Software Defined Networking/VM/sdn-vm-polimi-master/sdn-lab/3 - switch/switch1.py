from ryu.base import app_manager
from ryu.controller import ofp_event
from ryu.controller.handler import CONFIG_DISPATCHER, MAIN_DISPATCHER
from ryu.controller.handler import set_ev_cls
from ryu.ofproto import ofproto_v1_3
from ryu.lib.packet import packet, ethernet

# This implements a learning switch in the controller
# The switch sends all packet to the controller
# The controller implements the MAC table using a python dictionary

class PsrSwitch(app_manager.RyuApp):
    OFP_VERSIONS = [ofproto_v1_3.OFP_VERSION]

    def __init__(self, *args, **kwargs):
        super(PsrSwitch, self).__init__(*args, **kwargs)
        self.mac_to_port = {} #tabellle di tabelle
	
    # execute at switch registration
    @set_ev_cls(ofp_event.EventOFPSwitchFeatures, CONFIG_DISPATCHER)
    def switch_features_handler(self, ev):   #esecuzione al primo collegamento di una sessione di uno switch
        datapath = ev.msg.datapath
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser

        self.mac_to_port.setdefault(datapath.id, {}) #inizializzazione della tabella col datapath.id, tabella inizialmente vuota
		
        # match all packets 
        match = parser.OFPMatch()
        # send to controller
        actions = [
            parser.OFPActionOutput(
                ofproto.OFPP_CONTROLLER,
                128 #bufferizzo a 128 byte
            )
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
        datapath.send_msg(mod) #le connessioni sono tcp persistenti tra switch e controllore, quindi volendo le posso mappare per utilizzarle direttamente e
                               #centralizzate tutto nel controllore ma preferibilmente da evitare perchè override del protocollo

    @set_ev_cls(ofp_event.EventOFPPacketIn, MAIN_DISPATCHER)
    def _packet_in_handler(self, ev):  #alla ricezione di un pacchetto in entrata
        msg = ev.msg
        datapath = msg.datapath
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser
        in_port = msg.match['in_port']
        dpid = datapath.id #ottengo il datapathid per cercare la tabella dello switch corretta

        pkt = packet.Packet(msg.data)
        eth = pkt.get_protocol(ethernet.ethernet)   #parsing di byte del pacchetto per estrarre i campi al suo interno

        assert eth is not None #controllo se protocollo esistente
        
        dst = eth.dst
        src = eth.src

        self.mac_to_port[dpid][src] = in_port  #attraverso il datapath e il src accedo al dizionario/tabella di secondo livello e inserisco al suo interno la porta sorgente

        if dst in self.mac_to_port[dpid]:   #accedo alla tabella dello switch corrispettivo, se il mac dest è presente lo estraggo altrimenti via di flooding
            out_port = self.mac_to_port[dpid][dst]
        else:
            out_port = ofproto.OFPP_FLOOD

#        self.logger.info("packet in %s %s %s %s %s", dpid, src, dst, in_port, out_port)

        actions = [
            parser.OFPActionOutput(out_port)
        ]

        assert msg.buffer_id != ofproto.OFP_NO_BUFFER
		
        out = parser.OFPPacketOut(
            datapath=datapath,
            buffer_id=msg.buffer_id,
            in_port=in_port,
            actions=actions,
            data=None
        )
        datapath.send_msg(out)
		