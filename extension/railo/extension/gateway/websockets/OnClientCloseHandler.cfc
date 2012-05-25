component extends="Handler"{

    public void function handle(conn){
        writelog(text="Handling OnClientClose", type="information", file="websocket");
    }

}