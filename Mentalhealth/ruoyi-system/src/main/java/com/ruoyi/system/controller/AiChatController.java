package com.ruoyi.system.controller;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.DeepSeekUtils;
import com.ruoyi.system.service.IAiChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * AI聊天控制器
 */
@RestController
@RequestMapping("/system/ai")
public class AiChatController {

    @Autowired
    private IAiChatService aiChatService;

    /**
     * 发送聊天消息
     */
    @PostMapping("/chat")
    public AjaxResult chat(@RequestBody Map<String, String> request) {
        String message = request.get("message");
        String reply = aiChatService.getChatReply(message);
        
        Map<String, Object> result = new HashMap<>();
        result.put("reply", reply);
        return AjaxResult.success("ok", result);
    }

    /**
     * 获取聊天历史
     */
    @GetMapping("/history")
    public AjaxResult getHistory() {
        return AjaxResult.success(aiChatService.getChatHistory());
    }

    // 在 AiChatController 类中添加
    @GetMapping("/dailyQuote")
    public AjaxResult getDailyQuote() {
        try {
            String quote = DeepSeekUtils.getDailyQuote();
            return AjaxResult.success("操作成功", quote);
        } catch (Exception e) {
            return AjaxResult.success("操作成功", "哪怕是最微小的光芒，也足以在黑暗中照亮前行的路。"); // 兜底文案
        }
    }
}