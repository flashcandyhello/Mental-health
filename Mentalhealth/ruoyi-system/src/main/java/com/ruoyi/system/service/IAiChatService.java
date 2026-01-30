package com.ruoyi.system.service;

/**
 * AI聊天服务接口
 */
public interface IAiChatService {
    
    /**
     * 获取AI回复
     */
    String getChatReply(String message);
    
    /**
     * 获取聊天历史
     */
    String getChatHistory();
}