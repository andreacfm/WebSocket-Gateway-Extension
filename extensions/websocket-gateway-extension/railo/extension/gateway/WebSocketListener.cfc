component{

    public void function onClientOpen(Struct data){
        data.except = data.conn;
    }

    public void function onClientClose(Struct data){
        data.except = data.conn;
    }

    public void function onMessage(Struct data){
        data.except = data.conn;
    }

}