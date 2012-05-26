component{

    property name="gateway";
    variables.handlers = {};

    public function init(gateway){
        variables.gateway = gateway;
        setUpHandlers();
        return this;
    }

    public function getHandler(conn){
        return variables.handlers[conn.getType()];
    }

    private function setUpHandlers(){
        variables.handlers["OnClientOpen"] = new OnClientOpenHandler(variables.gateway);
        variables.handlers["OnMessage"] = new OnMessageHandler(variables.gateway);
        variables.handlers["OnClientClose"] = new OnClientCloseHandler(variables.gateway);
    }

}