<cfscript>
testSuite = createObject("component", "mxunit.framework.TestSuite").TestSuite();
testSuite.addAll("test.GatewayTest");
testSuite.addAll("test.HandlersTest");
results = testSuite.run();
writeOutput(results.getResultsOutput('html')); //See next section for other output formats
</cfscript>
