package com.ruoyi.system.service.impl;

import com.ruoyi.common.utils.DeepSeekUtils;
import com.ruoyi.system.service.IAiChatService;
import org.springframework.stereotype.Service;

/**
 * AI聊天服务实现 - 接入真实DeepSeek API
 */
@Service
public class AiChatServiceImpl implements IAiChatService {

    @Override
    public String getChatReply(String message) {
        if (message == null || message.trim().isEmpty()) {
            return "你好！我是AI心理助手，很高兴为你服务。有什么可以帮到你的吗？";
        }

        // 调用真实的DeepSeek API
        try {
            String aiReply = DeepSeekUtils.chat(message);
            return aiReply;
        } catch (Exception e) {
            // 如果调用失败，返回友好的错误提示
            return "抱歉，我现在无法连接到AI服务。请稍后再试，或者联系专业心理咨询师。";
        }
    }

    @Override
    public String getChatHistory() {
        return "[]"; // 暂时返回空数组，后续可以扩展为真实的聊天历史存储
    }
}