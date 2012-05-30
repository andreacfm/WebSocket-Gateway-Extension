<!DOCTYPE html>
<html>
<head>
    <title>Railo Websockects Demo Apps - Data Push</title>
    <script src="../assets/jquery-1.4.2.js" type="text/javascript"></script>
    <script type="text/javascript">
        var ws;
        $(document).ready(function(){
            ws = new WebSocket('ws://<cfoutput>#cgi.server_name#</cfoutput>:10126');
            console.log(ws);
            ws.onmessage = function(ev){
                var data = $.parseJSON(ev.data);
                for(key in data){
                    var el = $('#' + key);
                    var old_val = parseInt(el.text());
                    $('#' + key).text(data[key]);
                    if(data[key] != old_val){
                        el.css({backgroundColor:'yellow'});
                    }
                    setTimeout(function(){
                        $('p').css({backgroundColor:'transparent'});
                    },500)
                }
            }
        })
    </script>
    <link href="../assets/style.css" rel="stylesheet">
</head>
<body>

<h1>Data Push Demo</h1>

<h2>Stock Exchange</h2>

<table width="500" class="tablelisting">
    <thead>
        <tr>
            <td>Code</td>
            <td>Company Name</td>
            <td width="100">Value</td>
        </tr>
    </thead>
    <tbody>
        <tr class="even">
            <td>GOOG</td>
            <td>Google</td>
            <td><p id="GOOG"></p></td>
        </tr>
        <tr>
            <td>APPL</td>
            <td>Apple</td>
            <td><p id="APPL"></p></td>
        </tr>
        <tr class="even">
            <td>MSFT</td>
            <td>Micorsoft</td>
            <td><p id="MSFT"></p></td>
        </tr>
        <tr>
            <td>AMZN</td>
            <td>Amazon</td>
            <td><p id="AMZN"></p></td>
        </tr>
    </tbody>
</table>

</body>
</html>


