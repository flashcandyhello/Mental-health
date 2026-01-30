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
