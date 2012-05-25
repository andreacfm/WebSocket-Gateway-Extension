component extends="Handler"{

    public void function handle(conn){
        writelog(text="Handling OnMessage", type="information", file="websocket");
    }

}