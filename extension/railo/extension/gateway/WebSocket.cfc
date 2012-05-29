component accessors=true{

    import "railo.extension.gateway.websockets.*";

    property name="listener";
    property name="config";

    variables.state="stopped";
    variables.handlerFactory = new HandlerFactory(this);

    public void function init(String id, Struct config, Component listener){
    	variables.id=id;
        variables.config=config;
        variables.listener=listener;

        writelog(text="WebSocket Gateway [#arguments.id#] initialized", type="information", file="websocket");

    }


	public void function start(){

	    writelog(text="Starting websocket server on port #variables.config.port#", type="information", file="websocket");

        try{
            variables.state="starting";

            variables.server = createObject('java','railo.extension.gateway.websocket.WebSocketServerImpl').init(variables.config.port,variables.id);
            variables.server.start();
            variables.state="running";

            writelog(text="Started websocket server on port #variables.config.port#", type="information", file="websocket");


            while(state eq 'running'){
                var conns = getServer().getConnectionsStack();
                var it = conns.iterator();
                while(it.hasNext()){
                    var conn = it.next();
                    var d = {};
                    d.conn = conn;
                    d.webSocketServerAction = conn.getType();
                    d.message = conn.getMessage();
                    sendMessage(d);
                    it.remove();
                }
                sleep(200);
            }

        }
        catch(Any e){
            variables.state="failed";
            writelog(text="#e.message#", type="fatal", file="websocket");
            rethrow;

        }

	}

	public void function stop(){

		writelog(text="Stopping websocket server on port #variables.config.port#", type="information", file="websocket");

        try{
        	variables.state="stopping";
			variables.server.stop();
         	variables.state="stopped";
         	writelog(text="Stopped websocket server on port #variables.config.port#", type="information",file="websocket");

        }
        catch(Any e){
            variables.state="failed";
            writelog(text="#e.message#", type="fatal", file="websocket");
            rethrow;
        }

	}

	public void function restart(){
		writelog(text="Restarting websocket server on port #variables.config.port#", type="information", file="websocket");

        if(variables.state EQ "running"){
            stop();
        }
		start();
	}

    public function handle(conn){
        variables.handlerFactory.getHandler(conn).handle(conn);
    }

    public any function getHelper(){
	}

	public String function getState(){
	    return variables.state;
	}

	public any function getServer(){
	    return variables.server;
	}


    public String function sendMessage(Struct data){

        try{
            if(structKeyExists(data,"webSocketServerAction")){

                /*
                * look for a webSocketServerAction (that comes from socket server)
                */
                switch(data.webSocketServerAction){
                    /*
                    * Hook for open event . Does not send any message
                    */
                    case "onClientOpen":{
                        if(len(config.onClientOpen)){
                           variables.listener[config.onClientOpen](data);
                        }
                        if(variables.config.verbose){
                            writelog(file="websocket", text="Action : OnClientOpen - Message : #data.message#", type="information");
                        }
                        return;
                    }

                   /*
                   * Hook for close event . Does not send any message
                   */
                    case "onClientClose":{
                        if(len(config.onClientClose)){
                            variables.listener[config.onClientClose](data);
                        }
                        if(variables.config.verbose){
                            writelog(file="websocket", text="Action : OnClientClose - Message : #data.message#", type="information");
                        }
                        return;
                    }

                    case "onMessage":{
                        if(len(config.onMessage)){
                            variables.listener[config.onMessage](data);
                        }
                        if(variables.config.verbose){
                            writelog(file="websocket", text="Action : OnMessage  - Message : #data.message#", type="information");
                        }
                    }
                }

            }else{
                /*
                If we get here we are sending message from sendGatewayMessage
                Treat as any incoming message
                */
                if(len(config.onMessage)){
                    variables.listener[config.onMessage](data);
                }
            }


            /*
            * send only to the provided connections
            */
            if(structkeyExists(data,'connections') and isarray(data.connections)){

                variables.server.send(data.connections,data.message);

            }
            else if(not structKeyExists(data,'conn') and not structKeyExists(data,"webSocketServerAction")){

                /*
                * No set of connections exists. If also no webSocketServerAction and conn exists means invocation comes from sengGatewayMessage
                * so send to all.
                */
                 variables.server.sendToAll(data.message);

            }else{

                /*
                * By deafult send to all except the connection that sent the message
                */
                variables.server.sendToAllExcept(data.conn,data.message);

            }

        }
        catch(Any e){
            writelog(type="error", text="#e.message#", file="websocket");
            rethrow;
        }
    }

}
