<cfcomponent>
	
	<cfscript>
		variables.name = "WebSocketGateway";
		variables.driver = "WebSocketGateway.cfc";
		variables.listener = "WebSocketListener.cfc";
		variables.gateway = "WebSocket.cfc";
		variables.jars = "websocket-gateway.jar,WebSocket.jar";
	</cfscript>
    
    <cffunction name="validate" returntype="void" output="no"
    	hint="called to validate values">
    	<cfargument name="error" type="struct">
        <cfargument name="path" type="string">
        <cfargument name="config" type="struct">
        <cfargument name="step" type="numeric">
        
    </cffunction>
    
    <cffunction name="install" returntype="string" output="no"
    	hint="called from Railo to install application">
    	<cfargument name="error" type="struct">
        <cfargument name="path" type="string">
        <cfargument name="config" type="struct">

		<cfloop list="#variables.jars#" index="i">
            <cffile
            action="copy"
            source="#path#lib/#i#"
            destination="#getContextPath()#/lib/#i#">
		</cfloop>

        <cfadmin
        	action="updateContext"
            type="#request.adminType#"
            password="#session["password"&request.adminType]#"
            source="#path#driver/#variables.driver#"
            destination="admin/gdriver/#variables.driver#">

        <cffile
        action="copy"
        source="#path#railo/extension/gateway/#variables.gateway#"
        destination="#expandPath('{railo-web}')#/gateway/railo/extension/gateway/#variables.gateway#">

        <cffile
        action="copy"
        source="#path#railo/extension/gateway/#variables.listener#"
        destination="#expandPath('{railo-web}')#/gateway/railo/extension/gateway/#variables.listener#">

        <cfreturn '#variables.name# is now successfully installed'>

	</cffunction>

     <cffunction name="update" returntype="string" output="no"
    	hint="called from Railo to update a existing application">
    	<cfargument name="error" type="struct">
        <cfargument name="path" type="string">
        <cfargument name="config" type="struct">
        <cfset uninstall(path,config)>
		<cfreturn install(argumentCollection=arguments)>
    </cffunction>


    <cffunction name="uninstall" returntype="string" output="no"
    	hint="called from Railo to uninstall application">
    	<cfargument name="path" type="string">
        <cfargument name="config" type="struct">

		<cfloop list="#variables.jars#" index="i">
            <cffile
            action="delete"
            file="#getContextPath()#/lib/#i#">
		</cfloop>

		<cfadmin
        	action="removeContext"
            type="#request.adminType#"
            password="#session["password"&request.adminType]#"
            destination="admin/gdriver/#variables.driver#">


        <cffile
        action="delete"
        file="#expandPath('{railo-web}')#/gateway/railo/extension/gateway/#variables.gateway#">

        <cffile
        action="delete"
        file="#expandPath('{railo-web}')#/gateway/railo/extension/gateway/#variables.listener#">

        <cfreturn '#variables.name# is now successfully removed'>

    </cffunction>

	<cffunction name="getContextPath" access="private" returntype="string">

		<cfswitch expression="#request.adminType#">
			<cfcase value="web">
				<cfreturn expandPath('{railo-web}') />
			</cfcase>
			<cfcase value="server">
				<cfreturn expandPath('{railo-server}') />
			</cfcase>
		</cfswitch>

	</cffunction>


</cfcomponent>