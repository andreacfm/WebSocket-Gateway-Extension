component accessors=true{

    import "railo.extension.gateway.websockets.*";

    property name="listener";
    property name="config";

    variables.state="stopped";

    public void function init(String id, Struct config, Component listener){
    	variables.id=id;
        variables.config=config;
        variables.listener=listener;
        variables.handlerFactory = new HandlerFactory(this);

        this.log("WebSocket Gateway [#arguments.id#] initialized");

    }


	public void function start(){

	    this.log("Starting websocket server on port #variables.config.port#");

        try{
            variables.state="starting";
            variables.server = createObject('java','railo.extension.gateway.websocket.WebSocketServerImpl').init(variables.config.port,variables.id);
            variables.server.start();
            variables.state="running";

            this.log("Started websocket server on port #variables.config.port#");

            while(state eq 'running'){
                var conns = getServer().getConnectionsStack();
                var it = conns.iterator();
                while(it.hasNext()){
                    var conn = it.next();
                    handleConnection(conn);
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

		this.log("Stopping websocket server on port #variables.config.port#");

        try{
        	variables.state="stopping";
			variables.server.stop();
         	variables.state="stopped";
         	this.log("Stopped websocket server on port #variables.config.port#");

        }
        catch(Any e){
            variables.state="failed";
            this.log(e.message,"fatal");
            rethrow;
        }

	}

	public void function restart(){
		this.log("Restarting websocket server on port #variables.config.port#");

        if(variables.state EQ "running"){
            stop();
        }
		start();
	}

    /**
    Handle the incoming connection.
    In case of Open or Close connection return an empty struct cause no message will need to be sent.
    In case of OnMessage send to the listener a new {} containing the connection, the message and the channel.
    @conn connection object
    return the data struct after being processed by the listener
    */
    public function handle(conn){
        var handler = variables.handlerFactory.getHandler(conn);
        var data = { connection : conn, message : conn.getMessage() }
        if(conn.getType() == "OnMessage"){
            handler.handle(data);
            return data;
        }else{
            handler.handle(conn);
            return {};
        }
    }

    public any function getHelper(){
	}

	public String function getState(){
	    return variables.state;
	}

	public any function getServer(){
	    return variables.server;
	}

    public void function log(message, type="information"){
        writelog(file="websocket", text=message, type=type);

    }


    public function handleConnection(conn){
         try{
            var data = this.handle(conn);
            /*if no message or connection is not autenthicated return*/
            if(!conn.isAuthenticated() or conn.getType() != "OnMessage"){
                return;
            }
            this.sendMessage(data);
        }catch(Any e){
            this.log(e.message,"error");
            rethrow;
        }
    }

    public String function sendMessage(Struct data){

        try{
            /*
            * send only to the provided connections
            */
            if(structkeyExists(data,'connections') and isArray(data.connections)){

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
            this.log(e.message,"error");
            rethrow;
        }
    }

}
