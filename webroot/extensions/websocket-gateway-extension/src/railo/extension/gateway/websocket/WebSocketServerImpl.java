package railo.extension.gateway.websocket;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import railo.loader.engine.CFMLEngine;
import railo.loader.engine.CFMLEngineFactory;
import railo.runtime.PageContext;
import railo.runtime.config.ConfigImpl;
import railo.runtime.exp.PageException;
import railo.runtime.type.Array;
import railo.runtime.type.Struct;

import net.tootallnate.websocket.WebSocket;
import net.tootallnate.websocket.WebSocketServer;

public class WebSocketServerImpl extends WebSocketServer {
	
	private String _gatewayID;
	
    public WebSocketServerImpl(String port,String id) {
		super(Integer.parseInt(port));
    	_gatewayID = id;
    }

	@Override
	public void onClientOpen(WebSocket conn) {

		try{

			CFMLEngine engine = CFMLEngineFactory.getInstance();
			PageContext pc = engine.getThreadPageContext();
			
			Struct data = engine.getCreationUtil().createStruct();
			
			data.set("webSocketServerAction", "onClientOpen");
			data.set("connection",conn);
		
			ConfigImpl conf = (ConfigImpl)pc.getConfig();
			conf.getGatewayEngine().sendMessage(_gatewayID,data);
           
		}catch(PageException e){
			e.printStackTrace();
		}catch (IOException ex) {
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

	/**
	 *  Sends <var>text</var> to the passed clients if they exists.
	 * @param connections
	 * @param text
	 * @throws IOException
	 */
	  public void sendToAllExcept(Array conns, String text) throws IOException {
		  Iterator<WebSocket> it = conns.iterator();
		  while(it.hasNext()){
			  it.next().send(text);	
		  }

	  }


}
