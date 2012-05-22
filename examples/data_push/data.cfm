<cfsetting requesttimeout="120">
<cfscript>
    param name ="gateway" default="stocks";
    stocks = ['GOOG', 'APPL', 'MSFT', 'AMZN'];

    while (true){
        message = {};
        for(item in stocks) {
            message[item] = randRange(1, 5);
        }
        data = {message : serializeJSON(message)}
        sendGatewayMessage(gateway, data);
        sleep(2000);
        writeOutput('- Pushing #data.toString()# to #gateway#</br>');
        flush;
    }
</cfscript>