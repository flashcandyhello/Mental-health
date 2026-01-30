<template>
  <div :class="className" :style="{height:height,width:width}" />
</template>

<script>
import * as echarts from 'echarts'
require('echarts/theme/macarons') // echarts theme
import resize from './mixins/resize'

export default {
  mixins: [resize],
  props: {
    className: {
      type: String,
      default: 'chart'
    },
    width: {
      type: String,
      default: '100%'
    },
    height: {
      type: String,
      default: '300px'
    }
  },
  data() {
    return {
      chart: null
    }
  },
  mounted() {
    this.$nextTick(() => {
      this.initChart()
    })
  },
  beforeDestroy() {
    if (!this.chart) {
      return
    }
    this.chart.dispose()
    this.chart = null
  },
  methods: {
    initChart() {
      this.chart = echarts.init(this.$el, 'macarons')

      this.chart.setOption({
        tooltip: {
          trigger: 'item',
          formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        legend: {
          left: 'center',
          bottom: '10',
          data: ['Industries', 'Technology', 'Forex', 'Gold', 'Forecasts']
        },
        series: [
                  {
            name: '心理健康分布',
            type: 'pie',
            radius: ['50%', '70%'], // 环形图看起来更高级
            avoidLabelOverlap: false,
            label: { show: false, position: 'center' },
            emphasis: { label: { show: true, fontSize: '20', fontWeight: 'bold' } },
            data: [
              { value: 950, name: '状态良好', itemStyle: { color: '#67C23A' } }, // 绿色
              { value: 200, name: '轻度波动', itemStyle: { color: '#E6A23C' } }, // 橙色
              { value: 55, name: '高危预警', itemStyle: { color: '#F56C6C' } }  // 红色
            ]
          }
        ]
      })
    }
  }
}
</script>
