<template>
  <div class="app-container">
    <el-row justify="center" type="flex">
      <el-col :span="16" :xs="24">
        <el-card class="result-card">
          <div slot="header" class="clearfix">
            <span style="font-weight: bold; font-size: 18px;">
              <i class="el-icon-magic-stick"></i> AI 心理分析报告
            </span>
          </div>

          <div class="result-content">
            <div class="score-section">
              <el-progress 
                type="dashboard" 
                :percentage="moodScore" 
                :color="customColors"
                :width="200">
              </el-progress>
              <div class="score-label">心理能量值</div>
            </div>

            <div class="tag-section">
              <el-tag :type="tagType" effect="dark" size="medium">{{ moodTag }}</el-tag>
            </div>

            <div class="advice-box">
              <div class="advice-title">
                <i class="el-icon-chat-line-round"></i> 治愈建议：
              </div>
              <p class="advice-text">{{ aiAdvice }}</p>
            </div>

            <el-divider content-position="center">原始日记</el-divider>
            <div class="original-content">
              "{{ content }}"
            </div>

            <div class="btn-group">
              <el-button type="primary" icon="el-icon-back" @click="goBack">返回首页</el-button>
              <el-button plain icon="el-icon-edit" @click="writeMore">再写一篇</el-button>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: "MoodResult",
  data() {
    return {
      // 这里的 || 表示：如果没传参数，就显示默认值
      moodScore: this.$route.query.score ? parseInt(this.$route.query.score) : 85,
      moodTag: this.$route.query.tag || 'AI分析中...',
      aiAdvice: this.$route.query.advice || '您的心情日记已送达，AI 正在为您生成专属建议。请稍后在列表中查看。',
      content: this.$route.query.content || '未获取到内容',
      
      // 分数颜色：低分红，中分黄，高分绿
      customColors: [
        {color: '#f56c6c', percentage: 50},
        {color: '#e6a23c', percentage: 70},
        {color: '#5cb87a', percentage: 100}
      ]
    };
  },
  computed: {
    tagType() {
      if (this.moodScore < 60) return 'danger';
      if (this.moodScore < 80) return 'warning';
      return 'success';
    }
  },
  methods: {
    goBack() {
      // 这里修改成你实际的列表页路径，通常是 /psychology/diary 或者 /system/mood-diary
      // 如果不知道路径，可以用 this.$router.go(-2) 返回两层
      this.$router.push('/student/index'); 
    },
    writeMore() {
      this.$router.go(-1);
    }
  }
};
</script>

<style scoped>
.result-card {
  margin-top: 20px;
  min-height: 600px;
}
.result-content {
  text-align: center;
  padding: 10px;
}
.score-section {
  margin-bottom: 10px;
}
.score-label {
  margin-top: -10px;
  color: #606266;
  font-size: 14px;
  font-weight: bold;
}
.tag-section {
  margin-bottom: 30px;
}
.advice-box {
  background-color: #f4f4f5;
  border-radius: 8px;
  padding: 20px;
  text-align: left;
  margin: 0 auto 30px auto;
  border-left: 5px solid #909399;
  max-width: 800px;
}
.advice-title {
  font-weight: bold;
  color: #606266;
  margin-bottom: 10px;
}
.advice-text {
  color: #303133;
  line-height: 1.8;
  font-size: 15px;
}
.original-content {
  color: #909399;
  font-style: italic;
  margin-bottom: 30px;
  padding: 0 20px;
}
</style>