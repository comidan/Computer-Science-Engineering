from ryu.base import app_manager
from ryu.controller import ofp_event
from ryu.controller.handler import CONFIG_DISPATCHER, MAIN_DISPATCHER
from ryu.controller.handler import set_ev_cls
from ryu.ofproto import ofproto_v1_3

class PolimiHub(app_manager.RyuApp):
    OFP_VERSIONS = [ofproto_v1_3.OFP_VERSION]

    @set_ev_cls(ofp_event.EventOFPSwitchFeatures, CONFIG_DISPATCHER)
    def switch_features_handler(self, ev):
        datapath = ev.msg.datapath
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser

        match = parser.OFPMatch()
        actions = [
            parser.OFPActionOutput(
                ofproto.OFPP_CONTROLLER,   #forza lo switch ad inviare il pacchetto matchato al controllore che sarà poi gestito come evento di tipo ofp_event.EventOFPPacketInsr, lo fa inviandolo come un messaggio Packet-In
                ofproto.OFPCML_NO_BUFFER   #indica di inviare l'intero pacchetto completo al controllore come indicato da OFPP_CONTROLLER senza specificare la len massima e senza bufferizzarlo
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
            priority=1,                         #priorità 1 per far si che lo switch non ignori la descrizione dell'azione data da OFPCM_NO_BUFFER
            match=match,
            instructions=inst
        )
        datapath.send_msg(mod)

    # Registriamo un handler dell'evento Packet In, MAIN_DISPATCHER indica uno stato normale del controller che inoltra pacchetti indirettamente
    @set_ev_cls(ofp_event.EventOFPPacketIn, MAIN_DISPATCHER)  #evento che gestisce l'arrivo dei pacchetti matchati dallo switch come Packet-In come indicato dalle regole sopra
    def _packet_in_handler(self, ev):
        msg = ev.msg
        datapath = msg.datapath
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser

        # Per come abbiamo scritto le regole nello switch
        # i pacchetti non devono essere bufferizzati allo switch
        assert msg.buffer_id == ofproto.OFP_NO_BUFFER        #semplice controllo di assert che lancia eventualmente errori se condizione risulta falsa
        
        # Recuperiamo dai metadati del pacchetto
        # la porta di ingresso allo switch
        in_port = msg.match['in_port']

        actions = [
            parser.OFPActionOutput(
                ofproto.OFPP_FLOOD
            )
        ]

        out = parser.OFPPacketOut(                  #oggetto OFPPacketOut sempre attraverso parser che questa volta non va più a inviare delle regole ma il pacchetto stesso e dove specifichiamo che l'invio deve essere fatto a tutti (FLOOD)
            datapath=datapath,
            buffer_id=msg.buffer_id,
            in_port=in_port,
            actions=actions,
            data=msg.data
        )
        datapath.send_msg(out)
