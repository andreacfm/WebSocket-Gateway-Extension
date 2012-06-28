package railo.extension.gateway.websocket;

import org.java_websocket.WebSocket;
import org.java_websocket.WebSocketServer;
import org.java_websocket.handshake.ClientHandshake;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.util.*;
import java.util.concurrent.LinkedBlockingDeque;

public class WebSocketServerImpl extends WebSocketServer {


    public static final String ON_CLIENT_OPEN = "OnClientOpen";
    public static final String ON_CLIENT_ClOSE = "OnClientClose";
    public static final String ON_CLIENT_MESSAGE = "OnMessage";

    private LinkedBlockingDeque<WebSocketImpl> _connectionsStack = new LinkedBlockingDeque<WebSocketImpl>();

    public WebSocketServerImpl(String port, String id) {
        super(new InetSocketAddress(Integer.parseInt(port)));
    }

    public void onOpen(WebSocket conn, ClientHandshake clientHandshake) {
        WebSocketImpl ws = new WebSocketImpl(conn, ON_CLIENT_OPEN, "");
        _connectionsStack.add(ws);
    }

    public void onClose(WebSocket conn, int code, String reason, boolean remote) {
        WebSocketImpl ws = new WebSocketImpl(conn, ON_CLIENT_ClOSE, "");
        _connectionsStack.add(ws);
    }

    public void onMessage(WebSocket conn, String message) {
        WebSocketImpl ws = new WebSocketImpl(conn, ON_CLIENT_MESSAGE, message);
        _connectionsStack.add(ws);

    }


    public void onError(WebSocket conn, Exception e) {

    }

    public void sendToAll(String text) {
        Set<WebSocket> con = connections();
        synchronized (con) {
            for (WebSocket c : con) {
                try {
                    c.send(text);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public void sendToAllExcept(WebSocketImpl webSocket, String message) throws IOException {
        Set<WebSocket> con = connections();
        synchronized (con) {
            for (WebSocket c : con) {
                try {
                    if (c == webSocket.getWebSocket()) {
                        continue;
                    }
                    c.send(message);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }

    }

    public void send(ArrayList conns, String text) throws IOException {
        Iterator it = conns.iterator();
        while (it.hasNext()) {
            WebSocketImpl ws = (WebSocketImpl) it.next();
            try {
                ws.getWebSocket().send(ws.getMessage());
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

    }

    /**
     * @return the actual connections stack
     */
    public Deque getConnectionsStack() {
        return _connectionsStack;
    }

    public WebSocketImpl getLast(){
        return _connectionsStack.poll();
    }

}
