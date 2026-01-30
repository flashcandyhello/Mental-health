-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('学生心情日记', '1', '1', 'diary', 'system/diary/index', 1, 0, 'C', '0', '0', 'system:diary:list', '#', 'admin', sysdate(), '', null, '学生心情日记菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('学生心情日记查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'system:diary:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('学生心情日记新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'system:diary:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('学生心情日记修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'system:diary:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('学生心情日记删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'system:diary:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('学生心情日记导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'system:diary:export',       '#', 'admin', sysdate(), '', null, '');