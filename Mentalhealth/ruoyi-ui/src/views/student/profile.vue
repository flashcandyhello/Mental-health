<template>
  <div class="student-wrapper">
    <div class="profile-header">
      <div class="avatar">
        <img :src="avatar" alt="avatar" onerror="this.src='https://api.dicebear.com/7.x/avataaars/svg?seed=Felix'">
      </div>
      <div class="user-name">{{ user.nickName || '李明同学' }}</div>
      <div class="user-dept">{{ user.deptName || '书法' }}</div>
      
      <div class="stats-row">
        <div class="stat-item">
          <div class="stat-num">{{ stats.diaryCount }}</div>
          <div class="stat-label">日记篇数</div>
        </div>
        <div class="stat-item">
          <div class="stat-num">{{ stats.badgeCount }}</div>
          <div class="stat-label">获得勋章</div>
        </div>
        <div class="stat-item">
          <div class="stat-num">{{ stats.careCount }}</div>
          <div class="stat-label">干预记录</div>
        </div>
      </div>
    </div>

    <div class="badge-section">
      <div class="section-title">我的成就徽章</div>
      <div class="badge-grid">
        <div class="badge-item" 
             v-for="(badge, index) in badges" 
             :key="index"
             :class="{ unlocked: badge.isUnlocked }">
          <span class="badge-icon">{{ badge.icon }}</span>
          <div class="badge-name">{{ badge.name }}</div>
        </div>
      </div>
    </div>

    <div class="menu-list">
      <div class="menu-item" @click="goToChangePwd">
        <i class="el-icon-lock item-icon"></i>
        <span class="item-text">修改密码</span>
        <i class="el-icon-arrow-right item-arrow"></i>
      </div>
      
      <div class="menu-item" @click="handleHelpOthers" v-if="!hasRequestedHelp">
        <i class="el-icon-service item-icon" style="color: #67C23A;"></i>
        <span class="item-text" style="color: #67C23A;">我更想帮助他人</span>
        <i class="el-icon-arrow-right item-arrow"></i>
      </div>
      
      <div class="menu-item" v-else>
        <i class="el-icon-service item-icon" style="color: #C0C4CC;"></i>
        <span class="item-text" style="color: #C0C4CC;">已收到您的意向，请等待管理员同意</span>
      </div>
      
      <div class="menu-item" style="color: #F56C6C;" @click="handleLogout">
        <i class="el-icon-switch-button item-icon" style="color: #F56C6C;"></i>
        <span class="item-text">退出登录</span>
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
      <div class="tab-item" @click="$router.push('/student/reducepres')">
        <i class="el-icon-timer"></i>
        <span>考前减压</span>
      </div>
      <div class="tab-item" @click="$router.push('/student/square')">
        <i class="el-icon-chat-square"></i>
        <span>广场</span>
      </div>
      <div class="tab-item active">
        <i class="el-icon-user"></i>
        <span>我的</span>
      </div>
    </div>

    <el-dialog 
      title="修改密码" 
      :visible.sync="pwdOpen" 
      width="90%" 
      append-to-body 
      center
      custom-class="mobile-dialog"
    >
      <el-form ref="pwdForm" :model="pwdForm" :rules="pwdRules" label-width="80px">
        <el-form-item label="旧密码" prop="oldPassword">
          <el-input v-model="pwdForm.oldPassword" placeholder="请输入旧密码" type="password" show-password />
        </el-form-item>
        <el-form-item label="新密码" prop="newPassword">
          <el-input v-model="pwdForm.newPassword" placeholder="请输入新密码" type="password" show-password />
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input v-model="pwdForm.confirmPassword" placeholder="请确认新密码" type="password" show-password />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="pwdOpen = false" size="small">取 消</el-button>
        <el-button type="primary" @click="submitPwd" size="small">确 定</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import { mapGetters } from "vuex";
import { listDiary } from "@/api/system/diary";
import { listRecord } from "@/api/system/record";
// 引入你在 user.js 里看到的接口
import { getUserProfile, updateUserProfile, updateUserPwd } from "@/api/system/user"; 

export default {
  name: "StudentProfile",
  data() {
    // 密码校验规则
    const confirmPassword = (rule, value, callback) => {
      if (value !== this.pwdForm.newPassword) {
        callback(new Error('两次输入的密码不一致'));
      } else {
        callback();
      }
    };
    
    return {
      hasRequestedHelp: false,
      realDeptName: '',
      // 弹窗控制
      pwdOpen: false,
      pwdForm: {
        oldPassword: '',
        newPassword: '',
        confirmPassword: ''
      },
      pwdRules: {
        oldPassword: [
          { required: true, message: "请输入旧密码", trigger: "blur" }
        ],
        newPassword: [
          { required: true, message: "请输入新密码", trigger: "blur" },
          { min: 6, max: 20, message: "长度在 6 到 20 个字符", trigger: "blur" }
        ],
        confirmPassword: [
          { required: true, message: "请再次输入新密码", trigger: "blur" },
          { validator: confirmPassword, trigger: "blur" }
        ]
      },

      stats: {
        diaryCount: 0,
        badgeCount: 0,
        careCount: 0
      },
      badges: [
        { name: '初次见面', icon: '🌱', isUnlocked: true },
        { name: '月度全勤', icon: '📅', isUnlocked: false } 
      ]
    };
  },
  computed: {
    ...mapGetters(["avatar", "name", "nickName"]),
    
    currentUserId() {
      return this.$store.state.user.userId || this.$store.state.user.id;
    },
    
    user() {
      return {
        nickName: this.$store.state.user.nickName || this.name,
        deptName: this.realDeptName || (this.$store.state.user.dept ? this.$store.state.user.dept.deptName : '暂无部门')
      }
    }
  },
  created() {
    this.getRealStats();
    getUserProfile().then(res => {
      if (res && res.data) {
        if (res.data.remark === 'help_others') {
          this.hasRequestedHelp = true;
        }
        if (res.data.dept) {
          this.realDeptName = res.data.dept.deptName;
        }
      }
    });
  },
  methods: {
    getRealStats() {
      this.stats.badgeCount = this.badges.filter(b => b.isUnlocked).length;
      if (this.currentUserId) {
        listDiary({ pageNum: 1, pageSize: 1, userId: this.currentUserId }).then(res => {
          this.stats.diaryCount = res.total;
        });
        listRecord({ pageNum: 1, pageSize: 1000, studentName: this.currentUserId }).then(res => {
          const list = res.rows || [];
          let count = 0;
          list.forEach(item => {
            if (item.aiSuggestion) count++;
            if (item.content) count++;
          });
          this.stats.careCount = count;
        });
      }
    },

    handleHelpOthers() {
      this.$alert("请等待管理员同意", "提示", {
        type: "success"
      }).then(() => {
        const userToUpdate = {
          userId: this.currentUserId,
          remark: 'help_others'
        };
        updateUserProfile(userToUpdate).then(() => {
          this.hasRequestedHelp = true;
        });
      });
    },

    // 打开修改密码弹窗
    goToChangePwd() {
      this.resetForm("pwdForm");
      this.pwdForm = { oldPassword: '', newPassword: '', confirmPassword: '' };
      this.pwdOpen = true;
    },

    // 提交密码修改
    submitPwd() {
      this.$refs["pwdForm"].validate(valid => {
        if (valid) {
          updateUserPwd(this.pwdForm.oldPassword, this.pwdForm.newPassword).then(response => {
            this.$modal.msgSuccess("修改成功，请重新登录");
            this.pwdOpen = false;
            setTimeout(() => {
              this.$store.dispatch('LogOut').then(() => {
                this.$router.push('/login');
              });
            }, 1500);
          });
        }
      });
    },

    resetForm(refName) {
      if (this.$refs[refName]) {
        this.$refs[refName].resetFields();
      }
    },

    async handleLogout() {
      this.$confirm('确定注销并退出系统吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$store.dispatch('LogOut').then(() => {
          this.$router.push('/login'); 
        });
      }).catch(() => {});
    }
  }
};
</script>

<style scoped>
/* 样式保持不变 */
.student-wrapper {
  background-color: #EEF7FF;
  min-height: 100vh;
  padding-bottom: 80px;
  font-family: 'PingFang SC', sans-serif;
  max-width: 480px; 
  margin: 0 auto;
}

.profile-header {
    background: linear-gradient(180deg, #FFFFFF 0%, #F5F7FA 100%);
    padding: 40px 20px 30px; text-align: center;
    border-radius: 0 0 30px 30px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.05); margin-bottom: 20px;
}
.avatar {
    width: 80px; height: 80px; background: #ddd; border-radius: 50%;
    margin: 0 auto 15px; border: 4px solid white;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1); overflow: hidden;
}
.avatar img { width: 100%; height: 100%; object-fit: cover; }
.user-name { font-size: 20px; font-weight: bold; margin-bottom: 5px; color: #333; }
.user-dept { font-size: 13px; color: #888; }

.stats-row { display: flex; justify-content: center; gap: 40px; margin-top: 25px; }
.stat-item { text-align: center; }
.stat-num { font-size: 18px; font-weight: bold; color: #7AB2B2; }
.stat-label { font-size: 11px; color: #999; margin-top: 2px; }

.badge-section {
    background: white; margin: 0 20px 20px; border-radius: 16px; padding: 20px;
}
.section-title { font-size: 15px; font-weight: bold; margin-bottom: 15px; color: #333; }
.badge-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; }
.badge-item { text-align: center; opacity: 0.4; filter: grayscale(100%); }
.badge-item.unlocked { opacity: 1; filter: grayscale(0%); }
.badge-icon { font-size: 28px; margin-bottom: 5px; display: inline-block; }
.badge-name { font-size: 10px; color: #666; }

.menu-list {
    background: white; margin: 0 20px; border-radius: 16px; overflow: hidden;
}
.menu-item {
    padding: 15px 20px; display: flex; align-items: center;
    border-bottom: 1px solid #f5f5f5; cursor: pointer;
}
.menu-item:last-child { border-bottom: none; }
.item-icon { width: 30px; font-size: 18px; color: #606266; }
.item-text { flex: 1; font-size: 14px; color: #333; }
.item-arrow { color: #ccc; font-size: 14px; }

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
.tab-item.active { color: #7AB2B2; }

/* 弹窗样式微调 */
::v-deep .mobile-dialog {
  border-radius: 12px;
  max-width: 400px; 
}
::v-deep .el-dialog__body {
  padding: 20px 20px 0;
}
</style>