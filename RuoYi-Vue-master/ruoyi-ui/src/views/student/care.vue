<template>
  <div class="student-wrapper">
    <div class="nav-bar">
      <div class="back-btn" @click="$router.push('/student/index')"><i class="el-icon-arrow-left"></i></div>
      <div class="page-title">暖心信箱</div>
    </div>

    <div class="container" v-loading="loading">
      <div class="empty-state" v-if="displayList.length === 0">
        <i class="el-icon-message-solid" style="font-size: 50px; color: #ddd; margin-bottom: 20px;"></i>
        <p>目前没有新的消息，保持好心情哦~</p>
      </div>

      <div class="care-card" 
           v-for="(item, index) in displayList" 
           :key="index"
           :class="item.type === 'teacher' ? 'type-human' : 'type-ai'">
          
          <div class="card-header">
              <span class="source-tag" :class="item.type === 'teacher' ? 'tag-human' : 'tag-ai'">
                  <i :class="item.type === 'teacher' ? 'el-icon-user-solid' : 'el-icon-cpu'"></i>
                  {{ item.type === 'teacher' ? '老师留言' : 'AI 建议' }}
              </span>
              <span class="date-text">{{ parseTime(item.createTime, '{m}-{d} {h}:{i}') }}</span>
          </div>

          <div class="ref-diary" v-if="item.riskLevel">
              风险评估：
              <span v-if="item.riskLevel == '1'" style="color: #67C23A">状态良好</span>
              <span v-else-if="item.riskLevel == '2'" style="color: #409EFF">一般关注</span>
              <span v-else-if="item.riskLevel == '3'" style="color: #E6A23C">重点关注</span>
              <span v-else-if="item.riskLevel == '4'" style="color: #F56C6C">紧急干预</span>
          </div>

          <!-- 内容区域 -->
          <div class="care-content" v-html="formatContent(item.content)"></div>

          <div class="card-footer">
              <span style="font-size:12px; color:#999; margin-right:10px;">
                  <i class="el-icon-check"></i> 
                  {{ item.type === 'teacher' ? '来自心理中心' : '来自系统自动分析' }}
              </span>
              
              <el-button v-if="item.type === 'teacher'" 
                      size="mini"
                      type="warning" 
                      plain
                      round
                      :loading="item.loading"
                      @click="handleBook(item)">
                  预约咨询
              </el-button>
          </div>
      </div>
    </div>
  </div>
</template>

<script>
// 修改点 1：引入 updateRecord 接口
import { listRecord, updateRecord } from "@/api/system/record";
import { parseTime } from "@/utils/ruoyi";
import { mapGetters } from "vuex";

export default {
  name: "StudentCare",
  data() {
    return {
      loading: false,
      displayList: []
    };
  },
  computed: {
    ...mapGetters(["nickName", "userId"])
  },
  created() {
    this.getList();
  },
  methods: {
    parseTime,
    
    getList() {
      this.loading = true;
      const queryParams = {
        pageNum: 1,
        pageSize: 20,
        studentName: this.userId
      };

      listRecord(queryParams).then(res => {
        const rawList = res.rows || [];
        this.processData(rawList);
        this.loading = false;
      }).catch(() => {
        this.loading = false;
      });
    },

    processData(list) {
      const result = [];
      list.forEach(record => {
        if (record.aiSuggestion) {
          result.push({
            type: 'ai',
            content: record.aiSuggestion,
            createTime: record.createTime,
            riskLevel: record.riskLevel
          });
        }
        
        if (record.content) {
          result.push({
            // 修改点 2：必须保存 recordId，否则无法更新
            recordId: record.recordId, 
            type: 'teacher',
            content: record.content,
            createTime: record.createTime,
            riskLevel: record.riskLevel,
            loading: false // 按钮防抖状态
          });
        }
      });

      result.sort((a, b) => new Date(b.createTime) - new Date(a.createTime));
      this.displayList = result;
    },

    formatContent(text) {
      if (!text) return '';
      return text.replace(/\n/g, '<br>');
    },

    // 修改点 4：简单的提醒实现逻辑
    handleBook(item) {
      this.$confirm('确定要向老师发起【预约咨询】申请吗？老师将收到系统提醒。', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        // 开启按钮 loading
        this.$set(item, 'loading', true);

        // 构造提醒标记 (红色加粗字体)
        const noticeTag = `\n<br><br><span style="color:#F56C6C;font-weight:bold;">【系统提醒】学生于 ${this.parseTime(new Date())} 点击了“预约咨询”，请及时联系。</span>`;
        
        // 核心逻辑：
        // 1. 追加内容到 content
        // 2. 将状态 status 改回 '0' (待处理)，这样老师列表里会变红，起到提醒作用
        const data = {
          recordId: item.recordId,
          content: item.content + noticeTag,
          status: '0' 
        };

        updateRecord(data).then(response => {
          this.$modal.msgSuccess("预约申请已发送！老师会尽快联系您。");
          // 刷新列表以显示最新状态
          this.getList();
        }).finally(() => {
          this.$set(item, 'loading', false);
        });
      }).catch(() => {});
    },

    msg(text) {
      this.$modal.msgSuccess(text);
    }
  }
};
</script>

<style scoped>
/* 样式保持不变 */
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
    background: rgba(255,255,255,0.9);
    position: sticky; top: 0; z-index: 100;
    display: flex; align-items: center;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}
.back-btn { font-size: 20px; color: #333; cursor: pointer; padding: 5px; width: 30px;}
.page-title { flex: 1; text-align: center; font-weight: bold; font-size: 18px; margin-right: 30px; color: #4D869C;}

.container { padding: 20px; }

.care-card {
    background: white; border-radius: 16px; padding: 20px; margin-bottom: 20px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.03); position: relative; overflow: hidden;
}

.type-ai { border-left: 5px solid #81C784; }
.type-human { border-left: 5px solid #FF8A65; background: #FFFBF7; }

.card-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
.source-tag { font-size: 12px; padding: 4px 10px; border-radius: 20px; font-weight: bold; display: flex; align-items: center; gap: 5px; }
.tag-ai { background: #E8F5E9; color: #2E7D32; }
.tag-human { background: #FFCCBC; color: #BF360C; }
.date-text { font-size: 12px; color: #999; }

.ref-diary { font-size: 12px; color: #666; background: #F5F5F5; padding: 8px; border-radius: 8px; margin-bottom: 15px; }
.care-content { font-size: 15px; line-height: 1.6; color: #444; margin-bottom: 15px; white-space: pre-wrap; }
.card-footer { border-top: 1px solid #eee; padding-top: 12px; display: flex; justify-content: space-between; align-items: center; }
.empty-state { text-align: center; margin-top: 100px; color: #999; }
</style>