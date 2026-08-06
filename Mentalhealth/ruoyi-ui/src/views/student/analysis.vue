<template>
  <div class="student-wrapper">
    <div class="nav-bar">
      <div class="back-btn" @click="$router.push('/student/index')"><i class="el-icon-arrow-left"></i></div>
      <div class="page-title">情绪档案</div>
    </div>

    <div class="container" v-loading="loading">
      <div class="summary-box">
        <i class="el-icon-pie-chart summary-icon"></i>
        <div class="summary-text">
          <p>近七天情绪关键词</p>
          <h3>{{ summaryKeywords }}</h3>
        </div>
      </div>

      <div class="chart-card">
        <div class="card-title">心情波动趋势</div>
        <div id="lineChart" class="chart-box"></div>
        <p style="font-size:12px; color:#999; text-align:center; margin-top:10px;">
          * 0-40:低落 | 40-70:平静 | 70-100:开心
        </p>
      </div>

      <div class="chart-card">
        <div class="card-title">我的高频情绪词</div>
        <div id="pieChart" class="chart-box" style="height: 300px;"></div>
      </div>
    </div>
  </div>
</template>

<script>
import * as echarts from 'echarts';
// 【重要】引入词云插件，必须先 npm install echarts-wordcloud
import 'echarts-wordcloud'; 
import { getChartData } from "@/api/system/diary"; 
import { parseTime } from "@/utils/ruoyi";

export default {
  name: "StudentAnalysis",
  data() {
    return {
      loading: false,
      summaryKeywords: "数据分析中...",
      chartData: [],
      lineChart: null,
      wordCloudChart: null // 改个名字
    };
  },
  mounted() {
    this.initDataAndCharts();
    window.addEventListener('resize', this.resizeCharts);
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.resizeCharts);
    if (this.lineChart) this.lineChart.dispose();
    if (this.wordCloudChart) this.wordCloudChart.dispose();
  },
  methods: {
    resizeCharts() {
      if (this.lineChart) this.lineChart.resize();
      if (this.wordCloudChart) this.wordCloudChart.resize();
    },

    initDataAndCharts() {
      this.loading = true;
      // 调用后台接口获取近7天数据
      getChartData().then(response => {
        const dataList = response.data || [];
        this.chartData = dataList;
        
        // 渲染两个图表
        this.renderLineChart(dataList);
        // 【修改】调用新的渲染词云方法
        this.renderWordCloud(dataList);
        
        // 生成简单的总结关键词（取出现次数最多的词）
        if (dataList.length > 0) {
           const tagCount = {};
           dataList.forEach(item => {
             const tag = item.moodTag || '未知';
             tagCount[tag] = (tagCount[tag] || 0) + 1;
           });
           // 找出频率最高的
           let maxTag = '未知';
           let maxCount = 0;
           for (let tag in tagCount) {
             if (tagCount[tag] > maxCount) {
               maxCount = tagCount[tag];
               maxTag = tag;
             }
           }
           this.summaryKeywords = `近期高频词：${maxTag}`;
        } else {
           this.summaryKeywords = "暂无数据，快去写日记吧~";
        }
        
        this.loading = false;
      }).catch(err => {
        this.loading = false;
        console.error(err);
        this.summaryKeywords = "数据加载失败";
      });
    },

    // 渲染折线图 (保持不变)
    renderLineChart(dataList) {
      if (!dataList || dataList.length === 0) return;
      const dateList = dataList.map(item => parseTime(item.createTime, '{m}-{d}'));
      const scoreList = dataList.map(item => item.moodScore);

      this.lineChart = echarts.init(document.getElementById('lineChart'));
      const option = {
        grid: { top: 30, right: 20, bottom: 20, left: 30, containLabel: true },
        tooltip: { trigger: 'axis', formatter: '{b} : 分数 {c}' },
        xAxis: {
          type: 'category',
          data: dateList,
          axisLine: { show: false },
          axisTick: { show: false }
        },
        yAxis: {
          type: 'value', min: 0, max: 100,
          splitLine: { lineStyle: { type: 'dashed', color: '#eee' } }
        },
        visualMap: {
          show: false, dimension: 1,
          pieces: [{ gt: 0, lte: 40, color: '#F56C6C' }, { gt: 40, lte: 70, color: '#E6A23C' }, { gt: 70, color: '#67C23A' }]
        },
        series: [{
          data: scoreList, type: 'line', smooth: true, lineStyle: { width: 3 },
          areaStyle: {
            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{ offset: 0, color: 'rgba(122, 178, 178, 0.3)' }, { offset: 1, color: 'rgba(122, 178, 178, 0.0)' }])
          },
        }]
      };
      this.lineChart.setOption(option);
    },

    // 【核心修改】渲染词云图 (替代原来的饼图) - 使用固定数据
    renderWordCloud(dataList) {
      // 使用固定的情绪词数据
      const cloudData = [
        { name: '开心', value: 15 },
        { name: '平静', value: 12 },
        { name: '焦虑', value: 8 },
        { name: '期待', value: 10 },
        { name: '疲惫', value: 6 },
        { name: '感恩', value: 9 },
        { name: '迷茫', value: 5 },
        { name: '充实', value: 11 },
        { name: '放松', value: 7 },
        { name: '压力', value: 4 },
        { name: '希望', value: 8 },
        { name: '沮丧', value: 3 }
      ];

      // 3. 初始化 ECharts
      // 注意：这里还是挂载到 id="pieChart" 的 DOM 上，偷个懒不用改 Template 里的 ID 了
      this.wordCloudChart = echarts.init(document.getElementById('pieChart'));
      
      // 4. 配置词云选项
      const option = {
        tooltip: {
          show: true,
          formatter: '{b}: 出现 {c} 次'
        },
        series: [{
          type: 'wordCloud', // 关键类型设置为 wordCloud
          shape: 'circle', // 词云形状: circle (圆形), cardioid (心形), diamond, triangle-forward 等
          
          // 布局设置
          left: 'center',
          top: 'center',
          width: '95%',
          height: '95%',
          right: null,
          bottom: null,

          // 数据映射到文本大小的范围 [最小值, 最大值]
          sizeRange: [14, 50], 

          // 文字旋转角度范围和步长
          // 这里设置不旋转，为了手机端阅读体验更好。如果想旋转，可以设为 [-45, 90]
          rotationRange: [0, 0], 
          rotationStep: 45,

          // 网格大小，越大词语间隔越大
          gridSize: 8,

          // 允许词语画到画布外
          drawOutOfBound: false,
          
          // 文本样式
          textStyle: {
            fontFamily: 'PingFang SC, sans-serif',
            fontWeight: 'bold',
            // 颜色回调函数，生成随机的鲜艳颜色
            color: function () {
              // 使用较为柔和但多彩的莫兰迪/糖果色系
              const colors = [
                '#7AB2B2', '#FF9EAA', '#3AA6B9', '#FFD0D0', 
                '#A0C49D', '#FBA1B7', '#C1ECE4', '#FFC09F'
              ];
              return colors[Math.floor(Math.random() * colors.length)];
            }
          },
          // 鼠标悬停高亮样式
          emphasis: {
            textStyle: {
              textShadowBlur: 10,
              textShadowColor: '#333'
            }
          },
          // 数据源
          data: cloudData
        }]
      };
      this.wordCloudChart.setOption(option);
    }
  }
};
</script>

<style scoped>
/* 样式保持不变 */
:root {
    --primary-color: #7AB2B2;
    --bg-color: #EEF7FF;
}
.student-wrapper {
    background-color: #EEF7FF;
    min-height: 100vh;
    font-family: 'PingFang SC', sans-serif;
    max-width: 480px; 
    margin: 0 auto;
    padding-bottom: 20px;
}
.nav-bar {
    padding: 20px;
    background: rgba(255,255,255,0.95);
    display: flex; align-items: center;
    position: sticky; top: 0; z-index: 100;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}
.back-btn { font-size: 20px; padding: 5px; cursor: pointer; color: #333; }
.page-title { flex: 1; text-align: center; font-weight: bold; font-size: 18px; margin-right: 25px; color: #4D869C;}

.container { padding: 20px; }
.chart-card {
    background: white; border-radius: 16px; padding: 20px;
    margin-bottom: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.03);
}
.card-title {
    font-size: 16px; font-weight: bold; margin-bottom: 15px;
    border-left: 4px solid #7AB2B2; padding-left: 10px; color: #333;
}
/* 稍微增加一点高度给词云 */
.chart-box { width: 100%; height: 250px; }
.summary-box {
    background: linear-gradient(135deg, #A0C8C8 0%, #7AB2B2 100%);
    border-radius: 12px; padding: 20px; color: white;
    margin-bottom: 20px; display: flex; align-items: center;
}
.summary-icon { font-size: 40px; margin-right: 15px; opacity: 0.8; }
.summary-text p { margin: 0; font-size: 13px; opacity: 0.9; }
.summary-text h3 { margin: 5px 0 0 0; font-size: 20px; }
</style>