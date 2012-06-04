<cfscript>
import "railo.extension.gateway.*";
mockBox = createObject("component","mockbox.system.testing.MockBox").init();

 function base_config(){
    return {onClientOpen : "onClientOpen", onClientClose : "onClientClose", onMessage : "onMessage", debug : true};
}

function base_gateway(id="id", config=base_config(), listener=new WebSocketListener()){
    return new WebSocket("id", config, listener);
}

function out(message){
    sys = createObject("java", "java.lang.System");
    sys.out.println(message);
}

function connection(type="OnMessage", message="Hi there!"){
    var m = mock();
    m.getType().returns(type);
    m.getData().returns({message : message});
    m.isAuthenticated().returns(true);
    return m;
}
</cfscript>