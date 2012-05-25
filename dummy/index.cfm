<cfscript>
factory = new railo.extension.gateway.websockets.HandlerFactory();
dump(factory);

listener = new railo.extension.gateway.WebSocketListener();
gateway = createObject("component", "railo.extension.gateway.WebSocket");

dump(gateway);


</cfscript>