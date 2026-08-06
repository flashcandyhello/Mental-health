<template>
  <div class="login">
    <!-- 背景光斑效果 -->
    <div class="background-effects">
      <div class="light-orb orb-1"></div>
      <div class="light-orb orb-2"></div>
      <div class="light-orb orb-3"></div>
    </div>

    <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form">
      <!-- 小熊吉祥物 -->
      <div class="mascot-container">
        <div class="bear">
          <div class="ear left"></div>
          <div class="ear right"></div>
          <div class="face">
            <div class="eye left">
              <div class="pupil" 
                   :style="{ transform: `translate(${pupilPosition.x}px, ${pupilPosition.y}px)` }"></div>
            </div>
            <div class="eye right">
              <div class="pupil" 
                   :style="{ transform: `translate(${pupilPosition.x}px, ${pupilPosition.y}px)` }"></div>
            </div>
            <div class="nose"></div>
            <div class="blush left"></div>
            <div class="blush right"></div>
          </div>
          <div class="paw left" :class="{ 'hide-eyes-left': isTypingPassword }"></div>
          <div class="paw right" :class="{ 'hide-eyes-right': isTypingPassword }"></div>
        </div>
      </div>

<div class="form-header">
      <h2>欢迎回来</h2>
      <p class="subtitle">在这里，我们关心你的每一分情绪。</p>
    </div>
      <el-form-item prop="username">
        <el-input
          v-model="loginForm.username"
          type="text"
          auto-complete="off"
          placeholder="账号"
          class="custom-input"
        >
          <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>
      
      <el-form-item prop="password">
        <el-input
          v-model="loginForm.password"
          type="password"
          auto-complete="off"
          placeholder="密码"
          class="custom-input"
          @focus="isTypingPassword = true"
          @blur="isTypingPassword = false"
          @keyup.enter.native="handleLogin"
        >
          <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>
      
      <el-form-item prop="code" v-if="captchaEnabled">
        <div class="captcha-group">
          <el-input
            v-model="loginForm.code"
            auto-complete="off"
            placeholder="验证码"
            class="custom-input captcha-input"
            @keyup.enter.native="handleLogin"
          >
            <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon" />
          </el-input>
          <div class="captcha-img">
            <img :src="codeUrl" @click="getCode" class="login-code-img"/>
          </div>
        </div>
      </el-form-item>
      
      <div class="options-row">
        <el-checkbox v-model="loginForm.rememberMe">记住密码</el-checkbox>
        <router-link class="link-type" :to="'/register'" v-if="register">立即注册</router-link>
      </div>
      
      <div class="student-portal-link">
        <span 
          @click="handleStudentLogin" 
          class="portal-link-text"
        >
          ✈️ 访问学生心理服务门户
        </span>
      </div>
      
      <el-form-item style="width:100%; margin-bottom: 0;">
        <el-button
          :loading="loading"
          size="medium"
          type="primary"
          class="custom-btn btn-primary"
          @click.native.prevent="handleLogin"
        >
          <span v-if="!loading">登 录</span>
          <span v-else>登 录 中...</span>
        </el-button>
        
        <div style="margin-top: 15px;">
          <a href="/app.apk" target="_blank" style="text-decoration: none; display: block;">
            <el-button class="custom-btn btn-success" style="width:100%;">
              📱 下载安卓客户端
            </el-button>
          </a>
        </div>
      </el-form-item>
    </el-form>
    
    <!-- 底部 -->
    <div class="el-login-footer">
      <span>Copyright © 2024 *****大学 心理健康中心</span>
    </div>
  </div>
</template>

<script>
import { getCodeImg } from "@/api/login"
import Cookies from "js-cookie"
import { encrypt, decrypt } from '@/utils/jsencrypt'
import defaultSettings from '@/settings'

export default {
  name: "Login",
  data() {
    return {
      title: process.env.VUE_APP_TITLE,
      footerContent: defaultSettings.footerContent,
      codeUrl: "",
      loginForm: {
        username: "",
        password: "",
        rememberMe: false,
        code: "",
        uuid: ""
      },
      loginRules: {
        username: [
          { required: true, trigger: "blur", message: "请输入您的账号" }
        ],
        password: [
          { required: true, trigger: "blur", message: "请输入您的密码" }
        ],
        code: [{ required: true, trigger: "change", message: "请输入验证码" }]
      },
      loading: false,
      captchaEnabled: true,
      register: true,
      redirect: undefined,
      // 新增：小熊动画交互状态
      isTypingPassword: false,
      pupilPosition: { x: 0, y: 0 }
    }
  },
  watch: {
    $route: {
      handler: function(route) {
        this.redirect = route.query && route.query.redirect
      },
      immediate: true
    }
  },
  created() {
    this.getCode()
    this.getCookie()
  },
  mounted() {
    // 添加鼠标移动监听，实现眼球跟随效果
    this.handleMouseMove = this.handleMouseMove.bind(this)
    document.addEventListener('mousemove', this.handleMouseMove)
  },
  destroyed() {
    // 移除事件监听，防止内存泄漏
    document.removeEventListener('mousemove', this.handleMouseMove)
  },
  methods: {
    handleMouseMove(event) {
      // 只有在不输入密码时才让眼球跟随鼠标
      if (!this.isTypingPassword) {
        const x = ((event.clientX / window.innerWidth) - 0.5) * 14
        const y = ((event.clientY / window.innerHeight) - 0.5) * 14
        this.pupilPosition = { x, y }
      }
    },
    getCode() {
      getCodeImg().then(res => {
        this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled
        
        
        if (this.captchaEnabled) {
          this.codeUrl = "data:image/gif;base64," + res.img
          this.loginForm.uuid = res.uuid
        }
      })
    },
    getCookie() {
      const username = Cookies.get("username")
      const password = Cookies.get("password")
      const rememberMe = Cookies.get('rememberMe')
      this.loginForm = {
        username: username === undefined ? this.loginForm.username : username,
        password: password === undefined ? this.loginForm.password : decrypt(password),
        rememberMe: rememberMe === undefined ? false : Boolean(rememberMe)
      }
    },
    handleStudentLogin() {
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          this.loading = true;
          // 1. 记住密码逻辑 (复用原逻辑)
          if (this.loginForm.rememberMe) {
            Cookies.set("username", this.loginForm.username, { expires: 30 });
            Cookies.set("password", encrypt(this.loginForm.password), { expires: 30 });
            Cookies.set('rememberMe', this.loginForm.rememberMe, { expires: 30 });
          } else {
            Cookies.remove("username");
            Cookies.remove("password");
            Cookies.remove('rememberMe');
          }
          
          // 2. 执行登录 Action
          this.$store.dispatch("Login", this.loginForm).then(() => {
            // 3. 【核心修改】登录成功后，直接跳转到学生首页，而不是默认首页
            this.$router.push({ path: "/student/index" }).catch(() => {});
          }).catch(() => {
            this.loading = false;
            if (this.captchaEnabled) {
              this.getCode();
            }
          });
        }
      });
    },
    handleLogin() {
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          this.loading = true
          if (this.loginForm.rememberMe) {
            Cookies.set("username", this.loginForm.username, { expires: 30 })
            Cookies.set("password", encrypt(this.loginForm.password), { expires: 30 })
            Cookies.set('rememberMe', this.loginForm.rememberMe, { expires: 30 })
          } else {
            Cookies.remove("username")
            Cookies.remove("password")
            Cookies.remove('rememberMe')
          }
          
          // 1. 执行登录
          this.$store.dispatch("Login", this.loginForm).then(() => {
            
            // 2. 获取用户信息
            this.$store.dispatch("GetInfo").then(res => {
              
              // ================== 【核心修复代码 START】 ==================
              // 3. 手动生成路由表 (修复侧边栏不显示的问题)
              this.$store.dispatch('GenerateRoutes', res).then((accessRoutes) => {
                // 动态添加可访问路由表
                this.$router.addRoutes(accessRoutes) 
                
                // 4. 原有的跳转逻辑
                const roles = res.roles || [];
                if (roles.includes("lower")) {
                  this.$router.push({ path: "/student/index" }).catch(()=>{});
                } else {
                  this.$router.push({ path: this.redirect || "/" }).catch(()=>{});
                }
              })
              // ================== 【核心修复代码 END】 ==================

            })
            
          }).catch(() => {
            this.loading = false
            if (this.captchaEnabled) {
              this.getCode()
            }
          })
        }
      })
    }

  }
}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
/* 背景和光斑效果 */
.login {
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background: linear-gradient(135deg, #e0f2fe 0%, #ccfbf1 35%, #fef3c7 100%);
  font-family: 'Helvetica Neue', Arial, sans-serif;
  position: relative;
  overflow: hidden;
}

.background-effects {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 0;
}

.light-orb {
  position: absolute;
  border-radius: 50%;
  filter: blur(80px);
  opacity: 0.6;
  animation: orbMove 15s infinite ease-in-out;
}

.orb-1 {
  width: 300px;
  height: 300px;
  background: rgba(167, 243, 208, 0.4);
  top: -50px;
  left: -50px;
  animation-delay: -5s;
}

.orb-2 {
  width: 400px;
  height: 400px;
  background: rgba(191, 219, 254, 0.4);
  bottom: -100px;
  right: 100px;
  animation-delay: -10s;
}

.orb-3 {
  width: 250px;
  height: 250px;
  background: rgba(254, 215, 170, 0.3);
  top: 200px;
  right: -50px;
}

@keyframes orbMove {
  0%, 100% {
    transform: translate(0, 0);
  }
  50% {
    transform: translate(30px, 30px);
  }
}

/* 登录卡片 */
.login-form {
  width: 420px;
  background-color: rgba(255, 255, 255, 0.95);
  border-radius: 16px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.08);
  padding: 50px 35px 30px;
  position: relative;
  margin-top: 80px;
  z-index: 10;
  border: 1px solid rgba(255, 255, 255, 0.8);
}

/* 小熊样式 */
.mascot-container {
  position: absolute;
  top: -120px;
  left: 50%;
  transform: translateX(-50%);
  z-index: 20;
}

.bear {
  width: 140px;
  height: 140px;
  position: relative;
}

.face {
  width: 100%;
  height: 100%;
  background-color: #fff;
  border-radius: 50%;
  position: relative;
  z-index: 2;
  border: 3px solid #333;
  box-shadow: 0 0 30px rgba(64, 158, 255, 0.15);
  box-sizing: border-box;
}

.ear {
  width: 48px;
  height: 48px;
  background-color: #333;
  border-radius: 50%;
  position: absolute;
  top: -12px;
  z-index: 1;
}

.ear.left {
  left: -8px;
}

.ear.right {
  right: -8px;
}

.eye {
  width: 28px;
  height: 28px;
  background-color: #fff;
  border: 3px solid #333;
  border-radius: 50%;
  position: absolute;
  top: 45px;
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden;
}

.eye.left {
  left: 26px;
}

.eye.right {
  right: 26px;
}

.pupil {
  width: 12px;
  height: 12px;
  background-color: #333;
  border-radius: 50%;
  transition: transform 0.1s ease-out;
}

.nose {
  width: 14px;
  height: 10px;
  background-color: #333;
  border-radius: 50%;
  position: absolute;
  top: 75px;
  left: 50%;
  transform: translateX(-50%);
}

.blush {
  width: 20px;
  height: 12px;
  background-color: #ffc2cc;
  border-radius: 50%;
  position: absolute;
  top: 70px;
  opacity: 0.7;
}

.blush.left {
  left: 12px;
}

.blush.right {
  right: 12px;
}

.paw {
  width: 40px;
  height: 40px;
  background-color: #fff;
  border: 3px solid #333;
  border-radius: 50%;
  position: absolute;
  bottom: -18px;
  z-index: 3;
  transition: all 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
}

.paw.left {
  left: 18px;
  transform-origin: bottom left;
}

.paw.right {
  right: 18px;
  transform-origin: bottom right;
}

.paw.hide-eyes-left {
  transform: translateY(-65px) translateX(8px) rotate(-20deg);
}

.paw.hide-eyes-right {
  transform: translateY(-65px) translateX(-8px) rotate(20deg);
}

/* 标题样式 */
.title {
  text-align: center;
  color: #303133;
  font-size: 22px;
  margin-top: 0;
  margin-bottom: 25px;
  font-weight: 600;
}

/* 自定义输入框样式 */
.custom-input {
  ::v-deep .el-input__inner {
    width: 100%;
    padding: 12px 15px 12px 35px;
    border: 1px solid #dcdfe6;
    border-radius: 8px;
    font-size: 14px;
    outline: none;
    transition: all 0.3s;
    background-color: #fafafa;
    height: 42px;
    line-height: 42px;
    
    &:focus {
      border-color: #409EFF;
      background-color: #fff;
      box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
    }
    
    &::placeholder {
      color: #909399;
    }
  }
  
  .input-icon {
    height: 42px;
    width: 14px;
    margin-left: 2px;
    color: #909399;
  }
}

/* 验证码特殊布局 */
.captcha-group {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

.captcha-input {
  width: 60%;
}

.captcha-img {
  width: 35%;
  height: 42px;
  background: #eee;
  border-radius: 8px;
  border: 1px solid #dcdfe6;
  cursor: pointer;
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden;
  
  .login-code-img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
}

/* 选项行 */
.options-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  font-size: 14px;
  
  ::v-deep .el-checkbox__label {
    color: #606266;
  }
  
  .link-type {
    color: #409EFF;
    text-decoration: none;
    
    &:hover {
      color: #66b1ff;
      text-decoration: underline;
    }
  }
}

/* 学生门户链接 */
.student-portal-link {
  text-align: center;
  margin-bottom: 20px;
  
  .portal-link-text {
    color: #409EFF;
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s;
    
    &:hover {
      color: #66b1ff;
      text-decoration: underline;
    }
  }
}

/* 按钮样式 */
.custom-btn {
  width: 100%;
  padding: 12px;
  border: none;
  border-radius: 8px;
  font-size: 15px;
  cursor: pointer;
  transition: all 0.3s;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 15px;
  font-weight: 500;
}

.btn-primary {
  background-color: #409EFF;
  color: white;
  box-shadow: 0 4px 10px rgba(64, 158, 255, 0.3);
  
  &:hover {
    background-color: #66b1ff;
    transform: translateY(-1px);
    box-shadow: 0 6px 15px rgba(64, 158, 255, 0.4);
  }
  
  &:active {
    transform: translateY(0);
  }
}

.btn-success {
  background-color: #f0f9eb;
  color: #67C23A;
  border: 1px solid #e1f3d8;
  
  &:hover {
    background-color: #e1f3d8;
    border-color: #c2e7b0;
    transform: translateY(-1px);
  }
}

/* 底部版权信息 */
.el-login-footer {
  position: fixed;
  bottom: 15px;
  width: 100%;
  text-align: center;
  color: #909399;
  font-size: 12px;
  z-index: 10;
}

// Element UI 样式覆盖
::v-deep .el-form-item {
  margin-bottom: 20px;
}

::v-deep .el-form-item__error {
  font-size: 12px;
  color: #F56C6C;
  margin-top: 5px;
}
</style>