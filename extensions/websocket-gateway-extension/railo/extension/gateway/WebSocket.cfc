<cfcomponent>
	
    <cfset state="stopped">
    	
	<cffunction name="init" access="public" output="no" returntype="void">
		<cfargument name="id" required="false" type="string">
		<cfargument name="config" required="false" type="struct">
		<cfargument name="listener" required="false" type="component">

    	<cfset variables.id=id>
        <cfset variables.config=config>
        <cfset variables.listener=listener>
        
        <cflog text="WebSocket Gateway [#arguments.id#] initialized" type="information" file="WebSocket">
    
	</cffunction>


	<cffunction name="start" access="public" output="no" returntype="void">
		<cflog text="Starting websocket server on port #variables.config.port#" type="information" file="WebSocket"> 
        <cftry>
        	<cfset state="starting">
			
			<cfset variables.server = createObject('java','railo.extension.gateway.websocket.WebSocketServerImpl').init(variables.config.port,variables.id)>
			<cfset variables.server.start()>
						
         	<cfset state="running">
         	<cflog text="Started websocket server on port #variables.config.port#" type="information" file="WebSocket"> 
        	<cfcatch>
            	 <cfset state="failed">
            	 <cflog text="#cfcatch.message#" type="fatal" file="WebSocket">
                 <cfrethrow>
            </cfcatch>
        </cftry>
	</cffunction>

	<cffunction name="stop" access="public" output="no" returntype="void">
		<cflog text="Stopping websocket server on port #variables.config.port#" type="information" file="WebSocket"> 
        <cftry>
        	<cfset state="stopping">
			
			<cfset variables.server.stop()>
						
         	<cfset state="stopped">
         	<cflog text="Stopped websocket server on port #variables.config.port#" type="information" file="WebSocket"> 
        	<cfcatch>
            	 <cfset state="failed">
            	 <cflog text="#cfcatch.message#" type="fatal" file="WebSocket">
                 <cfrethrow>
            </cfcatch>
        </cftry>
	</cffunction>

	<cffunction name="restart" access="public" output="no" returntype="void">
		<cflog text="Restarting websocket server on port #variables.config.port#" type="information" file="WebSocket"> 
        <cfif state EQ "running"><cfset stop()></cfif>
		<cfset start()>
	</cffunction>

	<cffunction name="getHelper" access="public" output="no" returntype="any">
		<cfset systemOutput("getHelper",true)>
        
        <cfreturn "HelperReturnData">
	</cffunction>

	<cffunction name="getState" access="public" output="no" returntype="string">
        <cfreturn state>
	</cffunction>

	<cffunction name="getServer" access="public" output="no" returntype="any">
        <cfreturn variables.server>
	</cffunction>

	<cffunction name="sendMessage" access="public" output="no" returntype="string">
		<cfargument name="data" required="false" type="struct">
		
		<!--- look for a webSocketServerAction (that comes from socket server) --->
		<cfif structKeyExists(data,"webSocketServerAction")>
			
			<cfswitch expression="#data.webSocketServerAction#">

				<cfcase value="onClientOpen">				
					<cfif len(config.onClientOpen)>
						<cfset variables.listener[config.onClientOpen](data,this) >
					</cfif>
				</cfcase>
				
				<cfcase value="onClientClose">				
					<cfif len(config.onClientClose)>
						<cfset variables.listener[config.onClientClose](data,this) >
					</cfif>
				</cfcase>
				
				<cfcase value="onMessage">				
					<cfif len(config.onMessage)>
						<cfset variables.listener[config.onMessage](data,this) >
					</cfif>
				</cfcase>
				
			</cfswitch>
			
			<cfreturn>
		</cfif>
		
		<!--- if we get here we are sending message from sendGatewayMessage --->
		<!--- 
		if data.connections.length == 0 >>>> send to all
		else send to the passed connections
		 --->
		<cfif not structkeyExists(data,'connections') or not isarray(data.connections)>
			<cfset data.connections = []>
		</cfif>
		<!--- throw and log if message is not provided ---> 
		<cfset variables.server.send(data.connections,data.message)>
		
		
	</cffunction>

</cfcomponent>