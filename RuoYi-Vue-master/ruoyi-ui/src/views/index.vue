<template>
  <div class="dashboard-editor-container">
    
    <panel-group :panel-data="statsData" />

    <el-row :gutter="32">
      <el-col :xs="24" :sm="24" :lg="16">
        <div class="chart-wrapper">
          <div class="chart-title">📈 全校情绪波动趋势 (近7日)</div>
          <line-chart :chart-data="lineChartData" />
        </div>
      </el-col>

      <el-col :xs="24" :sm="24" :lg="8">
        <div class="chart-wrapper">
          <div class="chart-title">☁️ 学生高频困扰词云</div>
          <word-cloud :chart-data="wordCloudData" height="350px"/>
        </div>
      </el-col>
    </el-row>

    <el-row :gutter="32">
      <el-col :xs="24" :sm="24" :lg="8">
        <div class="chart-wrapper">
          <div class="chart-title">📊 心理健康等级分布</div>
          <pie-chart />
        </div>
      </el-col>
    </el-row>

  </div>
</template>

<script>
// 👇 注意这里：加了 'dashboard/' 前缀，告诉系统去 dashboard 文件夹里找组件
import PanelGroup from './dashboard/PanelGroup'
import LineChart from './dashboard/LineChart'
import WordCloud from './dashboard/WordCloud'
import PieChart from './dashboard/PieChart'
// 1. 引入刚才定义的 API 方法
import { getDashboardData } from '@/api/system/diary'

export default {
  name: 'DashboardAdmin',
  components: {
    PanelGroup,
    LineChart,
    WordCloud,
    PieChart
  },
  data() {
    return {
      // 这里的初始值可以设为0，等待接口加载
      statsData: {
        riskCount: 0,
        todoCount: 0,
        aiCount: 0, 
        totalCount: 0
      },
      lineChartData: {
        expectedData: [],
        actualData: []
      },
      wordCloudData: []
    }
  },
  created() {
    // 2. 页面加载时，立即调用接口
    this.fetchData();
  },
  methods: {
    fetchData() {
      // 3. 发送请求给后端
      getDashboardData().then(response => {

        console.log("驾驶舱数据加载成功:", response);
        // 👇 绑定后端返回的真实数据
        this.statsData.riskCount = response.riskCount;
        // this.statsData.todoCount = response.todoCount; // 这个也可以用，如果你想在某个地方显示
        
        this.statsData.studentCount = response.studentCount;         // 对应后端 ajax.put("studentCount", ...)
        this.statsData.aiCount = response.aiCount;                   // 对应后端 ajax.put("aiCount", ...)
        this.statsData.interventionCount = response.interventionCount; // 对应后端 ajax.put("interventionCount", ...)
        // 4. 将后端返回的数据填充到页面变量中
        // 注意：这里 response.xxx 要和你后端 AjaxResult.put("key", val) 里的 key 保持一致
        this.statsData.riskCount = response.riskCount;
        this.statsData.todoCount = response.todoCount;
        
      

        // 填充折线图 (response.trend 包含 dates 和 scores)
        if (response.trend) {
          this.lineChartData.actualData = response.trend.scores;
          
          // ✅ 修改方案：将红色线改为固定的“80分健康基准线”
          // 这样，当蓝色线跌破红色线时，就代表全校情绪异常
          this.lineChartData.expectedData = new Array(response.trend.scores.length).fill(80);
        }

        // 填充词云
        this.wordCloudData = response.words || [];
      }).catch(err => {
        console.error("数据获取失败:", err);
      });
    }
  }
}
</script>

<style lang="scss" scoped>
.dashboard-editor-container {
  padding: 32px;
  background-color: #f0f2f5;
  position: relative;
  min-height: 100vh;

  .chart-wrapper {
    background: #fff;
    padding: 16px 16px 0;
    margin-bottom: 32px;
    border-radius: 8px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  }
  
  .chart-title {
    font-size: 16px;
    font-weight: bold;
    color: #333;
    margin-bottom: 15px;
    border-left: 4px solid #409EFF;
    padding-left: 10px;
  }
}
</style>