<template>
  <div class="student-portal-wrapper">
    <header class="portal-navbar">
      <div class="navbar-inner">
        <div class="brand">
          <i class="el-icon-sugar"></i> 
          <span class="brand-text">知心舍友 | 心灵港湾</span>
        </div>
        
        <div class="right-actions">
          <el-button 
            type="primary" 
            plain 
            size="small" 
            icon="el-icon-s-home" 
            @click="$router.push('/student/index')"
          >
            返回主页
          </el-button>
        </div>
      </div>
    </header>

    <main class="portal-content-box">
      <el-row :gutter="20">
        <el-col :xs="24" :sm="24" :md="12" :lg="12">
          <div class="content-card diary-card">
            <div class="card-header">
              <h3><i class="el-icon-edit"></i> 记录此刻心情</h3>
              <span class="subtitle">AI 会认真倾听并给出建议</span>
            </div>

            <div class="mood-picker">
              <div 
                v-for="m in moodOptions" 
                :key="m.value"
                class="mood-chip"
                :class="{ active: selectedMoodValue === m.value }"
                @click="selectMood(m)"
              >
                <span class="emoji">{{ m.icon }}</span>
                <span class="text">{{ m.label }}</span>
              </div>
            </div>

            <el-input
              type="textarea"
              class="custom-textarea"
              :rows="6"
              placeholder="在这里写下你的烦恼、困惑或者开心的小事..."
              v-model="diaryForm.content"
              resize="none"
            ></el-input>

            <div class="card-footer">
              <el-button type="primary" round block class="submit-btn" :loading="submitting" @click="submitDiary">
                <i class="el-icon-s-promotion"></i> 投递心情 (AI 分析)
              </el-button>
            </div>
            
            <div class="quick-links">
               <div class="link-item" @click="$router.push('/diary')">
                 <i class="el-icon-notebook-2"></i> 往昔记录
               </div>
               <div class="link-item" @click="$router.push('/report')">
                 <i class="el-icon-pie-chart"></i> 心灵报告
               </div>
             </div>
          </div>
        </el-col>

        <el-col :xs="24" :sm="24" :md="12" :lg="12">
          <div class="content-card chat-card">
            <div class="chat-header-bar">
              <span class="title"><i class="el-icon-service"></i> AI 心理咨询师</span>
              <el-button type="text" icon="el-icon-delete" @click="clearChat" style="padding: 0; color: #999;">清空</el-button>
            </div>

            <div class="chat-window" ref="chatBox">
              <div v-for="(msg, i) in chatMessages" :key="i" class="chat-bubble-row" :class="msg.role === 'user' ? 'user' : 'ai'">
                 <el-avatar v-if="msg.role !== 'user'" size="small" class="avatar ai-bg" icon="el-icon-service"></el-avatar>
                 
                 <div class="bubble-content">
                   <div class="bubble-text">{{ msg.content }}</div>
                 </div>
                 
                 <el-avatar v-if="msg.role === 'user'" size="small" class="avatar user-bg" icon="el-icon-user"></el-avatar>
              </div>
              
               <div v-if="aiTyping" class="chat-bubble-row ai">
                 <el-avatar size="small" class="avatar ai-bg" icon="el-icon-service"></el-avatar>
                 <div class="bubble-content typing">
                   <span>.</span><span>.</span><span>.</span>
                 </div>
              </div>
            </div>

            <div class="chat-input-bar">
               <el-input v-model="chatInput" placeholder="和 AI 聊聊..." class="round-input" @keyup.enter.native="sendMessage" :disabled="aiTyping">
                 <el-button slot="append" icon="el-icon-position" @click="sendMessage" :loading="aiTyping"></el-button>
               </el-input>
            </div>
            
            <div class="faq-tags" v-if="chatMessages.length < 3">
              <el-tag v-for="q in quickQuestions" :key="q" size="mini" type="info" effect="plain" class="faq-tag" @click="sendQuickQuestion(q)">
                {{ q }}
              </el-tag>
            </div>
          </div>
        </el-col>
      </el-row>
    </main>
  </div>
</template>

<script>
// 1. 恢复 API 引用
import { addDiary } from "@/api/system/diary";
import { sendChatMessage } from "@/api/system/chat"; 

export default {
  name: "StudentPortalNew",
  data() {
    return {
      // 心情选项
      moodOptions: [
        { label: '开心', value: 'happy', icon: '😄', score: 90 },
        { label: '平静', value: 'normal', icon: '😐', score: 60 },
        { label: '难过', value: 'sad', icon: '😔', score: 40 },
        { label: '焦虑', value: 'anxious', icon: '😖', score: 30 }
      ],
      selectedMoodValue: 'happy', // 默认选中
      
      // 表单数据
      diaryForm: {
        content: "",
        moodScore: 90
      },
      
      submitting: false,
      
      // 聊天相关
      chatInput: '',
      aiTyping: false,
      chatMessages: [], 
      quickQuestions: ['我感到很焦虑怎么办？', '如何改善睡眠质量？', '感觉很迷茫']
    };
  },
  methods: {
    selectMood(m) {
      this.selectedMoodValue = m.value;
      this.diaryForm.moodScore = m.score; 
    },

    // 投递心情逻辑
    submitDiary() {
      if(!this.diaryForm.content) {
        return this.$modal.msgWarning("请写下一些内容吧");
      }
      
      this.submitting = true;
      
      const payload = {
        content: this.diaryForm.content,
        moodScore: this.diaryForm.moodScore, 
        moodTag: this.moodOptions.find(m => m.value === this.selectedMoodValue)?.label
      };

      addDiary(payload).then(response => {
        this.$modal.msgSuccess("分析完成！");
        this.submitting = false;
        const aiResult = response.data; 

        this.$router.push({
          path: "/mood/result",
          query: {
            content: this.diaryForm.content,
            score: aiResult ? aiResult.moodScore : 0,
            tag: aiResult ? aiResult.moodTag : '分析中',
            advice: aiResult ? aiResult.aiAdvice : 'AI 正在思考中...'
          }
        });

        this.diaryForm.content = "";
      }).catch(() => {
        this.submitting = false;
      });
    },

    // 聊天发送逻辑
    sendMessage() {
      const txt = this.chatInput.trim();
      if(!txt) return this.$modal.msgWarning("请输入内容");

      this.chatMessages.push({ role: 'user', content: txt });
      const userMessage = this.chatInput;
      this.chatInput = '';
      this.scrollToBottom();
      
      this.aiTyping = true; 

      sendChatMessage({ message: userMessage }).then(response => {
        this.chatMessages.push({
          role: 'assistant',
          content: response.data.reply || '抱歉，我暂时无法回答这个问题。'
        });
      }).catch(() => {
        this.chatMessages.push({
          role: 'assistant',
          content: '抱歉，服务暂时不可用，请稍后再试。'
        });
      }).finally(() => {
        this.aiTyping = false;
        this.scrollToBottom();
      });
    },

    sendQuickQuestion(q) {
      this.chatInput = q;
      this.sendMessage();
    },

    clearChat() {
      this.$confirm('确定要清空聊天记录吗？', '提示', { type: 'warning' }).then(() => {
        this.chatMessages = [];
        this.$modal.msgSuccess("记录已清空");
      });
    },

    scrollToBottom() {
      this.$nextTick(() => {
        const div = this.$refs.chatBox;
        if(div) div.scrollTop = div.scrollHeight;
      });
    }
  }
};
</script>

<style scoped>
/* 全局容器设置 */
.student-portal-wrapper {
  background-color: #f5f7fa;
  min-height: 100vh;
  width: 100% !important;
  padding: 0 !important;
  margin: 0 !important;
  display: flex;
  flex-direction: column;
}

/* 顶部导航 */
.portal-navbar {
  background: #fff;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
  height: 60px;
  flex-shrink: 0;
}

.navbar-inner {
  max-width: 1000px;
  margin: 0 auto;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 15px;
}

.brand {
  font-size: 18px;
  font-weight: bold;
  color: #409EFF;
  display: flex;
  align-items: center;
  gap: 8px;
}

.right-actions {
  display: flex;
  align-items: center;
}

/* 主内容容器 */
.portal-content-box {
  flex: 1;
  width: 100%;
  max-width: 1000px;
  margin: 0 auto !important; /* 强制居中 */
  padding: 20px 15px;
  box-sizing: border-box;
}

/* 卡片通用样式 */
.content-card {
  background: #fff;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 4px 16px rgba(0,0,0,0.05);
  height: 100%;
  display: flex;
  flex-direction: column;
  transition: transform 0.3s;
}

/* 手机适配 */
@media screen and (max-width: 768px) {
  .chat-card {
    margin-top: 20px;
    height: 500px;
  }
}

/* 左侧：心情日记相关 */
.card-header h3 {
  margin: 0;
  font-size: 18px;
  color: #303133;
}
.subtitle {
  font-size: 12px;
  color: #909399;
  margin-top: 5px;
  display: block;
}

.mood-picker {
  display: flex;
  justify-content: space-between;
  margin: 20px 0;
}

.mood-chip {
  flex: 1;
  text-align: center;
  padding: 8px 5px;
  border: 1px solid #EBEEF5;
  border-radius: 8px;
  margin: 0 4px;
  cursor: pointer;
  transition: all 0.2s;
}
.mood-chip:first-child { margin-left: 0; }
.mood-chip:last-child { margin-right: 0; }

.mood-chip.active {
  background: #ecf5ff;
  border-color: #409EFF;
  color: #409EFF;
}
.emoji { display: block; font-size: 24px; margin-bottom: 4px; }
.text { font-size: 12px; }

.custom-textarea >>> .el-textarea__inner {
  border: none;
  background: #f4f6f8;
  border-radius: 8px;
  padding: 12px;
  font-size: 14px;
}
.custom-textarea >>> .el-textarea__inner:focus {
  background: #fff;
  box-shadow: 0 0 0 1px #409EFF;
}

.card-footer { margin-top: 20px; }
.submit-btn {
  height: 40px;
  font-size: 16px;
  letter-spacing: 2px;
}

.quick-links {
  margin-top: 20px;
  padding-top: 15px;
  border-top: 1px dashed #eee;
  display: flex;
  justify-content: space-around;
}
.link-item {
  font-size: 13px;
  color: #606266;
  cursor: pointer;
}
.link-item:hover { color: #409EFF; }

/* 右侧：聊天相关 */
.chat-card {
  height: 580px;
}
.chat-header-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-bottom: 15px;
  border-bottom: 1px solid #f0f0f0;
  font-weight: bold;
  color: #333;
}

.chat-window {
  flex: 1;
  overflow-y: auto;
  padding: 15px 0;
  background: #fff;
}

.chat-bubble-row {
  display: flex;
  margin-bottom: 15px;
  align-items: flex-start;
}
.chat-bubble-row.user {
  flex-direction: row-reverse;
}

.avatar { flex-shrink: 0; margin-top: 2px; }
.ai-bg { background: #e1f3d8; color: #67C23A; }
.user-bg { background: #409EFF; }

.bubble-content {
  max-width: 75%;
  margin: 0 10px;
  padding: 10px 14px;
  border-radius: 12px;
  font-size: 14px;
  line-height: 1.5;
  position: relative;
}
.chat-bubble-row.ai .bubble-content {
  background: #f4f4f5;
  color: #333;
  border-top-left-radius: 2px;
}
.chat-bubble-row.user .bubble-content {
  background: #409EFF;
  color: #fff;
  border-top-right-radius: 2px;
}

.typing span {
  display: inline-block;
  animation: bounce 1s infinite;
  margin: 0 1px;
}
.typing span:nth-child(2) { animation-delay: 0.2s; }
.typing span:nth-child(3) { animation-delay: 0.4s; }
@keyframes bounce {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-3px); }
}

.chat-input-bar { margin-top: 10px; }
.round-input >>> .el-input__inner { border-radius: 20px 0 0 20px; background: #f4f6f8; border: none; }
.round-input >>> .el-input-group__append { border-radius: 0 20px 20px 0; background: #f4f6f8; border: none; color: #409EFF; }

.faq-tags { margin-top: 10px; display: flex; flex-wrap: wrap; gap: 8px; }
.faq-tag { cursor: pointer; }
</style>