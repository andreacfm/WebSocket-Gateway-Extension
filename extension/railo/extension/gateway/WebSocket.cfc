component accessors=true{

    import "railo.extension.gateway.websockets.*";

    property name="listener";
    property name="config";

    variables.state="stopped";

    public void function init(String id, Struct config, Component listener){
    	variables.id=id;
        variables.config=config;
        variables.listener=listener;

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
                var conn = variables.server.getLast();
                if(not isNull(conn)){
                   handleConnection(conn);
                 }
                sleep(2);
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


   /**
    Handle the incoming connection.
    In case of Open or Close connection return an empty struct cause no message will need to be sent.
    In case of OnMessage send to the listener a new {} containing the connection, the message and the channel.
    @conn connection object
    return the data struct after being processed by the listener
    */
    public function handle(conn){
        var data = { connection : conn, message : conn.getMessage() }
        if(conn.getType() == "OnMessage"){
            this.onMessage(data);
            return data;
        }else{
            this[conn.getType()](conn)
            return {};
        }
    }

    public String function sendMessage(Struct data){
        if(not structKeyExists(data, "channel")){
            data.channel = "default";
        }

        try{
            if(structkeyExists(data,'target') and isArray(data.target)){
                variables.server.send(data.target, data.message);
                return;
            }

            if(not structKeyExists(data,'conn')){
                 variables.server.sendToChannel(data.message, data.channel);
                 return;
            }

            variables.server.sendToChannel(data.message, data.channel, data.conn);

        }
        catch(Any e){
            this.log(e.message,"error");
            rethrow;
        }
    }

    private function onClientOpen(connection){
        var listener = getListener();
        if(structKeyExists(listener, "onClientOpen")){
            listener.onClientOpen(connection);
        }
    }

    private function  onClientClose(connection){
        var listener = getListener();
        if(structKeyExists(listener, "onClientClose")){
            listener.onClientClose(connection);
        }
    }

    private function onMessage(data){
        var listener = getListener();
        if(structKeyExists(listener, "onMessage")){
            listener.onMessage(data);
            if(getConfig().debug){
                this.log("Handling Message -- #data.connection.getMessage()#");
            }
        }

    }

}
