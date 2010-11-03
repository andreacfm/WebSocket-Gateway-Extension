<cfcomponent>
	
	<cfscript>
		variables.name = "WebSocketGateway";
		variables.jar = "websocket-gateway.jar";
		variables.driver = "WebSocketGateway.cfc";
		variables.gateway = "WebSocket.cfc";
		variables.jars = "#variables.jar#,WebSocket.jar,apache-logging-log4j.jar";
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
			<cfadmin 
            	action="updateJar"
            	type="#request.adminType#"
            	password="#session["password"&request.adminType]#"    
            	jar="#path#lib/#i#">
		</cfloop>   
		
		<cffile 
		action="copy" 
		source="#path#driver/#variables.driver#" 
		destination="#expandPath('{railo-server}/context/admin/gdriver/')#/#variables.driver#"> 

		<cffile 
		action="copy" 
		source="#path#railo/extension/gateway/#variables.gateway#" 
		destination="#expandPath('{railo-server}/gateway/railo/extension/gateway/')#/#variables.gateway#"> 

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
			<cfadmin 
	            action="removeJar"
	            type="#request.adminType#"
	            password="#session["password"&request.adminType]#"    
	            jar="#path#lib/#i#">
		</cfloop>

		<cffile 
		action="delete" 
		file="#expandPath('{railo-server}/context/admin/gdriver/')#/#variables.driver#"> 
  
  		<cffile 
		action="delete" 
		file="#expandPath('{railo-server}/gateway/railo/extension/gateway/')#/#variables.gateway#"> 
      
        <cfreturn '#variables.name# is now successfully removed'>
		
    </cffunction>
    
       
</cfcomponent>