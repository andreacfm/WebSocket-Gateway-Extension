<!--- Parameters --->
<cfset rootURL="http://#CGI.server_name#:#CGI.server_port#/extensions/">
<cfset root="/extensions">
<cfset zipFileLocation = 'ext/websocket-gateway.zip'>

<!--- Read Config --->
<cffile action="read" file="zip://#expandPath(zipFileLocation)#!/config.xml" variable="config">
<cfset info = XMLParse(config)>

<!--- Read unames --->
<cffile action="read" file="#expandPath(root)#/unames.xml" variable="unames">
<cfset unames = XMLParse(unames)>

<cfset providerWS =  CreateObject("webservice", "#rootURL#ExtensionProvider.cfc?wsdl")>
<cfset pInfo = providerWS.getInfo()>

<!---<cfadmin 
		action="updateExtension" 
		type="server" 
		password="#unames.config.server.password.XMLtext#"
		provider="#rootURL#ExtensionProvider.cfc"
		id="#info.config.info.id.XMLtext#"
		version="#info.config.info.version.XMLtext#" 
		name="#info.config.info.version.XMLtext#" 
		label="#info.config.info.label.XMLtext#"
		description="#info.config.info.version.XMLtext#" 
		category="#info.config.info.category.XMLtext#"
		author="#info.config.info.author.XMLtext#"
		codename="#info.config.info.version.XMLtext#"
		image="#pInfo.image#"
		video=""
		support=""
		documentation=""
		forum=""
		mailinglist=""
		network=""
	    _type="#info.config.info.type.XMLtext#"
/>		--->

	<cfscript>
		variables.name = "WebSocketGateway";
		variables.jar = "websocket-gateway.jar";
		variables.driver = "WebSocketGateway.cfc";
		variables.gateway = "WebSocket.cfc";
		variables.jars = "#variables.jar#,WebSocket.jar,apache-logging-log4j.jar";
		path = '/Users/andrea/dev/workspace/WebSocket-Gateway-Extension/webroot/extensions/websocket-gateway-extension/';
	</cfscript>
    
        
	<cfloop list="#variables.jars#" index="i">
		<cfadmin 
        	action="updateJar"
        	type="server"
        	password="#unames.config.server.password.XMLtext#"    
        	jar="#path#lib/#i#">
	</cfloop>   
	
	<cffile 
	action="copy" 
	source="#path#driver/#variables.driver#" 
	destination="#expandPath('{railo-web}/context/admin/gdriver/')#/#variables.driver#"> 

	<cffile 
	action="copy" 
	source="#path#railo/extension/gateway/#variables.gateway#" 
	destination="#expandPath('{railo-web}/gateway/railo/extension/gateway/')#/#variables.gateway#"> 


<cfadmin action="restart" type="server" password="#unames.config.server.password.XMLtext#" />
