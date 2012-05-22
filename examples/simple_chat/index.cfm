<!DOCTYPE html>
<html>
<head>
    <title>Railo Websockects Demo Apps - Simple Chat</title>
    <link href="assets/style.css" rel="stylesheet" type="text/css">
</head>
<body>

    <div id="main">

        <h1>Simple Chat</h1>

        <p>
            This example apps shows a very basis usage of the Websocket Gateway Extension. A very basic chat is nothing more than a server able to keep
            opened sockets and push messages to any listening client.<br/>
            This is the basic behaviour of our websockets server so we do not need to configure any listener for running
            this very easy example.
        </p>

        <h2>Run the chat</h2>
        <ul>
            <li>Go to your Railo Admin and create a WebSocket Gateway that listen on port <b>10125</b>. Use the name you like. Start the gateway.</li>
            <li>Go to page <a href="chat.cfm" target="_blank">chat.cfm</a>.</li>
            <li>Choose a nickname and click connect. Open another browser and call the same page. Choose a different nickname , click connect and start to chat.</li>
        </ul>

        <h2>Important</h2>
        <p>Not all the browsers support websockets out of the box. This example does not implement any library that allows a failover to flash for browser that doeas not support
           websockets. You can use Chrome, Safari or Firefox4(in beta up to this time).
        </p>

        <h2>Create a Websocket</h2>
        <p>For making this example a bit fancy (ok is not fancy but at least you look at that !!!) some more js and css has been added. Btw creating a websocket in pure javascript
        is incredibly easy.
        </p>
        <script src="https://gist.github.com/810140.js?file=websocket%20base"></script>

        <h2>More about the Gateway</h2>
        <p>Find more info about the gateway in the <a href="http://wiki.getrailo.org/wiki/Extensions:WebSockets_Gateway" target="_blank">Railo wiki pages</a></p>
        <p>Clone the source from <a href="https://github.com/andreacfm/WebSocket-Gateway-Extension" target="_blank">Github</a></p>
    </div>

</body>
</html>