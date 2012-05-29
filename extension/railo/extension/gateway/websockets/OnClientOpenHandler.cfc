component extends="Handler"{

    public void function handle(conn){
        var config = gateway.getConfig();
        var listener = gateway.getListener();
        var data = conn.getData();

        sys = createObject("java", "java.lang.System");
        sys.out.println(config);
        if(len(config.onClientOpen)){
            listener[config.onClientOpen](data);
        }
        if(config.verbose){
            writelog(file="websocket", text="Action : OnClientOpen - Message : #data.message#", type="information");
        }
        return;
    }
}