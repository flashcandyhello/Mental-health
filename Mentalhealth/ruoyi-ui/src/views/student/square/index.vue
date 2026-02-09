<template>
  <div class="square-wrapper">
    <!-- 顶部标题栏 -->
    <div class="header">
      <div class="back-btn" @click="$router.push('/student/index')"><i class="el-icon-arrow-left"></i></div>
      <div class="title-section">
        <div class="main-title">匿名广场</div>
        <div class="sub-title">给陌生的TA一个温暖的抱抱</div>
      </div>
      <div class="placeholder"></div>
    </div>

    <!-- 帖子列表 -->
    <div class="post-list" v-loading="loading">
      <div v-if="postList.length === 0" class="empty-state">
        <i class="el-icon-chat-dot-round" style="font-size: 50px; margin-bottom: 15px;"></i>
        <p>广场还没有公开的日记，来做第一个分享的人吧~</p>
      </div>

      <el-row :gutter="16">
        <el-col 
          :xs="24" 
          :sm="12" 
          :md="8" 
          v-for="(item, index) in postList" 
          :key="item.id"
          class="post-col"
        >
          <el-card class="post-card" shadow="hover">
            <!-- 内容区域 -->
            <div class="post-content">
              {{ item.content }}
            </div>
            
            <!-- 底部信息栏 -->
            <div class="post-footer">
              <div class="post-meta">
                <span class="author-tag">一位{{ item.anonymousTag || '同学' }}</span>
                <span class="post-time">{{ parseTime(item.createTime, '{m}-{d} {h}:{i}') }}</span>
              </div>
              <div class="hug-section">
                <el-button 
                  type="text" 
                  class="hug-btn"
                  :disabled="item.hugged"
                  @click="handleHug(item)"
                >
                  <i :class="item.hugged ? 'el-icon-check' : 'el-icon-s-promotion'"></i>
                  <span>{{ item.hugCount || 0 }}</span>
                </el-button>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>

      <!-- 分页 -->
      <div class="pagination-wrapper" v-if="total > 0">
        <el-pagination
          background
          layout="total, sizes, prev, pager, next"
          :total="total"
          :page-size="pageSize"
          :page-sizes="[10, 20, 30, 50]"
          :current-page.sync="pageNum"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
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
      <div class="tab-item" @click="$router.push('/student/reducepres')">
        <i class="el-icon-timer"></i>
        <span>考前减压</span>
      </div>
      <div class="tab-item active">
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
import { parseTime } from "@/utils/ruoyi";
import request from '@/utils/request'

export default {
  name: "StudentSquare",
  data() {
    return {
      loading: false,
      postList: [],
      total: 0,
      pageNum: 1,
      pageSize: 10
    };
  },
  created() {
    this.getList();
  },
  methods: {
    parseTime,
    
    /** 获取广场帖子列表 */
    getList() {
      this.loading = true;
      request({
        url: '/api/square/list',
        method: 'get',
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize
        }
      }).then(res => {
        const data = res.data;
        // 标记已抱抱的帖子
        this.postList = (data.list || []).map(item => ({
          ...item,
          hugged: this.checkIfHugged(item.id)
        }));
        this.total = data.total || 0;
        this.loading = false;
      }).catch(() => {
        this.loading = false;
      });
    },

    /** 抱抱帖子 */
    handleHug(row) {
      if (row.hugged) {
        return;
      }
      
      request({
        url: '/api/square/hug/' + row.id,
        method: 'post'
      }).then(res => {
        row.hugCount = res.data;
        row.hugged = true;
        
        // 保存到 localStorage
        this.saveToLocal(row.content);
        this.markAsHugged(row.id);
        
        this.$modal.msgSuccess("已送出温暖的抱抱~");
      }).catch(() => {
        this.$modal.msgError("抱抱失败，请稍后再试");
      });
    },

    /** 检查是否已经抱抱过 */
    checkIfHugged(postId) {
      const huggedPosts = JSON.parse(localStorage.getItem('zhi_xin_hugged_posts') || '[]');
      return huggedPosts.includes(postId);
    },

    /** 标记为已抱抱 */
    markAsHugged(postId) {
      const huggedPosts = JSON.parse(localStorage.getItem('zhi_xin_hugged_posts') || '[]');
      if (!huggedPosts.includes(postId)) {
        huggedPosts.push(postId);
        localStorage.setItem('zhi_xin_hugged_posts', JSON.stringify(huggedPosts));
      }
    },

    /** 保存内容到 localStorage */
    saveToLocal(content) {
      const key = 'received_warmth_' + Date.now();
      localStorage.setItem(key, content);
      
      // 获取所有相关的 key
      const allKeys = Object.keys(localStorage).filter(k => k.startsWith('received_warmth_'));
      
      // 如果超过10条，删除最早的
      if (allKeys.length > 10) {
        // 按时间戳排序
        allKeys.sort((a, b) => {
          const timeA = parseInt(a.replace('received_warmth_', ''));
          const timeB = parseInt(b.replace('received_warmth_', ''));
          return timeA - timeB;
        });
        
        // 删除最早的
        const keysToRemove = allKeys.slice(0, allKeys.length - 10);
        keysToRemove.forEach(k => localStorage.removeItem(k));
      }
    },

    /** 分页大小变化 */
    handleSizeChange(val) {
      this.pageSize = val;
      this.pageNum = 1;
      this.getList();
    },

    /** 页码变化 */
    handleCurrentChange(val) {
      this.pageNum = val;
      this.getList();
    }
  }
};
</script>

<style scoped>
/* 全局容器 */
.square-wrapper {
  background-color: #F8F9FA;
  min-height: 100vh;
  padding-bottom: 80px;
  font-family: 'PingFang SC', sans-serif;
  max-width: 768px;
  margin: 0 auto;
}

/* 顶部标题栏 */
.header {
  padding: 15px 20px;
  background: linear-gradient(135deg, #7AB2B2 0%, #4D869C 100%);
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

.title-section {
  text-align: center;
  flex: 1;
}

.main-title {
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 4px;
}

.sub-title {
  font-size: 12px;
  opacity: 0.9;
}

.placeholder {
  width: 40px;
}

/* 帖子列表 */
.post-list {
  padding: 20px 15px;
}

.empty-state {
  text-align: center;
  color: #999;
  margin-top: 80px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.post-col {
  margin-bottom: 16px;
}

/* 卡片样式 */
.post-card {
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.post-card:hover {
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
  transform: translateY(-4px);
}

.post-card >>> .el-card__body {
  padding: 16px;
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

/* 内容区域 */
.post-content {
  font-size: 14px;
  line-height: 1.6;
  color: #333;
  margin-bottom: 16px;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  min-height: 63px;
}

/* 底部信息栏 */
.post-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 12px;
  border-top: 1px solid #F0F0F0;
}

.post-meta {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.author-tag {
  font-size: 13px;
  color: #4D869C;
  font-weight: 500;
}

.post-time {
  font-size: 11px;
  color: #999;
}

/* 抱抱按钮 */
.hug-section {
  display: flex;
  align-items: center;
}

.hug-btn {
  padding: 6px 12px;
  border-radius: 20px;
  background: #F0F7F7;
  transition: all 0.3s;
}

.hug-btn:hover:not(:disabled) {
  background: #E0F0F0;
}

.hug-btn >>> span {
  display: flex;
  align-items: center;
  gap: 6px;
}

.hug-btn i {
  font-size: 16px;
  color: #7AB2B2;
}

.hug-btn span:last-child {
  font-size: 14px;
  color: #666;
  font-weight: 500;
}

.hug-btn:disabled {
  background: #F5F5F5;
  cursor: not-allowed;
}

.hug-btn:disabled i {
  color: #999;
}

.hug-btn:disabled span:last-child {
  color: #999;
}

/* 分页 */
.pagination-wrapper {
  margin-top: 30px;
  display: flex;
  justify-content: center;
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

/* 移动端适配 */
@media screen and (max-width: 768px) {
  .post-list {
    padding: 15px 10px;
  }
  
  .post-card >>> .el-card__body {
    padding: 14px;
  }
}
</style>
