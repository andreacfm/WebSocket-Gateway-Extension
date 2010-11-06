package railo.extension.gateway.websocket;

import java.io.IOException;

import railo.loader.engine.CFMLEngine;
import railo.loader.engine.CFMLEngineFactory;
import railo.runtime.PageContext;
import railo.runtime.config.ConfigImpl;
import railo.runtime.exp.PageException;
import railo.runtime.gateway.GatewayEngineImpl;

import net.tootallnate.websocket.WebSocket;
import net.tootallnate.websocket.WebSocketServer;

public class WebSocketServerImpl extends WebSocketServer {
	
	private String _gatewayID;
	private String cfcPath ="railo.extension.gateway.WebSocket";
	
    public WebSocketServerImpl(String port,String id) {
		super(Integer.parseInt(port));
    	_gatewayID = id;
    }

	@Override
	public void onClientOpen(WebSocket conn) {
		CFMLEngine engine = CFMLEngineFactory.getInstance();
		PageContext pc = engine.getThreadPageContext();
		
		try{
			GatewayEngineImpl gateway =  (GatewayEngineImpl)((ConfigImpl)pc.getConfig()).getGatewayEngine().getComponent(cfcPath, _gatewayID);
		}catch(PageException e){
			e.printStackTrace();
		}
		
		try {
            this.sendToAll(conn + " is now connected;");
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        System.out.println(conn + " is now connected;");
	}

	@Override
	public void onClientClose(WebSocket conn) {
        try {
            this.sendToAll(conn + " disconnected;");
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        System.out.println(conn + " disconnetted");
	}

	@Override
	public void onClientMessage(WebSocket arg0, String arg1) {
		// TODO Auto-generated method stub

	}

}
