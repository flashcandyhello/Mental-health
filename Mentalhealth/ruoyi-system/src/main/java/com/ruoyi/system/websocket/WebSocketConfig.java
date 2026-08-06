package com.ruoyi.system.websocket;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * WebSocket配置类（架构储备）
 * 该配置默认不启用，作为WebSocket功能的架构储备
 * 使用条件装配，只有在websocket.enabled=true时才会启用
 */
@Configuration
@ConditionalOnProperty(name = "websocket.enabled", havingValue = "true", matchIfMissing = false)
public class WebSocketConfig implements WebMvcConfigurer {
    
    // WebSocket基础配置预留
    // 实际使用时需要启用相应的WebSocket依赖和配置
    
}