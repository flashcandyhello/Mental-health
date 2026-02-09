<template>
  <div class="student-wrapper">
    <div class="header">
      <div class="date">{{ currentDate }}</div>
      <div class="greeting">{{ greetingText }}</div>
    </div>


    <!-- 虚拟宠物组件 -->
    <div class="pet-container" @click="wakeUpPet">
      <div :class="['pet-emoji', petSizeClass]">
        <span v-if="isPetSleeping">😴</span> <!-- 猫咪睡觉时图标 -->
        <span v-else>{{ petEmoji }}</span>   <!-- 猫咪清醒时图标 -->
      </div>
      <div class="pet-status-text">
        <span>{{ petEmojiText }}</span> <!-- 统一使用 petEmojiText 来显示所有状态文本 -->
      </div>
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
        <div><div class="menu-title">写个日记？（可以公开匿名广场寻求抱抱\(￣︶￣*\)哦）</div><div class="menu-desc">AI 实时倾听</div></div>
      </div>
      
      <div class="menu-card" @click="$router.push('/student/care')">
        <div class="menu-icon color-2"><i class="el-icon-first-aid-kit"></i></div>
        <div><div class="menu-title">暖心信箱（陌生人很关心）</div><div class="menu-desc">查看建议方案</div></div>
      </div>
      <div class="menu-card" @click="$router.push('/student/breathe')">
        <div class="menu-icon color-3"><i class="el-icon-sunny"></i></div>
        <div><div class="menu-title">深呼吸解压</div><div class="menu-desc">缓解焦虑情绪</div></div>
      </div>
      <div class="menu-card" @click="$router.push('/student/reducepres')">
        <div class="menu-icon color-6"><i class="el-icon-timer"></i></div>
        <div><div class="menu-title">考前减压</div><div class="menu-desc">倒计时与烦恼焚烧</div></div>
      </div>
      <div class="menu-card" @click="$router.push('/student/square')">
        <div class="menu-icon color-5"><i class="el-icon-chat-dot-round"></i></div>
        <div><div class="menu-title">匿名广场</div><div class="menu-desc">给陌生的TA一个温暖的抱抱</div></div>
      </div>
      <div class="menu-card" @click="$router.push('/student/analysis')">
        <div class="menu-icon color-4"><i class="el-icon-data-line"></i></div>
        <div><div class="menu-title">情绪档案</div><div class="menu-desc">图表分析与统计</div></div>
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
      ],
      
      // 虚拟宠物相关数据
      continuousCheckInDays: 0, // 连续打卡天数
      lastMoodRecordDate: null, // 上次记录心情的日期字符串 'YYYY-MM-DD'
      breathingWakeupTimestamp: null, // 深呼吸唤醒的时间戳
      lastQuickCheckInDate: null // 上次快速签到的日期 'YYYY-MM-DD'
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
    // 获取今天的日期字符串，格式 YYYY-MM-DD，用于每日签到判断
    todayDateString() {
      return new Date().toISOString().slice(0, 10);
    },
    // 判断今天是否已经快速签到
    hasQuickCheckedInToday() {
      return this.lastQuickCheckInDate === this.todayDateString;
    },
    greetingText() {
      const hour = new Date().getHours();
      if (hour < 9) return "早安，新的一天！☀️";
      if (hour < 12) return "上午好，加油！🌟";
      if (hour < 18) return "下午好，喝杯茶吧 ☕";
      return "晚安，愿你好梦 🌙";
    },

    // 虚拟宠物相关计算属性
    isPetSleeping() {
      const today = new Date();
      const yesterday = new Date(today);
      yesterday.setDate(today.getDate() - 1);

      const yesterdayStr = yesterday.toLocaleDateString('zh-CN', { year: 'numeric', month: 'numeric', day: 'numeric' });
      const lastRecordDateStr = this.lastMoodRecordDate ? new Date(this.lastMoodRecordDate).toLocaleDateString('zh-CN', { year: 'numeric', month: 'numeric', day: 'numeric' }) : null;
      
      // 检查深呼吸唤醒是否仍在有效期内 (30分钟)
      const isBreathingAwake = this.breathingWakeupTimestamp && 
                               (Date.now() - this.breathingWakeupTimestamp < 30 * 60 * 1000); // 30分钟 = 30 * 60 * 1000 毫秒

      // 如果昨天没有记录心情，且深呼吸唤醒已过期或从未唤醒，则宠物睡觉
      return lastRecordDateStr !== yesterdayStr && !isBreathingAwake;
    },
    petSizeClass() {
      if (this.continuousCheckInDays >= 30) {
        return 'pet-size-lion'; // 假设30天是大猫 (或者可以叫 'pet-size-cat-large')
      } else if (this.continuousCheckInDays >= 7) {
        return 'pet-size-cat'; // 假设7天是小猫 (或者 'pet-size-cat-small')
      } else if (this.continuousCheckInDays > 0) {
        return 'pet-size-baby'; // 0-6天是宝宝猫
      }
      return 'pet-size-egg'; // 0天是蛋
    },
    petEmoji() {
        if (this.isPetSleeping) {
            return '😴'; // 睡觉表情，但会在 v-if 中被覆盖
        } else if (this.continuousCheckInDays >= 30) {
            return '🦁'; // 30天或以上
        } else if (this.continuousCheckInDays >= 7) {
            return '🐱'; // 7天或以上
        } else if (this.continuousCheckInDays > 0) {
            return '🐾'; // 1-6天，宝宝猫的脚印
        }
        return '⭐'; // 0天，星星
    },
    petEmojiText() {
        if (this.isPetSleeping) {
            return '小星辰在睡觉，需要唤醒';
        } else if (this.continuousCheckInDays === 0) {
            return '一颗新的小星辰在闪耀！';
        } else if (this.continuousCheckInDays < 7) {
            return `你的小星辰成长中！已陪伴你${this.continuousCheckInDays}天`;
        } else if (this.continuousCheckInDays < 30) {
            return `你的猫咪很健康！已陪伴你${this.continuousCheckInDays}天`;
        } else {
            return `你的狮子很威风！已陪伴你${this.continuousCheckInDays}天`;
        }
    }
  },
  created() {
    // 【优化】页面加载时，检查是否需要获取新寄语
    this.checkDailyQuote();
    // 初始化宠物状态
    this.getPetData();
    this.checkBreathingWakeUp();
    this.loadLastQuickCheckInDate(); // 【新增】加载上次快速签到日期
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
      // 检查今天是否已经快速签到
      if (this.hasQuickCheckedInToday) {
        this.$modal.msgWarning("今天已经签到过了哦，明天再来记录心情吧！");
        return;
      }

      // 只有在宠物非睡眠状态时，才能进行快速签到
      // isPetSleeping 已经考虑了深呼吸唤醒的30分钟有效期
      if (this.isPetSleeping) {
        this.$modal.msgWarning("猫咪在睡觉，请先唤醒它！");
        return;
      }

      this.selectedMood = index;
      const form = {
        title: "心情快速签到",
        content: `我今天感觉${moodItem.text} ${moodItem.emoji}`,
        moodTag: moodItem.text,
        moodScore: moodItem.score
      };
      addDiary(form).then(response => {
        this.$modal.msgSuccess(`签到成功！你今天感觉：${moodItem.text}`);
        // 更新最近一次心情记录日期 (用于判断宠物是否睡觉)
        this.lastMoodRecordDate = this.todayDateString;
        // 这里只是一个简单的模拟递增，实际应根据业务逻辑判断是否连续
        this.continuousCheckInDays = (this.continuousCheckInDays || 0) + 1; 
        localStorage.setItem('zhi_xin_continuous_days', this.continuousCheckInDays);
        localStorage.setItem('zhi_xin_last_mood_date', this.lastMoodRecordDate);
        
        // 标记今天已经快速签到
        this.lastQuickCheckInDate = this.todayDateString;
        localStorage.setItem('zhi_xin_last_quick_checkin_date', this.lastQuickCheckInDate);

        // 签到后清除深呼吸唤醒的时间戳，避免影响连续打卡逻辑
        localStorage.removeItem('zhi_xin_breathing_wakeup_timestamp');
        this.breathingWakeupTimestamp = null;
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
    },

    // 【新增】获取宠物数据 (模拟)
    getPetData() {
        // 实际应用中这里会调用后端API获取用户的连续打卡天数和上次心情记录日期
        // 假设通过 localStorage 模拟数据
        this.continuousCheckInDays = parseInt(localStorage.getItem('zhi_xin_continuous_days') || '0');
        this.lastMoodRecordDate = localStorage.getItem('zhi_xin_last_mood_date') || null;
    },

    // 【新增】唤醒宠物逻辑
    wakeUpPet() {
      if (this.isPetSleeping) {
        this.$modal.confirm('你的猫咪还在睡觉哦，需要完成一次深呼吸训练才能唤醒它并继续记录心情。现在就去深呼吸吗？', '唤醒宠物', {
          confirmButtonText: '去深呼吸',
          cancelButtonText: '取消',
          type: 'info'
        }).then(() => {
          this.$router.push('/student/breathe');
        }).catch(() => {
          // 用户取消，不进行任何操作
        });
      } else {
          this.$modal.msgSuccess("你的猫咪精力充沛！");
      }
    },

    // 【新增】唤醒宠物逻辑
    wakeUpPet() {
      // isPetSleeping 已经包含了30分钟唤醒状态的判断
      if (this.isPetSleeping) {
        this.$modal.confirm('你的猫咪还在睡觉哦，需要完成一次深呼吸训练才能唤醒它并继续记录心情。现在就去深呼吸吗？', '唤醒宠物', {
          confirmButtonText: '去深呼吸',
          cancelButtonText: '取消',
          type: 'info'
        }).then(() => {
          this.$router.push('/student/breathe');
        }).catch(() => {
          // 用户取消，不进行任何操作
        });
      } else {
          this.$modal.msgSuccess("你的猫咪精力充沛！");
      }
    },

    // 【新增】检查深呼吸唤醒状态
    checkBreathingWakeUp() {
        // 从 localStorage 获取深呼吸完成的时间戳
        const timestampStr = localStorage.getItem('zhi_xin_breathing_wakeup_timestamp');
        if (timestampStr) {
            const storedTimestamp = parseInt(timestampStr, 10);
            const currentTime = Date.now();
            const thirtyMinutesInMillis = 30 * 60 * 1000; // 30分钟的毫秒数

            if (currentTime - storedTimestamp < thirtyMinutesInMillis) {
                // 如果在30分钟内，则宠物处于唤醒状态
                this.breathingWakeupTimestamp = storedTimestamp;
                // 不需要直接设置 petStatusText，因为 petEmojiText 计算属性会处理
            } else {
                // 超过30分钟，清除唤醒状态
                localStorage.removeItem('zhi_xin_breathing_wakeup_timestamp');
                this.breathingWakeupTimestamp = null;
                // 不需要直接设置 petStatusText，因为 petEmojiText 计算属性会处理
            }
        } else {
            this.breathingWakeupTimestamp = null;
        }
        // 由于 isPetSleeping 和 petEmojiText 是计算属性，会在breathingWakeupTimestamp变化时自动更新，
        // 所以这里不需要手动设置 petStatusText。
    },
    // 【新增】加载上次快速签到日期
    loadLastQuickCheckInDate() {
      this.lastQuickCheckInDate = localStorage.getItem('zhi_xin_last_quick_checkin_date') || null;
      // 如果日期不是今天，则清除上次的记录，确保每日签到逻辑正常
      if (this.lastQuickCheckInDate !== this.todayDateString) {
        this.lastQuickCheckInDate = null;
        localStorage.removeItem('zhi_xin_last_quick_checkin_date');
      }
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

/* 虚拟宠物组件样式 */
.pet-container {
  text-align: center;
  margin: 20px auto;
  cursor: pointer;
  padding: 15px;
  background: white;
  border-radius: 20px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.03);
  max-width: 90%;
}

.pet-emoji {
  display: inline-block;
  font-size: 40px; /* Default size for egg */
  transition: all 0.5s ease-in-out;
  transform-origin: center bottom; /* For a 'growing' effect */
  animation: bounce 2s infinite ease-in-out; /* Basic animation */
}

.pet-emoji.pet-size-egg {
  font-size: 45px; /* 更大的星星 */
}

.pet-emoji.pet-size-baby {
  font-size: 50px; /* Small cat */
}

.pet-emoji.pet-size-cat {
  font-size: 60px; /* Medium cat */
}

.pet-emoji.pet-size-lion {
  font-size: 70px; /* Large lion */
}

.pet-status-text {
  margin-top: 10px;
  font-size: 14px;
  color: #666;
}

@keyframes bounce {
  0%, 100% {
    transform: scale(1); /* 恢复原始大小 */
  }
  50% {
    transform: scale(1.05); /* 稍微放大 */
  }
}

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
.color-5 { background: #FFE8E0; color: #FF9F7F; }
.color-6 { background: #E8F4F8; color: #4D869C; }

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

/* 虚拟宠物组件样式 */
.pet-container {
  text-align: center;
  margin: 20px auto;
  cursor: pointer;
  padding: 15px;
  background: white;
  border-radius: 20px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.03);
  max-width: 90%;
}

.pet-emoji {
  display: inline-block;
  font-size: 40px; /* Default size for baby/egg */
  transition: all 0.5s ease-in-out;
  transform-origin: center bottom; /* For a 'growing' effect */
  animation: bounce 2s infinite ease-in-out; /* Basic animation */
}

.pet-emoji.pet-size-egg {
  font-size: 40px;
}

.pet-emoji.pet-size-baby {
  font-size: 50px; /* Small cat */
}

.pet-emoji.pet-size-cat {
  font-size: 60px; /* Medium cat */
}

.pet-emoji.pet-size-lion {
  font-size: 70px; /* Large lion */
}

.pet-status-text {
  margin-top: 10px;
  font-size: 14px;
  color: #666;
}

@keyframes bounce {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-5px);
  }
}
</style>
