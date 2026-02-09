<template>
  <div class="reducepres-wrapper">
    <!-- 顶部导航 -->
    <div class="header">
      <div class="back-btn" @click="$router.push('/student/index')"><i class="el-icon-arrow-left"></i></div>
      <div class="title">考前减压</div>
      <div class="placeholder"></div>
    </div>

    <!-- 倒计时区域 -->
    <div class="countdown-section">
      <div class="countdown-card">
        <div class="exam-date-picker">
          <span class="label">距离考试还有</span>
          <el-date-picker
            v-model="examDate"
            type="date"
            placeholder="选择考试日期"
            size="small"
            :editable="false"
            value-format="yyyy-MM-dd"
            @change="calculateDays"
          />
        </div>
        
        <div v-if="remainingDays !== null" class="days-display">
          <div class="days-number" :class="daysClass">{{ remainingDays }}</div>
          <div class="days-unit">天</div>
        </div>
        
        <div v-else class="days-placeholder">
          <i class="el-icon-date"></i>
          <span>请选择考试日期</span>
        </div>
      </div>
    </div>

    <!-- 心理建议卡片 -->
    <div v-if="remainingDays !== null" class="advice-section">
      <div class="advice-card" :class="adviceClass">
        <div class="advice-icon">{{ adviceIcon }}</div>
        <div class="advice-title">{{ adviceTitle }}</div>
        <div class="advice-content">{{ adviceContent }}</div>
        <div class="advice-tips">
          <div v-for="(tip, index) in adviceTips" :key="index" class="tip-item">
            <i class="el-icon-check"></i> {{ tip }}
          </div>
        </div>
      </div>
    </div>

    <!-- 烧纸减压区域 -->
    <div class="burn-section">
      <div class="burn-card">
        <div class="burn-header">
          <i class="el-icon-document-delete"></i>
          <span>烦恼焚烧炉</span>
        </div>
        <div class="burn-desc">把烦恼写下来，让火焰带走它们</div>
        
        <div class="burn-input-wrapper">
          <textarea
            v-model="worryText"
            class="burn-textarea"
            placeholder="写下你的焦虑、担忧或烦恼..."
            :disabled="isBurning"
          ></textarea>
          
          <!-- 燃烧粒子效果 -->
          <div v-if="isBurning" class="particles-container">
            <div 
              v-for="(particle, index) in particles" 
              :key="index"
              class="particle"
              :style="particle.style"
            >{{ particle.char }}</div>
          </div>
        </div>
        
        <el-button 
          type="danger" 
          round 
          class="burn-btn"
          :loading="isBurning"
          :disabled="!worryText || isBurning"
          @click="burnWorries"
        >
          <i class="el-icon-fire"></i>
          {{ isBurning ? '焚烧中...' : '点火焚烧' }}
        </el-button>
        
        <div v-if="burnComplete" class="burn-success">
          <i class="el-icon-success"></i>
          <span>烦恼已随风而去，轻装上阵吧！</span>
        </div>
      </div>
    </div>

    <!-- 底部 TabBar -->
    <div class="tab-bar">
      <div class="tab-item" @click="$router.push('/student/index')">
        <i class="el-icon-s-home"></i>
        <span>首页</span>
      </div>
      <div class="tab-item" @click="$router.push('/student/diary')">
        <i class="el-icon-notebook-1"></i>
        <span>日记</span>
      </div>
      <div class="tab-item active">
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
export default {
  name: "ExamMode",
  data() {
    return {
      examDate: null,
      remainingDays: null,
      worryText: '',
      isBurning: false,
      burnComplete: false,
      particles: []
    };
  },
  computed: {
    // 根据剩余天数计算样式类
    daysClass() {
      if (this.remainingDays > 7) return 'days-relax';
      if (this.remainingDays >= 3) return 'days-warning';
      return 'days-urgent';
    },
    adviceClass() {
      if (this.remainingDays > 7) return 'advice-relax';
      if (this.remainingDays >= 3) return 'advice-warning';
      return 'advice-urgent';
    },
    adviceIcon() {
      if (this.remainingDays > 7) return '🌱';
      if (this.remainingDays >= 3) return '💪';
      return '🔥';
    },
    adviceTitle() {
      if (this.remainingDays > 7) return '时间充裕，稳步前行';
      if (this.remainingDays >= 3) return '冲刺阶段，保持节奏';
      return '最后关头，全力以赴';
    },
    adviceContent() {
      if (this.remainingDays > 7) {
        return '距离考试还有一段时间，这是夯实基础的最佳时期。保持规律作息，循序渐进地复习，相信积累的力量。';
      }
      if (this.remainingDays >= 3) {
        return '考试临近，这是最后的冲刺阶段。重点复习薄弱环节，保持良好心态，适当放松让大脑保持清醒。';
      }
      return '考试就在眼前，这是检验成果的时刻。调整好生物钟，准备好考试用品，以最佳状态迎接挑战！';
    },
    adviceTips() {
      if (this.remainingDays > 7) {
        return [
          '制定详细的复习计划，按部就班',
          '保证每天7-8小时睡眠',
          '适当运动，保持身体健康',
          '遇到难题及时请教老师同学'
        ];
      }
      if (this.remainingDays >= 3) {
        return [
          '重点复习错题和薄弱环节',
          '进行模拟考试，调整状态',
          '深呼吸放松，缓解紧张情绪',
          '准备好考试用品和证件'
        ];
      }
      return [
        '复习重点笔记，不再刷新题',
        '调整作息与考试时间同步',
        '准备好考试用品，提前踩点',
        '相信自己，你已经准备好了！'
      ];
    }
  },
  created() {
    // 从本地存储读取考试日期
    const savedDate = localStorage.getItem('zhi_xin_exam_date');
    if (savedDate) {
      this.examDate = savedDate;
      this.calculateDays(savedDate);
    }
  },
  methods: {
    // 计算剩余天数
    calculateDays(date) {
      if (!date) {
        this.remainingDays = null;
        return;
      }
      
      const exam = new Date(date);
      const today = new Date();
      today.setHours(0, 0, 0, 0);
      exam.setHours(0, 0, 0, 0);
      
      const diff = exam - today;
      this.remainingDays = Math.ceil(diff / (1000 * 60 * 60 * 24));
      
      // 保存到本地存储
      localStorage.setItem('zhi_xin_exam_date', date);
      
      // 如果考试已过期
      if (this.remainingDays < 0) {
        this.$modal.msgWarning('考试日期已过，请重新选择');
        this.examDate = null;
        this.remainingDays = null;
        localStorage.removeItem('zhi_xin_exam_date');
      }
    },
    
    // 焚烧烦恼
    burnWorries() {
      if (!this.worryText) return;
      
      this.isBurning = true;
      this.burnComplete = false;
      
      // 生成粒子
      this.generateParticles();
      
      // 3秒后完成
      setTimeout(() => {
        this.isBurning = false;
        this.burnComplete = true;
        this.worryText = '';
        this.particles = [];
        
        this.$modal.msgSuccess('烦恼已焚烧殆尽，愿你轻松前行！');
        
        // 3秒后隐藏成功提示
        setTimeout(() => {
          this.burnComplete = false;
        }, 3000);
      }, 3000);
    },
    
    // 生成燃烧粒子
    generateParticles() {
      const chars = this.worryText.split('');
      this.particles = chars.map((char, index) => ({
        char,
        style: {
          left: `${Math.random() * 80 + 10}%`,
          animationDelay: `${Math.random() * 1}s`,
          animationDuration: `${1.5 + Math.random()}s`
        }
      }));
    }
  }
};
</script>

<style scoped>
/* 全局容器 */
.reducepres-wrapper {
  background: linear-gradient(180deg, #E8F4F8 0%, #F5F7FA 100%);
  min-height: 100vh;
  padding-bottom: 80px;
  font-family: 'PingFang SC', sans-serif;
  max-width: 768px;
  margin: 0 auto;
}

/* 顶部导航 */
.header {
  padding: 15px 20px;
  background: linear-gradient(135deg, #4D869C 0%, #7AB2B2 100%);
  display: flex;
  align-items: center;
  justify-content: space-between;
  color: white;
  position: sticky;
  top: 0;
  z-index: 100;
}

.back-btn {
  font-size: 20px;
  cursor: pointer;
  padding: 5px;
  width: 30px;
}

.title {
  font-size: 18px;
  font-weight: bold;
}

.placeholder {
  width: 40px;
}

/* 倒计时区域 */
.countdown-section {
  padding: 20px 15px 10px;
}

.countdown-card {
  background: white;
  border-radius: 16px;
  padding: 20px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
  text-align: center;
}

.exam-date-picker {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  margin-bottom: 15px;
  flex-wrap: wrap;
}

.exam-date-picker .label {
  font-size: 14px;
  color: #606266;
}

.days-display {
  display: flex;
  align-items: baseline;
  justify-content: center;
  margin-top: 10px;
}

.days-number {
  font-size: 72px;
  font-weight: bold;
  line-height: 1;
}

.days-unit {
  font-size: 24px;
  color: #909399;
  margin-left: 5px;
}

.days-placeholder {
  padding: 30px 0;
  color: #909399;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
}

.days-placeholder i {
  font-size: 40px;
}

/* 天数颜色 */
.days-relax { color: #67C23A; }
.days-warning { color: #E6A23C; }
.days-urgent { color: #F56C6C; }

/* 建议区域 */
.advice-section {
  padding: 10px 15px;
}

.advice-card {
  background: white;
  border-radius: 16px;
  padding: 20px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
  border-left: 4px solid;
}

.advice-relax { border-left-color: #67C23A; }
.advice-warning { border-left-color: #E6A23C; }
.advice-urgent { border-left-color: #F56C6C; }

.advice-icon {
  font-size: 40px;
  text-align: center;
  margin-bottom: 10px;
}

.advice-title {
  font-size: 18px;
  font-weight: bold;
  color: #303133;
  text-align: center;
  margin-bottom: 12px;
}

.advice-content {
  font-size: 14px;
  color: #606266;
  line-height: 1.8;
  margin-bottom: 15px;
  text-align: justify;
}

.advice-tips {
  background: #F8F9FA;
  border-radius: 8px;
  padding: 12px 15px;
}

.tip-item {
  font-size: 13px;
  color: #606266;
  padding: 5px 0;
  display: flex;
  align-items: center;
  gap: 6px;
}

.tip-item i {
  color: #7AB2B2;
}

/* 烧纸区域 */
.burn-section {
  padding: 10px 15px 20px;
}

.burn-card {
  background: white;
  border-radius: 16px;
  padding: 20px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
}

.burn-header {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 16px;
  font-weight: bold;
  color: #F56C6C;
  margin-bottom: 8px;
}

.burn-desc {
  font-size: 12px;
  color: #909399;
  margin-bottom: 15px;
}

.burn-input-wrapper {
  position: relative;
  margin-bottom: 15px;
}

.burn-textarea {
  width: 100%;
  min-height: 120px;
  padding: 12px;
  border: 1px solid #DCDFE6;
  border-radius: 8px;
  font-size: 14px;
  line-height: 1.6;
  resize: vertical;
  font-family: inherit;
  box-sizing: border-box;
  background: #FDF6F5;
  transition: all 0.3s;
}

.burn-textarea:focus {
  outline: none;
  border-color: #F56C6C;
  box-shadow: 0 0 0 2px rgba(245, 108, 108, 0.1);
}

.burn-textarea:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

/* 粒子效果 */
.particles-container {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  pointer-events: none;
  overflow: hidden;
}

.particle {
  position: absolute;
  bottom: 10px;
  font-size: 16px;
  color: #F56C6C;
  animation: burnUp linear forwards;
  opacity: 0;
}

@keyframes burnUp {
  0% {
    transform: translateY(0) scale(1) rotate(0deg);
    opacity: 1;
    filter: brightness(1);
  }
  50% {
    transform: translateY(-60px) scale(1.2) rotate(180deg);
    opacity: 0.8;
    filter: brightness(1.5) sepia(1) hue-rotate(-30deg) saturate(3);
  }
  100% {
    transform: translateY(-120px) scale(0.3) rotate(360deg);
    opacity: 0;
    filter: brightness(2) sepia(1) hue-rotate(-50deg) saturate(5);
  }
}

.burn-btn {
  width: 100%;
  height: 44px;
  font-size: 16px;
  letter-spacing: 2px;
  background: linear-gradient(135deg, #F56C6C 0%, #E6A23C 100%);
  border: none;
}

.burn-btn:disabled {
  background: #C0C4CC;
}

.burn-success {
  margin-top: 15px;
  padding: 12px;
  background: #F0F9EB;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  color: #67C23A;
  font-size: 14px;
  animation: fadeIn 0.5s;
}

.burn-success i {
  font-size: 20px;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(-10px); }
  to { opacity: 1; transform: translateY(0); }
}

/* 底部 TabBar */
.tab-bar {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  height: 65px;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(15px);
  display: flex;
  justify-content: space-around;
  align-items: center;
  box-shadow: 0 -5px 20px rgba(0, 0, 0, 0.05);
  z-index: 999;
  max-width: 768px;
  margin: 0 auto;
}

.tab-item {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  color: #B0BEC5;
  cursor: pointer;
  transition: color 0.3s;
}

.tab-item i {
  font-size: 22px;
  margin-bottom: 4px;
}

.tab-item span {
  font-size: 10px;
}

.tab-item.active {
  color: #7AB2B2;
}
</style>
