component extends="Handler"{

    public void function handle(connection){
        var listener = gateway.getListener();
        listener.onClientClose(connection);
    }

}