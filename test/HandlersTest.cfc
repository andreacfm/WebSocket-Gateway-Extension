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

    /*
      OnClientOpenHandler
    */
    public function test_handler_should_invoke_the_listener(){
        var conn = mockbox.createStub();
        var listener = mockBox.createStub();
        listener.$("onClientOpen")
        var gateway = mockbox.createStub();
        gateway.$('getListener', listener);
        handler = new OnClientOpenHandler(gateway);
        handler.handle(conn);
        assertTrue( listener.$once("onClientOpen") );
    }

    public function test_handler_should_not_throw_if_listener_method_does_not_exixts(){
        var conn = mockbox.createStub();
        var listener = mockBox.createStub();
        var gateway = mockbox.createStub();
        gateway.$('getListener', listener);
        try{
            handler = new OnClientOpenHandler(gateway);
            handler.handle(conn);
        }catch(Any e){
            fail("Called onClientOpen method even if it does not exists.")
        }
    }

}
