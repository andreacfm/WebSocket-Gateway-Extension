component extends="mxunit.framework.TestCase"{
    include "test_helper.cfm";

    import "railo.extension.gateway.*"
    import "railo.extension.gateway.websockets.*"

    public function setUp(){
        gateway = base_gateway();
        handleFactory = new HandlerFactory(gateway);
    }

    public function test_get_handler_type_on_client_open(){
        var conn = mock();
        conn.getType().returns("OnClientOpen");
        assertIsTypeOf(handleFactory.getHandler(conn), "railo.extension.gateway.websockets.OnClientOpenHandler");
    }

    public function test_get_handler_type_on_message(){
        var conn = mock();
        conn.getType().returns("OnMessage");
        assertIsTypeOf(handleFactory.getHandler(conn), "railo.extension.gateway.websockets.OnMessageHandler");
    }

    public function test_get_handler_type_on_client_close(){
        var conn = mock();
        conn.getType().returns("OnClientClose");
        assertIsTypeOf(handleFactory.getHandler(conn), "railo.extension.gateway.websockets.OnClientCloseHandler");
    }

}
