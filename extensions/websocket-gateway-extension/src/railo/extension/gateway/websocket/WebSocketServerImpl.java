package railo.extension.gateway.websocket;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

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

        try {
            this.sendToAll(conn + " connected;");
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        System.out.println(conn + " connetted");
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
	  public void sendToAllExcept(ArrayList conns, String text) throws IOException {
		  Iterator<WebSocket> it = conns.iterator();
		  while(it.hasNext()){
			  it.next().send(text);	
		  }

	  }


}
