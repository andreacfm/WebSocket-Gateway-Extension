package railo.extension.gateway.websocket;

import net.tootallnate.websocket.WebSocket;

public class WebSocketImpl{

    private WebSocket _WebSockets;
    private String _type;
    private String _message;

    public WebSocketImpl(WebSocket ws,String type,String message) {
        _WebSockets = ws;
        _type = type;
        setMessage(message);
    }

    public WebSocket getWebSocket() {
        return _WebSockets;
    }

    public String getType() {
        return _type;
    }

    public void setMessage(String message) {
        _message = message;
    }

    public String getMessage() {
        return _message;
    }


}
