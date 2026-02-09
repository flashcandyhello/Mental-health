<template>
  <div class="student-wrapper">
    <div class="nav-bar">
      <div class="back-btn" @click="$router.push('/student/index')"><i class="el-icon-arrow-left"></i></div>
      <div class="page-title">心情日记本</div>
    </div>

    <div class="diary-list" v-loading="loading">
      <div v-if="diaryList.length === 0" style="text-align:center; color:#999; margin-top:50px;">
        <i class="el-icon-notebook-2" style="font-size:40px; margin-bottom:10px;"></i>
        <p>还没有写过日记哦，记录第一篇吧~</p>
      </div>

      <div class="diary-card" v-for="(item, index) in diaryList" :key="item.diaryId">
        
        <div v-if="item.riskLevel && item.riskLevel > 0" 
             class="risk-badge" 
             :class="'risk-' + item.riskLevel">
             {{ getRiskLabel(item.riskLevel) }}
        </div>

        <div class="diary-header">
          <div class="diary-mood">{{ getEmoji(item.moodTag) }}</div>
          <div class="diary-meta">
            <span class="diary-date">{{ parseTime(item.createTime, '{y}年{m}月{d}日') }}</span>
            <span class="diary-time">{{ parseTime(item.createTime, '{h}:{i}') }}</span>
          </div>
        </div>

        <div class="diary-content">{{ item.content }}</div>

        <div class="ai-reply-box" v-if="item.aiReply">
          <div class="ai-header">
            <i class="el-icon-cpu ai-icon"></i>
            知心助手
          </div>
          <div class="ai-content">{{ item.aiReply }}</div>
        </div>
        <div class="ai-reply-box" v-if="item.aiAdvice">
        <div class="ai-header">
            <i class="el-icon-cpu ai-icon"></i>
            知心助手
        </div>
        <div class="ai-content">{{ item.aiAdvice }}</div>
        </div> 
      </div>
    </div>

    <div class="fab-btn" @click="openWriteModal">
      <i class="el-icon-plus"></i>
    </div>

    <div class="modal-overlay" v-if="showWriteModal" @click.self="showWriteModal = false">
      <div class="write-panel">
        <div class="panel-header">
          <span class="panel-title">记录此刻</span>
          <span class="close-btn" @click="showWriteModal = false"><i class="el-icon-close"></i></span>
        </div>
        
        <div style="margin-bottom: 15px; display: flex; gap: 10px;">
          <span v-for="m in moodOptions" :key="m.value"
                @click="newDiary.moodTag = m.text; newDiary.moodScore = m.score"
                :style="{opacity: newDiary.moodTag === m.text ? 1 : 0.4, fontSize: '24px', cursor: 'pointer'}">
              {{m.emoji}}
          </span>
        </div>

        <textarea v-model="newDiary.content" placeholder="在这里写下你的烦恼或快乐..."></textarea>
        
        <button class="submit-btn" @click="submitDiary" :disabled="isSubmitting">
          {{ isSubmitting ? '发送中...' : '保存日记' }}
        </button>
      </div>
    </div>

    <div class="tab-bar">
      <div class="tab-item" @click="$router.push('/student/index')">
        <i class="el-icon-s-home"></i>
        <span>首页</span>
      </div>
      <div class="tab-item active">
        <i class="el-icon-notebook-1"></i>
        <span>日记</span>
      </div>
      <div class="tab-item" @click="$router.push('/student/reducepres')">
        <i class="el-icon-timer"></i>
        <span>考前减压</span>
      </div>
      <div class="tab-item" @click="$router.push('/student/square')">
        <i class="el-icon-chat-square"></i>
        <span>广场</span>
      </div>
      <div class="tab-item" @click="$router.push('/student/profile')">
        <i class="el-icon-user"></i>
        <span>我的</span>
      </div>
    </div>

  </div>
</template>

<script>
// 引入若依的通用工具
import { listDiary, addDiary } from "@/api/system/diary"; // 确保你有这个API文件
import { parseTime } from "@/utils/ruoyi";
import { mapGetters } from "vuex"; 

export default {
  name: "StudentDiary",
  computed: {
    ...mapGetters(["id"])
  },
  data() {
    return {
      loading: false,
      showWriteModal: false,
      isSubmitting: false,
      diaryList: [],
      // 表情映射配置 (和你首页的一致)
      moodOptions: [
        { emoji: '😄', text: '开心', score: 90 },
        { emoji: '🙂', text: '平静', score: 60 },
        { emoji: '😐', text: '一般', score: 50 },
        { emoji: '😔', text: '难过', score: 30 },
        { emoji: '😫', text: '焦虑', score: 10 }
      ],
      newDiary: {
        moodTag: '平静',
        moodScore: 60,
        content: ''
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    parseTime, // 注册方法以便在模板使用
    
    getList() {
      this.loading = true;
      listDiary({ 
        pageNum: 1, 
        pageSize: 20,
        userId: this.id,
        // 👇👇👇 新增这两个排序参数 👇👇👇
        orderByColumn: 'createTime', // 按照创建时间排序
        isAsc: 'desc'                // desc 代表倒序 (最新的在上面)
      }).then(res => {
        this.diaryList = res.rows;
        this.loading = false;
      });
    },

    // 根据心情文字(moodTag) 获取对应的 Emoji
    getEmoji(tag) {
      const found = this.moodOptions.find(item => item.text === tag);
      return found ? found.emoji : '😐'; // 默认表情
    },

    getRiskLabel(level) {
       const labels = ['正常', '轻微', '关注', '预警'];
       return labels[level] || '正常';
    },

    openWriteModal() {
      this.showWriteModal = true;
      this.newDiary.content = '';
    },

    submitDiary() {
      if (!this.newDiary.content) return this.$modal.msgError("写点什么吧~");
      
      this.isSubmitting = true;
      const form = {
        userId: this.id,
        title: "手机端日记",
        content: this.newDiary.content,
        moodTag: this.newDiary.moodTag,
        moodScore: this.newDiary.moodScore
      };

      addDiary(form).then(res => {
        this.$modal.msgSuccess("保存成功，AI正在分析...");
        this.showWriteModal = false;
        this.isSubmitting = false;
        this.getList(); // 刷新列表
      }).catch(() => {
        this.isSubmitting = false;
      });
    },

    msg(text) {
      this.$modal.msgWarning(text);
    }
  }
};
</script>

<style scoped>
/* 全局容器，保持背景色一致 */
.student-wrapper {
  background-color: #EEF7FF;
  min-height: 100vh;
  padding-bottom: 80px; 
  font-family: 'PingFang SC', sans-serif;
  max-width: 480px; 
  margin: 0 auto;
}

/* 顶部导航条 */
.nav-bar {
    padding: 20px;
    background: rgba(255,255,255,0.9);
    backdrop-filter: blur(10px);
    position: sticky; top: 0; z-index: 100;
    display: flex; align-items: center;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}
.back-btn { font-size: 20px; color: #333; cursor: pointer; padding: 5px; width: 30px;}
.page-title { flex: 1; text-align: center; font-weight: bold; font-size: 18px; margin-right: 30px; color: #4D869C;}

/* 卡片样式 */
.diary-list { padding: 20px; }
.diary-card {
    background: white; border-radius: 16px; padding: 20px; margin-bottom: 25px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.03); position: relative;
}
.diary-header { display: flex; align-items: center; margin-bottom: 12px; }
.diary-mood {
    font-size: 24px; margin-right: 10px; background: #f5f5f5; width: 40px; height: 40px;
    border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.diary-meta { display: flex; flex-direction: column; }
.diary-date { font-size: 14px; font-weight: bold; }
.diary-time { font-size: 11px; color: #888; }
.diary-content { font-size: 15px; line-height: 1.6; color: #444; margin-bottom: 15px; white-space: pre-wrap; }

/* AI 回复框 */
.ai-reply-box {
    background-color: #F0FAFA; border-radius: 12px; padding: 15px; position: relative;
    margin-top: 10px; border-left: 4px solid #7AB2B2;
}
.ai-header { display: flex; align-items: center; margin-bottom: 8px; font-size: 12px; color: #7AB2B2; font-weight: bold; }
.ai-icon { margin-right: 6px; }
.ai-content { font-size: 13px; color: #555; line-height: 1.5; }

/* 底部 TabBar (复用) */
.tab-bar {
    position: fixed; bottom: 0; left: 0; right: 0; height: 65px;
    background: rgba(255, 255, 255, 0.9); backdrop-filter: blur(15px);
    display: flex; justify-content: space-around; align-items: center;
    box-shadow: 0 -5px 20px rgba(0,0,0,0.03); z-index: 999;
    max-width: 480px; margin: 0 auto;
}
.tab-item { flex: 1; display: flex; flex-direction: column; align-items: center; color: #B0BEC5; cursor: pointer; }
.tab-item i { font-size: 22px; margin-bottom: 4px; }
.tab-item span { font-size: 10px; }
.tab-item.active { color: #7AB2B2; }

/* 悬浮按钮 & 弹窗 */
.fab-btn {
    position: fixed; bottom: 85px; right: 25px; width: 50px; height: 50px;
    background: #7AB2B2; color: white; border-radius: 50%;
    display: flex; align-items: center; justify-content: center; font-size: 24px;
    box-shadow: 0 4px 15px rgba(122, 178, 178, 0.4); cursor: pointer; z-index: 200;
}
.modal-overlay {
    position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.5); z-index: 300;
    display: flex; align-items: flex-end;
}
.write-panel {
    background: white; width: 100%; border-radius: 20px 20px 0 0; padding: 25px;
    animation: slideUp 0.3s ease-out;
}
@keyframes slideUp { from { transform: translateY(100%); } to { transform: translateY(0); } }
.panel-header { display: flex; justify-content: space-between; margin-bottom: 20px; font-weight: bold; }
textarea {
    width: 100%; height: 120px; border: none; background: #f9f9f9; border-radius: 12px;
    padding: 15px; font-size: 15px; box-sizing: border-box; resize: none; outline: none;
}
.submit-btn {
    width: 100%; background: #7AB2B2; color: white; border: none; padding: 15px;
    border-radius: 12px; font-size: 16px; margin-top: 15px; cursor: pointer;
}
</style>