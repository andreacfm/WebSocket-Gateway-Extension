<cfsetting requesttimeout="120">
<cfset stocks = ['GOOG', 'APPL', 'MSFT', 'AMZN']>
<cfloop from="1" to="50" index="i">
	<cfset message = {}>
	<cfloop array="#stocks#" index="stock">
		<cfset message[stock] = randRange(1, 5)>
	</cfloop>
    <cfset data = {message : serializeJSON(message)}>
    <cfset sendGatewayMessage("stocks", data)>
    <cfoutput>- Pushing #data.toString()# to stocks</br></cfoutput>
    <cfflush/>
    <cfset sleep(2000)>
</cfloop>