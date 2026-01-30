import request from '@/utils/request'

// 发送聊天消息到AI
export function sendChatMessage(data) {
    return request({
        url: '/system/ai/chat',
        method: 'post',
        data: data
    })
}

// 获取聊天历史记录
export function getChatHistory() {
    return request({
        url: '/system/ai/history',
        method: 'get'
    })
}