<template>
  <div class="student-wrapper">
    <div class="header">
      <div class="date">{{ currentDate }}</div>
      <div class="greeting">{{ greetingText }}</div>
    </div>

    <div class="daily-card" @click="getQuote">
      <div class="card-title">✨ 每日 AI 寄语</div>
      <div class="card-content" v-loading="quoteLoading">{{ aiQuote }}</div>
    </div>

    <div class="mood-section">
      <div class="section-title">今天心情咋样啊？</div>
      <div class="mood-grid">
        <div class="mood-item" v-for="(mood, index) in moods" :key="index"
             :class="{ 'mood-active': selectedMood === index }"
             @click="handleQuickCheckIn(index, mood)">
          <span class="mood-emoji">{{ mood.emoji }}</span>
          <span class="mood-text">{{ mood.text }}</span>
        </div>
      </div>
    </div>

    <div class="menu-grid">
      <div class="menu-card" @click="goToPortal">
        <div class="menu-icon color-1"><i class="el-icon-edit-outline"></i></div>
        <div><div class="menu-title">写个日记？（放心写，没人知道是谁写的，偷偷表个白都不怕😋）</div><div class="menu-desc">AI 实时倾听</div></div>
      </div>
      
      <div class="menu-card" @click="$router.push('/student/care')">
        <div class="menu-icon color-2"><i class="el-icon-first-aid-kit"></i></div>
        <div><div class="menu-title">暖心信箱（来自陌生人的摸摸╰(￣ω￣ｏ)）</div><div class="menu-desc">查看建议方案</div></div>
      </div>
      <div class="menu-card" @click="$router.push('/student/breathe')">
        <div class="menu-icon color-3"><i class="el-icon-sunny"></i></div>
        <div><div class="menu-title">深呼吸（大口吸气😮‍💨然后咳咳咳😵呛到了）</div><div class="menu-desc">缓解焦虑情绪</div></div>
      </div>
      <div class="menu-card" @click="$router.push('/student/analysis')">
        <div class="menu-icon color-4"><i class="el-icon-data-line"></i></div>
        <div><div class="menu-title">情绪档案（这是我吗！！？🫣）</div><div class="menu-desc">图表分析与统计</div></div>
      </div>
      <div class="menu-card" v-if="isNonStudent" @click="goToBackend">
        <div class="menu-icon color-admin"><i class="el-icon-monitor"></i></div>
        <div><div class="menu-title">进入后台</div><div class="menu-desc">管理与数据分析</div></div>
      </div>
    </div>

    <div class="tab-bar">
      <div class="tab-item active">
        <i class="el-icon-s-home"></i>
        <span>首页</span>
      </div>
      <div class="tab-item" @click="goToDiaryList">
        <i class="el-icon-notebook-1"></i>
        <span>日记</span>
      </div>
      <div class="tab-item" @click="$router.push('/student/profile')">
        <i class="el-icon-user"></i>
        <span>我的</span>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import { addDiary } from "@/api/system/diary";
import request from '@/utils/request'

export default {
  name: "StudentIndex",
  data() {
    return {
      quoteLoading: false,
      selectedMood: null,
      aiQuote: "正在接收来自云端的治愈能量...",
      moods: [
        { emoji: '😄', text: '开心', value: 'happy', score: 90 },
        { emoji: '🙂', text: '平静', value: 'normal', score: 60 },
        { emoji: '😐', text: '一般', value: 'so-so', score: 50 },
        { emoji: '😔', text: '难过', value: 'sad', score: 30 },
        { emoji: '😫', text: '焦虑', value: 'anxious', score: 10 }
      ]
    };
  },
  computed: {
    ...mapGetters(["roles"]),
    isNonStudent() {
      return this.roles && !this.roles.includes("lower");
    },

    currentDate() {
      const date = new Date();
      return date.toLocaleDateString('zh-CN', { month: 'long', day: 'numeric', weekday: 'long' });
    },
    greetingText() {
      const hour = new Date().getHours();
      if (hour < 9) return "早安，新的一天！☀️";
      if (hour < 12) return "上午好，加油！🌟";
      if (hour < 18) return "下午好，喝杯茶吧 ☕";
      return "晚安，愿你好梦 🌙";
    }
  },
  created() {
    // 【优化】页面加载时，检查是否需要获取新寄语
    this.checkDailyQuote();
  },
  methods: {
    goToBackend() {
      this.$router.push('/'); // 若依默认后台首页路径通常是 / 或 /index
    },
    // 【新增】检查逻辑：每日只自动获取一次
    checkDailyQuote() {
      const todayStr = new Date().toLocaleDateString(); // 获取今天的日期字符串 (例如 "2026/1/24")
      const savedDate = localStorage.getItem('zhi_xin_quote_date'); // 上次保存的日期
      const savedQuote = localStorage.getItem('zhi_xin_quote_content'); // 上次保存的内容

      // 如果缓存中有内容，且日期是今天
      if (savedDate === todayStr && savedQuote) {
        // 直接使用缓存，不发请求
        this.aiQuote = savedQuote;
      } else {
        // 否则（日期变了，或者是第一次来），强制获取新的
        this.getQuote();
      }
    },

    // 【修改】获取寄语（支持手动点击刷新）
    getQuote() {
      this.quoteLoading = true;
      request({
        url: '/system/ai/dailyQuote',
        method: 'get'
      }).then(res => {
        const text = res.data || res.msg;
        this.aiQuote = text;
        
        // 【关键】获取成功后，存入 LocalStorage
        localStorage.setItem('zhi_xin_quote_content', text);
        localStorage.setItem('zhi_xin_quote_date', new Date().toLocaleDateString());
        
        this.quoteLoading = false;
      }).catch(() => {
        this.aiQuote = "今天也要好好爱自己。";
        this.quoteLoading = false;
      });
    },

    handleQuickCheckIn(index, moodItem) {
      this.selectedMood = index;
      const form = {
        title: "心情快速签到",
        content: `我今天感觉${moodItem.text} ${moodItem.emoji}`,
        moodTag: moodItem.text,
        moodScore: moodItem.score
      };
      addDiary(form).then(response => {
        this.$modal.msgSuccess(`签到成功！你今天感觉：${moodItem.text}`);
      });
    },

    goToPortal() {
      this.$router.push('/portal'); 
    },

    goToDiaryList() {
      this.$router.push('/student/diary');
    },

    msg(text) {
      this.$modal.msgWarning(text);
    }
  }
};
</script>

<style scoped>
/* ... 原有样式 ... */

/* 新增后台按钮的颜色样式 */
.color-admin { 
  background: #F4F6F8; 
  color: #606266; 
}

/* ... 原有样式 ... */
/* 样式保持不变，直接复用即可 */
.student-wrapper {
  background-color: #EEF7FF;
  min-height: 100vh;
  padding-bottom: 80px;
  background-image: linear-gradient(180deg, #E0F4FF 0%, #EEF7FF 100%);
  font-family: 'PingFang SC', sans-serif;
}
.header { padding: 30px 20px 10px; }
.date { font-size: 14px; color: #888; margin-bottom: 5px; }
.greeting { font-size: 24px; font-weight: bold; color: #4D869C; }

.daily-card {
  margin: 20px;
  background: linear-gradient(135deg, #7AB2B2 0%, #4D869C 100%);
  border-radius: 20px;
  padding: 25px;
  color: white;
  box-shadow: 0 10px 20px rgba(122, 178, 178, 0.3);
  position: relative;
  overflow: hidden;
}
.daily-card::after {
    content: '"'; position: absolute; right: 20px; bottom: -20px;
    font-size: 100px; opacity: 0.1; font-family: serif;
}
.card-content { font-size: 16px; line-height: 1.6; font-weight: 500; }
.card-title { font-size: 12px; opacity: 0.8; letter-spacing: 1px; margin-bottom: 10px; }

.mood-section { padding: 0 20px; margin-bottom: 30px; }
.section-title { font-size: 16px; font-weight: bold; color: #4D869C; margin-bottom: 15px; }
.mood-grid {
    display: flex; justify-content: space-between;
    background: white; padding: 20px;
    border-radius: 16px; box-shadow: 0 4px 15px rgba(0,0,0,0.03);
}
.mood-item { text-align: center; cursor: pointer; transition: transform 0.2s; }
.mood-emoji { font-size: 28px; display: block; margin-bottom: 5px; }
.mood-text { font-size: 12px; color: #888; }
.mood-active .mood-text { color: #7AB2B2; font-weight: bold; }

.menu-grid {
    display: grid; grid-template-columns: 1fr 1fr;
    gap: 15px; padding: 0 20px 20px;
}
.menu-card {
    background: white; padding: 20px; border-radius: 16px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.03); cursor: pointer;
    display: flex; flex-direction: column; justify-content: space-between; height: 100px;
}
.menu-icon {
    font-size: 24px; width: 45px; height: 45px; border-radius: 12px;
    display: flex; align-items: center; justify-content: center; margin-bottom: 10px;
}
.menu-title { font-size: 15px; font-weight: bold; color: #333; }
.menu-desc { font-size: 11px; color: #999; }
.color-1 { background: #E3F2FD; color: #42A5F5; }
.color-2 { background: #E8F5E9; color: #66BB6A; }
.color-3 { background: #FFF3E0; color: #FFA726; }
.color-4 { background: #F3E5F5; color: #AB47BC; }

.tab-bar {
    position: fixed; bottom: 0; left: 0; right: 0; height: 65px;
    background: rgba(255, 255, 255, 0.9); backdrop-filter: blur(15px);
    display: flex; justify-content: space-around; align-items: center;
    box-shadow: 0 -5px 20px rgba(0,0,0,0.03); z-index: 999;
}
.tab-item {
    flex: 1; display: flex; flex-direction: column; align-items: center;
    color: #B0BEC5; cursor: pointer;
}
.tab-item i { font-size: 22px; margin-bottom: 4px; }
.tab-item span { font-size: 10px; }
.tab-item.active { color: #7AB2B2; }
</style>