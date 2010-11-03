<cfcomponent extends="Gateway">

    <cfset fields=array(
		field("Server Port","port","10125",true,"Port of the websocket server","text")
	)>

	<cffunction name="getClass" returntype="string">
    	<cfreturn "">
    </cffunction>
	
	<cffunction name="getCFCPath" returntype="string">
    	<cfreturn "railo.extension.gateway.WebSocket">
    </cffunction>
    
	<cffunction name="getLabel" returntype="string" output="no">
    	<cfreturn "WebSocket Gateway">
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
		<cfreturn "none">
	</cffunction>
	
</cfcomponent>