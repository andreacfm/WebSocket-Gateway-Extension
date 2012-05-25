component extends="Handler"{

    public void function handle(conn){
        writelog(text="Handling OnClientOpen", type="information", file="websocket");
    }

}