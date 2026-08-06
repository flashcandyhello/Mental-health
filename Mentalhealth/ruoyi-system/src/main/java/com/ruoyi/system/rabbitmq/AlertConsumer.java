package com.ruoyi.system.rabbitmq;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.boot.autoconfigure.condition.ConditionalOnExpression;
import org.springframework.stereotype.Component;

/**
 * RabbitMQ消息消费者（架构储备）
 * 使用条件装配，只有在配置了spring.rabbitmq.host时才会启用
 * 处理心理健康相关的告警消息
 */
@Component
@ConditionalOnExpression("'${rabbitmq.enabled:false}' == 'true'")
public class AlertConsumer {
    
    private static final Logger log = LoggerFactory.getLogger(AlertConsumer.class);
    
    /**
     * 监听告警队列
     * 只有在RabbitMQ配置存在时才会生效
     */
    @RabbitListener(queues = "mental.health.alerts", autoStartup = "${rabbitmq.enabled:false}")
    public void handleAlertMessage(String message) {
        try {
            log.info("接收到告警消息: {}", message);
            processAlert(message);
        } catch (Exception e) {
            log.error("处理告警消息失败: {}", message, e);
        }
    }
    
    /**
     * 空实现方法，避免在没有配置时出现错误
     */
    public void handleAlertMessageSafe(String message) {
        // 安全方法，不会抛出异常
    }
    
    /**
     * 处理告警消息的具体逻辑
     */
    private void processAlert(String message) {
        // 告警处理逻辑预留
        log.debug("处理告警: {}", message);
    }
    
}