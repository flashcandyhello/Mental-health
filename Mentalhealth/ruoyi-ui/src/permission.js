import router from './router'
import store from './store'
import { Message } from 'element-ui'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'
import { getToken } from '@/utils/auth'
import { isPathMatch } from '@/utils/validate'
import { isRelogin } from '@/utils/request'

NProgress.configure({ showSpinner: false })

const whiteList = ['/login', '/register', '/portal']

const isWhiteList = (path) => {
    return whiteList.some(pattern => isPathMatch(pattern, path))
}

router.beforeEach((to, from, next) => {
    NProgress.start()
    if (getToken()) {
        to.meta.title && store.dispatch('settings/setTitle', to.meta.title)
            /* has token*/
        if (to.path === '/login') {
            next({ path: '/' })
            NProgress.done()
        } else if (isWhiteList(to.path)) {
            next()
        } else {
            if (store.getters.roles.length === 0) {
                isRelogin.show = true
                    // 判断当前用户是否已拉取完user_info信息
                store.dispatch('GetInfo').then((res) => {
                    isRelogin.show = false
                    if (res.roles && res.roles.includes('lower')) {
                        store.dispatch('GenerateRoutes').then(accessRoutes => {
                            router.addRoutes(accessRoutes) // 动态添加可访问路由表
                            next({ path: '/student/index', replace: true }) // 强制跳转到学生端
                        })
                        return
                    }
                    store.dispatch('GenerateRoutes').then(accessRoutes => {
                        // 根据roles权限生成可访问的路由表
                        router.addRoutes(accessRoutes) // 动态添加可访问路由表
                        next({...to, replace: true }) // hack方法 确保addRoutes已完成
                    })
                }).catch(err => {
                    store.dispatch('LogOut').then(() => {
                        Message.error(err)
                        next({ path: '/' })
                    })
                })
            } else {
                // ================== 【新增：路由守卫拦截】 START ==================
                // 防止学生点击浏览器"后退"回到后台管理界面
                // 判断当前用户是否包含 'lower' (学生) 角色
                if (store.getters.roles.includes('lower')) {
                    // 如果当前要去的地方不是 /student 开头的，也不是 404/401 等错误页
                    // 同时排除学生可以访问的 /portal 和 /mood/result 页面
                    const allowedStudentPaths = ['/portal', '/mood/result', '/404', '/401'];
                    const isAllowedPath = allowedStudentPaths.some(path => to.path.startsWith(path));
                    
                    if (!to.path.startsWith('/student') && !isAllowedPath) {
                        next({ path: '/student/index', replace: true })
                        NProgress.done() // 结束进度条，防止页面卡死
                        return
                    }
                }
                // ================== 【新增：路由守卫拦截】 END ==================
                next()
            }
        }
    } else {
        // 没有token
        if (isWhiteList(to.path)) {
            // 在免登录白名单，直接进入
            next()
        } else {
            next(`/login?redirect=${encodeURIComponent(to.fullPath)}`) // 否则全部重定向到登录页
            NProgress.done()
        }
    }
})

router.afterEach(() => {
    NProgress.done()
})