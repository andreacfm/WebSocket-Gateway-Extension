component extends="Handler"{

    public void function handle(conn){
        var config = gateway.getConfig();
        var listener = gateway.getListener();

        if(len(config.onClientOpen)){
            listener[config.onClientOpen](data);
        }
        if(config.verbose){
            writelog(file="websocket", text="Action : OnClientOpen - Message : #data.message#", type="information");
        }
        return;
    }
}