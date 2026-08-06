package com.ruoyi.system.websocket;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

/**
 * WebSocket消息处理器（架构储备）
 * 用于处理WebSocket消息的收发，默认不启用
 * 使用条件装配，只有在websocket.enabled=true时才会启用
 */
@Component
@ConditionalOnProperty(name = "websocket.enabled", havingValue = "true", matchIfMissing = false)
public class WebSocketHandler extends TextWebSocketHandler {
    
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        // 消息处理逻辑预留
        // 实际使用时需要启用相应的WebSocket配置
        super.handleTextMessage(session, message);
    }
    
}