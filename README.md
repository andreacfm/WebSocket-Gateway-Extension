###Railo WebSockets Gateway Extension

For docs about the gateway visit this "wiki page":http://wiki.getrailo.org/wiki/Extensions:WebSockets_Gateway.

#### Changes
* verbose config is now called debug
* removed config for methods names that handle events in the listener.
* listener onOpen and onClose just get the connection as arguments
* no message is sent if connection isAuthenticated() is false

#### Todo

* check if listener has implemented the conventional method before attempt to call
* give a client id to the WebSocketImpl istances

##### Channels
* Server must be able to manage more that one channel.
* any connection will be added to a "default" channel that store any opened connection.
* add ability to *subscribe* to a specific channel

    ws.subscribe(channel, [message])
    send a message with a json like
    {"cmd" : "subscribe", "channel" : "channel_name", message : optional message to be sent to the subscribed channel}

* add ability to *publish* to a specific channel

    ws.publish(channel, messsage)
    send a message with a json like
    {"channel" : "channel_name", message : optional message to be sent to the subscribed channel}

* Server should allow implicit channels creation? Or it should refuse subcribtion to a not authorized channel?

* try to give support to [cf10 implementation](http://help.adobe.com/en_US/ColdFusion/10.0/Developing/WSe61e35da8d318518767eb3aa135858633ee-7ffc.html)


