###Railo WebSockets Gateway Extension

For docs about the gateway visit this "wiki page":http://wiki.getrailo.org/wiki/Extensions:WebSockets_Gateway.


#### Todo

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


