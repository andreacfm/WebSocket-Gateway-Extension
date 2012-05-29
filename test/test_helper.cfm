<cfscript>
import "railo.extension.gateway.*";

function base_config(){
    return {onClientOpen : "onClientOpen", onClientOpen : "onClientClose", onMessage : "onMessage", verbose : true};
}

function base_gateway(id="id", config=base_config(), listener=new WebSocketListener()){
    return new WebSocket("id", config, listener);
}

</cfscript>