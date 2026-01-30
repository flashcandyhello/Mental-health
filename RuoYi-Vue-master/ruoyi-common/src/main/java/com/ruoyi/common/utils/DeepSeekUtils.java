package com.ruoyi.common.utils;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import okhttp3.*;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

/**
 * DeepSeek AI 调用工具类
 */
public class DeepSeekUtils {

    // 1. 替换为你自己的 API Key (去 deepseek 官网申请)
    private static final String API_KEY = "sk-252a7fb12879451ca824613487061a79";

    // DeepSeek 的 API 地址
    private static final String API_URL = "https://api.deepseek.com/chat/completions";

    private static final OkHttpClient client = new OkHttpClient.Builder()
            .connectTimeout(30, TimeUnit.SECONDS) // 连接超时
            .readTimeout(60, TimeUnit.SECONDS)    // 读取超时（AI思考需要时间，设长一点）
            .writeTimeout(30, TimeUnit.SECONDS)
            .build();

    /**
     * 发送日记内容给 AI，返回结构化的 JSON 结果
     */
    public static JSONObject analyzeMood(String diaryContent) {
        try {
            // 2. 构造 Prompt (提示词) - 这是核心！
            // 强制要求 AI 返回 JSON 格式，不要说废话
            String systemPrompt = "你是一个心理分析师。请分析用户的日记，返回 JSON 格式数据。" +
                    "格式要求：{\"score\": 分数(0-100), \"tag\": \"情绪标签(如焦虑/开心)\", \"advice\": \"简短建议(50字内)\"}。";

            // 3. 构造请求体 (按照 OpenAI 接口标准)
            JSONObject userMessage = new JSONObject();
            userMessage.put("role", "user");
            userMessage.put("content", diaryContent);

            JSONObject systemMessage = new JSONObject();
            systemMessage.put("role", "system");
            systemMessage.put("content", systemPrompt);

            JSONArray messages = new JSONArray();
            messages.add(systemMessage);
            messages.add(userMessage);

            JSONObject jsonBody = new JSONObject();
            jsonBody.put("model", "deepseek-chat");
            jsonBody.put("messages", messages);
            jsonBody.put("temperature", 1.0); // 创意程度

            RequestBody body = RequestBody.create(
                    MediaType.parse("application/json; charset=utf-8"),
                    jsonBody.toJSONString());

            Request request = new Request.Builder()
                    .url(API_URL)
                    .addHeader("Authorization", "Bearer " + API_KEY)
                    .addHeader("Content-Type", "application/json")
                    .post(body)
                    .build();

            // 4. 发送请求并获取结果
            try (Response response = client.newCall(request).execute()) {
                if (!response.isSuccessful()) throw new IOException("Unexpected code " + response);

                String resultJson = response.body().string();
                // 解析 DeepSeek 返回的复杂 JSON 结构
                JSONObject responseObj = JSON.parseObject(resultJson);
                String aiContent = responseObj.getJSONArray("choices")
                        .getJSONObject(0)
                        .getJSONObject("message")
                        .getString("content");

                // 去掉可能存在的 Markdown 符号 (```json ... ```)
                aiContent = aiContent.replace("```json", "").replace("```", "").trim();

                return JSON.parseObject(aiContent);
            }

        } catch (Exception e) {
            e.printStackTrace();
            // 如果出错，返回一个默认的兜底数据，防止系统报错
            JSONObject defaultObj = new JSONObject();
            defaultObj.put("score", 60);
            defaultObj.put("tag", "未分析");
            defaultObj.put("advice", "AI 暂时开小差了，请稍后再试。");
            return defaultObj;
        }
    }

    /**
     * AI聊天对话方法
     */
    public static String chat(String userMessage) {
        try {
            // 构造系统提示词 - 心理助手角色
            String systemPrompt = "你是一个温暖、专业的心理助手AI。你的任务是：\n"
                    + "1. 倾听用户的心声和困扰\n"
                    + "2. 给予情感支持和理解\n"
                    + "3. 提供实用的心理健康建议\n"
                    + "4. 语言要温暖、简洁，回复控制在100字以内\n"
                    + "5. 如果问题严重，建议寻求专业心理咨询";

            // 构造消息数组
            JSONArray messages = new JSONArray();
            
            // 系统消息
            JSONObject systemMsg = new JSONObject();
            systemMsg.put("role", "system");
            systemMsg.put("content", systemPrompt);
            messages.add(systemMsg);
            
            // 用户消息
            JSONObject userMsg = new JSONObject();
            userMsg.put("role", "user");
            userMsg.put("content", userMessage);
            messages.add(userMsg);

            // 构造请求体
            JSONObject jsonBody = new JSONObject();
            jsonBody.put("model", "deepseek-chat");
            jsonBody.put("messages", messages);
            jsonBody.put("temperature", 0.8); // 稍微降低随机性，保持回复的一致性
            jsonBody.put("max_tokens", 200);  // 限制回复长度

            RequestBody body = RequestBody.create(
                    MediaType.parse("application/json; charset=utf-8"),
                    jsonBody.toJSONString());

            Request request = new Request.Builder()
                    .url(API_URL)
                    .addHeader("Authorization", "Bearer " + API_KEY)
                    .addHeader("Content-Type", "application/json")
                    .post(body)
                    .build();

            // 发送请求并获取结果
            try (Response response = client.newCall(request).execute()) {
                if (!response.isSuccessful()) {
                    throw new IOException("Unexpected code " + response);
                }

                String resultJson = response.body().string();
                
                // 解析 DeepSeek 返回的 JSON 结构
                JSONObject responseObj = JSON.parseObject(resultJson);
                String aiReply = responseObj.getJSONArray("choices")
                        .getJSONObject(0)
                        .getJSONObject("message")
                        .getString("content");

                return aiReply.trim();
            }

        } catch (Exception e) {
            e.printStackTrace();
            // 如果出错，返回友好的错误提示
            return "抱歉，我现在无法连接到AI服务。请稍后再试，或者联系专业心理咨询师。";
        }

    }
    // 在 DeepSeekUtils 类中添加以下方法
    public static String getDailyQuote() {
        String systemPrompt = "你是一个温暖的心理疗愈师。请生成一句简短、温暖、充满力量的“每日寄语”，字数控制在30字以内，不要加引号，不要解释，直接返回句子。";
        return chat(systemPrompt); // 复用已有的 chat 方法，传入特定的提示词
    }
}