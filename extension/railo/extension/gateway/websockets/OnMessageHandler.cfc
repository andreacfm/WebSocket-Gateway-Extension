component extends="Handler"{

    public void function handle(Struct data){
        var listener = gateway.getListener();
        listener.onMessage(data);
        if(gateway.getConfig().debug){
            gateway.log("Handling Message -- #data.connection.getMessage()#");
        }
    }

}