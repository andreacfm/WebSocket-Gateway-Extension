<!DOCTYPE html>
<html>
<head>
    <title>Railo Websockects Demo Apps - Data Push</title>
    <link href="../assets/style.css" rel="stylesheet" type="text/css">
</head>
<body>

    <div id="main">

        <h1>Data Push</h1>

        <p>
            This examples shows how you can push data from your Railo app to clients connected via the WebSockects Gateway.<br/>
            We simulate a stock exchange widget that gets updated any 2 sec with fake data coming from our Railo server.<br/> The websocket gateway is nothing
            more than a regular Railo gateway. As any other gateway can be invoked using the the <b>sendGatewayMessage()</b> function.
        </p>
        <script src="https://gist.github.com/810167.js?file=sendGatewayMessage"></script>

        <p>
        When the websocket gateway receive a ping will push the <b>data.message</b> value to any connected client. Of course if you configured a listener this will be invoked
        before to send the message out. Btw is not the case of this example app.
        </p>

        <h2>About this example app</h2>
        <p>
        We need to simulate a service on the server that send out data for our clients. We do that with a thread that run for 2 min. The thread is very easy :
        </p>
        <script src="https://gist.github.com/810191.js?file=websocket%20data_push%20example%20-%20data.cfm"></script>
        <p>As you see the thread simply create a set of data and push them to the gateway. That's it.</p>


        <h2>Run the gateway</h2>
        <ul>
            <li>Go to your Railo Admin and create a WebSocket Gateway that listen on port <b>10126</b>. Call it <b>stocks</b></li>
            <li>Go to page <a href="data.cfm" target="_blank">data.cfm</a> to start the thread.</li>
            <li>Go to page <a href="stocks.cfm" target="_blank">stocks.cfm</a> and see your widget gets fresh data any 2 secs.</li>
        </ul>

        <p>
        When you run the stocks.cfm page a new websocket is opened and as soon as is registered will start to get data. Go to the same page with more browsers or just
        open another browser tab. Anytime a new client connects will start to receive data for Railo gateway.
        </p>

        <p>
        After 2 min the thread will be killed so you will need to reload <a href="data.cfm" target="_blank">data.cfm</a> to make it restart.

        </p>

        <h2>Important</h2>
        <p>Not all the browsers support websockets out of the box. This example does not implement any library that allows a failover to flash for browser that doeas not support
           websockets. You can use Chrome, Safari or Firefox4(in beta up to this time).
        </p>

        <h2>More about the Gateway</h2>
        <p>Find more info about the gateway in the <a href="http://wiki.getrailo.org/wiki/Extensions:WebSockets_Gateway" target="_blank">Railo wiki pages</a></p>
        <p>Clone the source from <a href="https://github.com/andreacfm/WebSocket-Gateway-Extension" target="_blank">Github</a></p>
    </div>

</body>
</html>


