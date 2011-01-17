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
        WebSocketImpl ws = new WebSocketImpl(conn,ON_CLIENT_OPEN,"");
        _connectionsStack.add(ws);
	}

	@Override
	public void onClientClose(WebSocket conn) {
        WebSocketImpl ws = new WebSocketImpl(conn,ON_CLIENT_ClOSE,"");
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
     * Send to all the connections except the one passed
     * @param webSocket
     * @param message
     * @throws IOException
     */
    public void sendToAllExcept(WebSocketImpl webSocket, String message) throws IOException {
        super.sendToAllExcept(webSocket.getWebSocket(), message);
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
