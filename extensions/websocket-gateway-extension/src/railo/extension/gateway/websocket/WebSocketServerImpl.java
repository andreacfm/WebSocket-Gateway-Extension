package railo.extension.gateway.websocket;

import net.tootallnate.websocket.WebSocket;
import net.tootallnate.websocket.WebSocketServer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

public class WebSocketServerImpl extends WebSocketServer {


    public static final String ON_CLIENT_OPEN = "OnClientOpen";
    public static final String ON_CLIENT_ClOSE = "OnClientClose";
    public static final String ON_CLIENT_MESSAGE = "OnClientMessage";

	private String _gatewayID;
    private ArrayList _connectionsStack = new ArrayList();

    public WebSocketServerImpl(String port,String id) {
		super(Integer.parseInt(port));
    	_gatewayID = id;
    }

	@Override
	public void onClientOpen(WebSocket conn) {
        WebSocketImpl ws = new WebSocketImpl(conn,ON_CLIENT_OPEN,"Connected");
        _connectionsStack.add(ws);
	}

	@Override
	public void onClientClose(WebSocket conn) {
        WebSocketImpl ws = new WebSocketImpl(conn,ON_CLIENT_ClOSE,"Disconnetted");
        _connectionsStack.add(ws);
	}

	@Override
	public void onClientMessage(WebSocket conn, String message) {
        WebSocketImpl ws = new WebSocketImpl(conn,ON_CLIENT_MESSAGE,message);
        _connectionsStack.add(ws);

	}


    @Override
    public void sendToAll(String s) throws IOException {
        super.sendToAll(s);
    }

    /**
	 *  Sends <var>text</var> to the passed clients if they exists.
	 * @param conns
	 * @param text
	 * @throws IOException
	 */
	  public void send(ArrayList conns, String text) throws IOException {
		  Iterator it = conns.iterator();
		  while(it.hasNext()){
              WebSocketImpl ws = (WebSocketImpl)it.next();
			  ws.getWebSocket().send(ws.getMessage());
		  }

	  }

    /**
     *
     * @return the actual connections stack
     */
    public ArrayList getConnectionsStack() {
        return _connectionsStack;
    }

}
