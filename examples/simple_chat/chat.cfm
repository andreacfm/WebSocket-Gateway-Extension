<!DOCTYPE html>
<html>
<head>
    <title>Railo Websockects Demo Apps - Simple Chat</title>
    <script src="assets/jquery-1.4.2.js" type="text/javascript"></script>
    <script src="assets/simple_chat.js" type="text/javascript"></script>
    <link href="assets/style.css" rel="stylesheet" type="text/css">
    <link href="assets/simple_chat.css" rel="stylesheet" type="text/css">
</head>
<body>

<div id="main">
<h1>Simple-Chat Demo</h1>

<table width="400" class="">
    <tr>
        <td>Nickname</td>
        <td><input type="text" id="nickname"/></td>
        <td><button id="connect">Connect</button></td>
        <td><button id="disconnect" disabled="disabled">Disconnect</button></td>
    </tr>
</table>

<input type="hidden" id="server_url" value="ws://localhost:10125"/>

<table width="600">
    <tr>
        <td colspan="2">
            <div id="chat_panel"></div>
        </td>
    </tr>
    <tr>
        <td width="90%"><input type="text" id="message_box" value="" style="width:100%" disabled="disabled"></td>
        <td>
            <button id="send" disabled="disabled">Send</button>
        </td>
    </tr>
</table>
</div>

</body>
</html>


