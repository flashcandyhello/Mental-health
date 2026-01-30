<template>
  <div :class="className" :style="{height:height,width:width}" />
</template>

<script>
import * as echarts from 'echarts'
import 'echarts-wordcloud'; // 确保你安装了 npm install echarts-wordcloud
import resize from './mixins/resize'

export default {
  mixins: [resize],
  props: {
    className: { type: String, default: 'chart' },
    width: { type: String, default: '100%' },
    height: { type: String, default: '300px' },
    chartData: { type: Array, required: true } // 接收父组件传来的数据
  },
  data() { return { chart: null } },
  watch: {
    chartData: {
      deep: true,
      handler(val) { this.setOptions(val) }
    }
  },
  mounted() {
    this.$nextTick(() => { this.initChart() })
  },
  beforeDestroy() {
    if (!this.chart) { return }
    this.chart.dispose()
    this.chart = null
  },
  methods: {
    initChart() {
      this.chart = echarts.init(this.$el)
      this.setOptions(this.chartData)
    },
    setOptions(data) {
      this.chart.setOption({
        tooltip: { show: true },
        series: [{
          type: 'wordCloud',
          gridSize: 20,
          sizeRange: [12, 50],
          rotationRange: [-45, 90],
          shape: 'circle',
          textStyle: {
            fontFamily: 'sans-serif',
            fontWeight: 'bold',
            color: function () {
              // 随机深色，适合做负面预警
              return 'rgb(' + [
                Math.round(Math.random() * 160),
                Math.round(Math.random() * 160),
                Math.round(Math.random() * 160)
              ].join(',') + ')';
            }
          },
          data: data
        }]
      })
    }
  }
}
</script>