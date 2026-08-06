package com.ruoyi.system.rabbitmq;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnExpression;
import org.springframework.stereotype.Component;

/**
 * RabbitMQ消息生产者（架构储备）
 * 使用条件装配，只有在配置了spring.rabbitmq.host时才会启用
 * 用于发送心理健康相关的告警消息
 */
@Component
@ConditionalOnExpression("'${rabbitmq.enabled:false}' == 'true'")
public class AlertProducer {
    
    private static final Logger log = LoggerFactory.getLogger(AlertProducer.class);
    
    @Autowired(required = false)
    private RabbitTemplate rabbitTemplate;
    
    /**
     * 发送告警消息
     */
    public void sendAlert(String alertMessage) {
        if (rabbitTemplate == null) {
            log.warn("RabbitTemplate未配置，跳过发送告警消息: {}", alertMessage);
            return;
        }
        try {
            rabbitTemplate.convertAndSend("mental.health.alerts", alertMessage);
            log.info("发送告警消息成功: {}", alertMessage);
        } catch (Exception e) {
            log.error("发送告警消息失败: {}", alertMessage, e);
        }
    }
    
    /**
     * 发送紧急告警消息
     */
    public void sendUrgentAlert(String alertMessage) {
        if (rabbitTemplate == null) {
            log.warn("RabbitTemplate未配置，跳过发送紧急告警消息: {}", alertMessage);
            return;
        }
        try {
            rabbitTemplate.convertAndSend("mental.health.urgent", alertMessage);
            log.info("发送紧急告警消息成功: {}", alertMessage);
        } catch (Exception e) {
            log.error("发送紧急告警消息失败: {}", alertMessage, e);
        }
    }
    
}