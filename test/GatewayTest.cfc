component extends="mxunit.framework.TestCase"{
    include "test_helper.cfm";

    import "railo.extension.gateway.*"
    import "railo.extension.gateway.websockets.*"

    public function get_config_should_return_the_config_object(){
        var config = { OnMessage : "CustomOnMessage"}
        var gateway = base_gateway(config=config)
        assertEquals(config, gateway.getConfig());
    }

}
