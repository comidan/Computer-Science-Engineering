from ryu.base import app_manager
from ryu.controller import ofp_event
from ryu.controller.handler import CONFIG_DISPATCHER
from ryu.controller.handler import set_ev_cls
from ryu.ofproto import ofproto_v1_3


class PolimiHub(app_manager.RyuApp):
    OFP_VERSIONS = [ofproto_v1_3.OFP_VERSION]


    #ryu.controller.handler.set_ev_cls è il decorator principale indicato nelle import, specificatamente qui si utilizza ofp_event.EventOFPSwitchFeatures e con CONFIG_DISPATCHER indico l'azione
    #di attesa Waiting di ricezione del messaggio SwitchFeatures
    # decorator in python, associo questa funzione all'evento di contatto con un switch che tenta di registrarsi al controllore
    # CONFIG_DISPATCHER indica il tipo di evento da monitorare, per la documentazione ufficiale è : Waitiing SwitchFeatures Message
    # come parametro si ha ev che indica l'oggetto event che utilizzeremo per gestire la richiesta dello switch
    # ev.msg dove è memorizzata l'istanza classe del messaggio OpenFlow, in questo caso è ryu.ofproto.ofproto_v1_3_parser.OFPSwitchFeatures
    # msg.datapath è dove l'istanza della classe ryu.controller.controller.Datapath corrispondente allo Switch OpenFlow è memorizzata
    # datapath è una classe importante perchè è ciò che permette l'attuale comunicazione con lo Switch OpenFlow ed è ciò che permette la ricezione di questo stesso evento
    # datapath ha tre attribtuti princiapali :
    # id ID (datapath ID) dello switch OpenFlow corrispondente connesso.
    # ofproto indica il modulo ofproto (OpenFlow Protcol) supportato dalla corrente versione di OpenFlow in uso (in questo caso sarà ryu.ofproto.ofproto_v1_3)
    # ofproto_parser indica il modulo ofproto_parser supportato dalla corrente versione di OpenFlow. (in questo caso sarà : ryu.ofproto.ofproto_v1_3_parser)
    # la classe OFPMatch ci da un match vuoto cioè che accetta tutto
    # ofproto.OFPP_FLOOD specifica di inoltrare il pacchetto a tutte le porte tranne quella da cui è stato ricevuto e a quelle bloccate
    # OFPIT_APPLY_ACTIONS specifica di applicare immediatamente le azioni indicate e passate come parametro a OFPInstructionActions, oggetto inserito come unico elemente nella lista chiamata inst
    # la priorità a 0 e la più bassa e sta a indicare anch'essa di inviare qualsiasi pacchetto lo swtich riceva
    # notare che datapath.send_msg(mod) manda il FlowMod allo switch ma lo stesso si poteva fare senza creare direttamente un OFPFlowMod ma utilizzando semolicemnte il metodo self.add_flow ereditato dalla classe Ryu
    @set_ev_cls(ofp_event.EventOFPSwitchFeatures, CONFIG_DISPATCHER)
    def switch_features_handler(self, ev):
        datapath = ev.msg.datapath
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser

        match = parser.OFPMatch()
        actions = [parser.OFPActionOutput(ofproto.OFPP_FLOOD)]
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
