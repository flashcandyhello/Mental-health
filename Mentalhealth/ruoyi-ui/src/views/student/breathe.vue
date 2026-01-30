<template>
  <div class="student-wrapper">
    <div class="nav-bar">
      <div class="back-btn" @click="$router.push('/student/index')"><i class="el-icon-arrow-left"></i></div>
      <div class="page-title">呼吸放松</div>
    </div>

    <div class="container">
      <div class="breathing-circle-container">
        <div class="circle-outer" :class="{ 'animating': isBreathing }"></div>
        <div class="circle-inner" :class="{ 'animating': isBreathing }">
          <span class="status-text">{{ statusText }}</span>
        </div>
      </div>

      <div class="instruction-text">
        <p v-if="!isBreathing">点击下方按钮开始<br>跟随圆圈节奏呼吸</p>
        <p v-else>{{ instructionDetail }}</p>
      </div>

      <div class="control-area">
        <el-button 
          type="primary" 
          round 
          class="start-btn" 
          @click="toggleBreathing">
          {{ isBreathing ? '停止训练' : '开始深呼吸' }}
        </el-button>
      </div>
    </div>

    <div class="tab-bar">
      <div class="tab-item" @click="$router.push('/student/index')">
        <i class="el-icon-s-home"></i>
        <span>首页</span>
      </div>
      <div class="tab-item" @click="$router.push('/student/diary')">
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
export default {
  name: "StudentBreathe",
  data() {
    return {
      isBreathing: false,
      statusText: "准备", // 圆圈中间的字
      instructionDetail: "保持平静...", // 下方的详细提示
      timer: null,
      cycleStep: 0 // 0:吸气, 1:屏气, 2:呼气
    };
  },
  beforeDestroy() {
    this.stopBreathing();
  },
  methods: {
    toggleBreathing() {
      if (this.isBreathing) {
        this.stopBreathing();
      } else {
        this.startBreathing();
      }
    },
    startBreathing() {
      this.isBreathing = true;
      this.runCycle();
      // 4-2-4 呼吸法循环 (总周期 10秒)
      // 吸气 4s -> 屏气 2s -> 呼气 4s
      this.timer = setInterval(() => {
        this.runCycle();
      }, 10000); 
    },
    runCycle() {
      // 1. 吸气 (0s - 4s)
      this.statusText = "吸气";
      this.instructionDetail = "用鼻子慢慢吸气，感受肺部扩张...";
      
      // 2. 屏气 (4s - 6s)
      setTimeout(() => {
        if (!this.isBreathing) return;
        this.statusText = "屏气";
        this.instructionDetail = "保持住，不要呼气...";
      }, 4000);

      // 3. 呼气 (6s - 10s)
      setTimeout(() => {
        if (!this.isBreathing) return;
        this.statusText = "呼气";
        this.instructionDetail = "用嘴巴缓慢呼气，放松全身...";
      }, 6000);
    },
    stopBreathing() {
      this.isBreathing = false;
      this.statusText = "准备";
      this.instructionDetail = "点击下方按钮开始";
      clearInterval(this.timer);
      this.timer = null;
    }
  }
};
</script>

<style scoped>
/* 基础布局 */
.student-wrapper {
  background-color: #EEF7FF;
  min-height: 100vh;
  font-family: 'PingFang SC', sans-serif;
  max-width: 480px; 
  margin: 0 auto;
  padding-bottom: 80px;
  display: flex;
  flex-direction: column;
}

.nav-bar {
    padding: 20px;
    background: rgba(255,255,255,0.9);
    position: sticky; top: 0; z-index: 100;
    display: flex; align-items: center;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}
.back-btn { font-size: 20px; color: #333; cursor: pointer; padding: 5px; width: 30px;}
.page-title { flex: 1; text-align: center; font-weight: bold; font-size: 18px; margin-right: 30px; color: #4D869C;}

.container {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding-bottom: 50px;
}

/* 呼吸圆圈动画 */
.breathing-circle-container {
  position: relative;
  width: 200px;
  height: 200px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 40px;
}

.circle-inner {
  width: 120px;
  height: 120px;
  background: linear-gradient(135deg, #7AB2B2 0%, #4D869C 100%);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 20px;
  font-weight: bold;
  z-index: 2;
  box-shadow: 0 10px 30px rgba(122, 178, 178, 0.4);
  transition: all 4s ease-in-out; /* 关键：平滑过渡 */
}

.circle-outer {
  position: absolute;
  width: 120px;
  height: 120px;
  background: rgba(122, 178, 178, 0.2);
  border-radius: 50%;
  z-index: 1;
  transition: all 4s ease-in-out;
}

/* 动画状态 */
.circle-inner.animating {
  animation: breathe-inner 10s infinite ease-in-out;
}
.circle-outer.animating {
  animation: breathe-outer 10s infinite ease-in-out;
}

/* 定义 4-2-4 呼吸节奏的关键帧 */
@keyframes breathe-inner {
  0% { transform: scale(1); }       /* 开始吸气 */
  40% { transform: scale(1.5); }    /* 吸气结束 (4s) */
  60% { transform: scale(1.5); }    /* 屏气结束 (2s) */
  100% { transform: scale(1); }     /* 呼气结束 (4s) */
}

@keyframes breathe-outer {
  0% { transform: scale(1); opacity: 0.2; }
  40% { transform: scale(2.2); opacity: 0.1; }
  60% { transform: scale(2.2); opacity: 0.1; }
  100% { transform: scale(1); opacity: 0.2; }
}

.instruction-text {
  text-align: center;
  color: #666;
  font-size: 16px;
  height: 60px;
  margin-bottom: 30px;
  line-height: 1.6;
}

.start-btn {
  width: 180px;
  background-color: #7AB2B2;
  border-color: #7AB2B2;
  font-size: 16px;
  letter-spacing: 2px;
  transition: all 0.3s;
}
.start-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(122, 178, 178, 0.4);
}

/* 底部 TabBar */
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
</style>