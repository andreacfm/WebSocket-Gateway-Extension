<cfcomponent output="false">

	<cffunction name="getInfo" access="remote" returntype="struct" output="false">
    	<cfset var info=struct()>
        <cfset info.title="Local Extension Provider ("&cgi.HTTP_HOST&")">
        <cfset info.mode="develop">
        <cfset info.description="Andrea Campolonghi personal development extensions">
        <cfset info.image="">
        <cfset info.url="http://" & cgi.HTTP_HOST>
    	<cfreturn info>
    </cffunction>
             
    <cffunction name="listApplications" access="remote" returntype="query" output="false">
		<cfset var apps=queryNew('type,id,name,label,description,version,category,image,download,paypal,author,codename,video,support,documentation,forum,mailinglist,network,created')>
        <cfset populate(apps)>
        <cfreturn apps>
    </cffunction>    
    
	<cffunction name="populate" access="private" returntype="void" output="false">
    	<cfargument name="apps" type="query" required="yes">
        
        <cfset var rootURL=getInfo().url & "/">
        <cfset var zipFileLocation = 'ext/websocket-gateway.zip'>
		
		<cffile action="read" file="zip://#expandPath(zipFileLocation)#!/config.xml" variable="config">
		<cfset info = XMLParse(config)>
		
        <cfset QueryAddRow(apps)>
      	<cfset QuerySetCell(apps,'download',rootURL & zipFileLocation)>
        <cfset QuerySetCell(apps,'id', info.config.info.id.XMLtext)>
        <cfset QuerySetCell(apps,'name',info.config.info.name.XMLtext)>
        <cfset QuerySetCell(apps,'type',info.config.info.type.XMLtext)>
        <cfset QuerySetCell(apps,'label',info.config.info.label.XMLtext)>
        <cfset QuerySetCell(apps,'description',info.config.info.description.XMLtext)>
        <cfset QuerySetCell(apps,'created',info.config.info.created.XMLtext)>
        <cfset QuerySetCell(apps,'version',info.config.info.version.XMLtext)>
        <cfset QuerySetCell(apps,'category',info.config.info.category.XMLtext)>
		<cfset QuerySetCell(apps,'author',info.config.info.author.XMLtext)>
		<cfset QuerySetCell(apps,'image',info.config.info.image.XMLtext)>
	</cffunction>

</cfcomponent>
