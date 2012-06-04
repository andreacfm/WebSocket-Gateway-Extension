component extends="Handler"{

    public void function handle(connection){
        var listener = getGateway().getListener();
        if(structKeyExists(listener, "onClientOpen")){
            listener.onClientOpen(connection);
        }
    }

}