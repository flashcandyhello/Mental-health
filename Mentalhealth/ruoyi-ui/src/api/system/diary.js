import request from '@/utils/request'

// 查询学生心情日记列表
export function listDiary(query) {
    return request({
        url: '/system/diary/list',
        method: 'get',
        params: query
    })
}

// 查询学生心情日记详细
export function getDiary(id) {
    return request({
        url: '/system/diary/' + id,
        method: 'get'
    })
}

// 新增学生心情日记
export function addDiary(data) {
    return request({
        url: '/system/diary',
        method: 'post',
        data: data
    })
}

// 修改学生心情日记
export function updateDiary(data) {
    return request({
        url: '/system/diary',
        method: 'put',
        data: data
    })
}

// 删除学生心情日记
export function delDiary(id) {
    return request({
        url: '/system/diary/' + id,
        method: 'delete'
    })
}

export function getChartData(userId, nickName) {
    return request({
        url: '/system/diary/chartData',
        method: 'get',
        params: { userId, nickName } // 同时传递userId和nickName参数
    })
}

// 获取后台驾驶舱统计数据
export function getDashboardData() {
    return request({
        url: '/system/diary/dashboardData',
        method: 'get'
    })
}