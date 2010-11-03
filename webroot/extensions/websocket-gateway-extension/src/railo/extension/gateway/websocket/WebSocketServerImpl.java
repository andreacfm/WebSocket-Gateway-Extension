package railo.extension.gateway.websocket;

import net.tootallnate.websocket.WebSocket;
import net.tootallnate.websocket.WebSocketServer;

public class WebSocketServerImpl extends WebSocketServer {
	
	private String _gatewayId;
	
    public WebSocketServerImpl(String port,String id) {
		super(Integer.parseInt(port));
    	_gatewayId = id;
    }

	@Override
	public void onClientClose(WebSocket arg0) {
		

	}

	@Override
	public void onClientMessage(WebSocket arg0, String arg1) {
		// TODO Auto-generated method stub

	}

	@Override
	public void onClientOpen(WebSocket arg0) {
		

	}

}
