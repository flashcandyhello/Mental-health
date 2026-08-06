package com.ruoyi.system.rabbitmq;

import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitAdmin;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnExpression;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * RabbitMQ配置类（架构储备）
 * 使用条件装配，只有在配置了spring.rabbitmq.host时才会启用
 * 确保在未配置RabbitMQ时不会影响项目启动
 */
@Configuration
@ConditionalOnExpression("'${rabbitmq.enabled:false}' == 'true'")
public class RabbitMQConfig {
    
    @Value("${spring.rabbitmq.host:localhost}")
    private String host;
    
    @Value("${spring.rabbitmq.port:5672}")
    private int port;
    
    @Value("${spring.rabbitmq.username:guest}")
    private String username;
    
    @Value("${spring.rabbitmq.password:guest}")
    private String password;
    
    @Value("${spring.rabbitmq.virtual-host:/}")
    private String virtualHost;
    
    /**
     * 连接工厂配置
     */
    @Bean
    @ConditionalOnExpression("'${rabbitmq.enabled:false}' == 'true'")
    public ConnectionFactory connectionFactory() {
        try {
            CachingConnectionFactory connectionFactory = new CachingConnectionFactory();
            connectionFactory.setHost(host);
            connectionFactory.setPort(port);
            connectionFactory.setUsername(username);
            connectionFactory.setPassword(password);
            connectionFactory.setVirtualHost(virtualHost);
            // 设置连接超时，避免长时间等待
            connectionFactory.setConnectionTimeout(3000);
            return connectionFactory;
        } catch (Exception e) {
            // 静默处理，避免启动失败
            return null;
        }
    }
    
    /**
     * RabbitTemplate配置
     */
    @Bean
    @ConditionalOnExpression("'${rabbitmq.enabled:false}' == 'true'")
    public RabbitTemplate rabbitTemplate(ConnectionFactory connectionFactory) {
        if (connectionFactory == null) {
            return null;
        }
        return new RabbitTemplate(connectionFactory);
    }
    
    /**
     * RabbitAdmin配置
     */
    @Bean
    @ConditionalOnExpression("'${rabbitmq.enabled:false}' == 'true'")
    public RabbitAdmin rabbitAdmin(ConnectionFactory connectionFactory) {
        if (connectionFactory == null) {
            return null;
        }
        return new RabbitAdmin(connectionFactory);
    }
    
    /**
     * 消息队列配置（示例）
     */
    @Bean
    @ConditionalOnExpression("'${rabbitmq.enabled:false}' == 'true'")
    public Queue alertQueue() {
        return new Queue("mental.health.alerts", true);
    }
    
}