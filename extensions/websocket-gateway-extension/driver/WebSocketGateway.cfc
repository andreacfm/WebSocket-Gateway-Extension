<cfcomponent extends="Gateway">

    <cfset fields=array(
		field("Server Port","port","10125",true,"Port of the websocket server","text"),
		field("Verbose","verbose","false",true,"Enable verbose logging","radio","true,false"),
		group("CFC Listener Function Defintion","Definitation for the CFC Listener Functions, when empty no listener is called",3),
		field("ClientOpen","onClientOpen","onClientOpen",false,"called when a client open a connection","text"),
		field("Message","onMessage","onMessage",false,"called when a client send a new message","text"),
		field("ClientClose","onClientClose","onClientClose",false,"called when the client close the connection","text")
	)>

	<cffunction name="getClass" returntype="string">
    	<cfreturn "">
    </cffunction>
	
	<cffunction name="getCFCPath" returntype="string">
    	<cfreturn "railo.extension.gateway.WebSocket">
    </cffunction>
    
	<cffunction name="getLabel" returntype="string" output="no">
    	<cfreturn "WebSocket">
    </cffunction>
	
	<cffunction name="getDescription" returntype="string" output="no">
    	<cfreturn "Create a general purpose websocket server">
    </cffunction>
    
	<cffunction name="onBeforeUpdate" returntype="void" output="false">
		<cfargument name="cfcPath" required="true" type="string">
		<cfargument name="startupMode" required="true" type="string">
		<cfargument name="custom" required="true" type="struct">
                
	</cffunction>
     
	<cffunction name="getListenerCfcMode" returntype="string" output="no">
		<cfreturn "required">
	</cffunction>

	<cffunction name="getListenerPath" returntype="string" output="no">
		<cfreturn "railo.extension.gateway.WebSocketListener">
	</cffunction>
		
</cfcomponent>