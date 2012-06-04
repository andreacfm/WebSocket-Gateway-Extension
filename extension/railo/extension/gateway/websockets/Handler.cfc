component accessors="true"{

    property name="gateway";

    public function init(gateway){
        setGateway(gateway);
        return this;
    }

}