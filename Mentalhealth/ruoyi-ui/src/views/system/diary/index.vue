<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
    
      <el-form-item label="学生姓名" prop="nickName">
        <el-input
          v-model="queryParams.nickName"
          placeholder="请输入学生姓名"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="情绪评分" prop="moodScore">
        <el-input
          v-model="queryParams.moodScore"
          placeholder="请输入情绪评分(0-100分)"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="情绪标签" prop="moodTag">
        <el-input
          v-model="queryParams.moodTag"
          placeholder="请输入情绪标签(如:焦虑/开心/平淡)"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="风险等级" prop="riskLevel">
        <el-select v-model="queryParams.riskLevel" placeholder="请选择风险等级" clearable size="small" style="width: 200px">
          <el-option label="1级 - 状态良好 (≥80)" value="1"><span style="color: #67C23A">● 1级 - 状态良好</span></el-option>
          <el-option label="2级 - 一般关注 (60-79)" value="2"><span style="color: #409EFF">● 2级 - 一般关注</span></el-option>
          <el-option label="3级 - 重点关注 (40-59)" value="3"><span style="color: #E6A23C">● 3级 - 重点关注</span></el-option>
          <el-option label="4级 - 紧急干预 (<40)" value="4"><span style="color: #F56C6C">● 4级 - 紧急干预</span></el-option>
        </el-select>
    </el-form-item>

      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

<el-row style="background:#fff; padding:20px; margin-bottom:20px;">
  <div id="moodChart" style="width: 100%; height: 350px;"></div>
</el-row>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:diary:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:diary:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:diary:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:diary:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

  ...
    <el-table v-loading="loading" :data="diaryList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键ID" align="center" prop="id" />
      <!-- 原来显示 ID，现在显示姓名 -->
      <el-table-column label="学生姓名" align="center" prop="nickName" width="100" />
      <el-table-column label="日记内容(支持表情)" align="center" prop="content" />
      <el-table-column label="心理健康指数" align="center" width="180">
  <template slot-scope="scope">
    <el-progress 
      :text-inside="true" 
      :stroke-width="18" 
      :percentage="scope.row.moodScore" 
      :status="scope.row.moodScore < 60 ? 'exception' : (scope.row.moodScore < 80 ? 'warning' : 'success')"
    ></el-progress>
  </template>
</el-table-column>

<el-table-column label="风险等级" align="center" width="160">
  <template slot-scope="scope">
    <el-tag v-if="(scope.row.moodScore * 1) >= 80" type="success" effect="dark">
      <i class="el-icon-sunny"></i> 1级 - 状态良好
    </el-tag>
    <el-tag v-else-if="(scope.row.moodScore * 1) >= 60" type="primary" effect="light">
      <i class="el-icon-cloudy"></i> 2级 - 一般关注
    </el-tag>
    <el-tag v-else-if="(scope.row.moodScore * 1) >= 40" type="warning" effect="dark">
      <i class="el-icon-warning-outline"></i> 3级 - 重点关注
    </el-tag>
    <el-tag v-else type="danger" effect="dark">
      <i class="el-icon-alarm-clock"></i> 4级 - 紧急干预
    </el-tag>
  </template>
</el-table-column>

      <el-table-column label="情绪标签(如:焦虑/开心/平淡)" align="center" prop="moodTag" />
      <el-table-column label="AI给出的建议" align="center" prop="aiAdvice" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
     
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:diary:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-s-promotion"
            style="color: #E6A23C;"
            v-if="scope.row.aiAdvice"
            @click="handlePushToRecord(scope.row)"
          >转录预警</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:diary:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改学生心情日记对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="学生ID(关联sys_user表)" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入学生ID(关联sys_user表)" />
        </el-form-item>
        <el-form-item label="日记内容(支持表情)">
          <editor v-model="form.content" :min-height="192"/>
        </el-form-item>
        <el-form-item label="情绪评分(0-100分)" prop="moodScore">
          <el-input v-model="form.moodScore" placeholder="请输入情绪评分(0-100分)" />
        </el-form-item>
        <el-form-item label="情绪标签(如:焦虑/开心/平淡)" prop="moodTag">
          <el-input v-model="form.moodTag" placeholder="请输入情绪标签(如:焦虑/开心/平淡)" />
        </el-form-item>
        <el-form-item label="AI给出的建议" prop="aiAdvice">
          <el-input v-model="form.aiAdvice" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="删除标志(0代表存在 2代表删除)" prop="delFlag">
          <el-input v-model="form.delFlag" placeholder="请输入删除标志(0代表存在 2代表删除)" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listDiary, getChartData, getDiary, delDiary, addDiary, updateDiary } from "@/api/system/diary";
import * as echarts from 'echarts';
export default {
  name: "Diary",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 学生心情日记表格数据
      diaryList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        content: null,
        moodScore: null,
        moodTag: null,
        aiAdvice: null,
        riskLevel: null,
        // 👇👇👇 新增这两个参数 👇👇👇
        orderByColumn: 'createTime', 
        isAsc: 'desc' 
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        userId: [
          { required: true, message: "学生ID(关联sys_user表)不能为空", trigger: "blur" }
        ],
        content: [
          { required: true, message: "日记内容(支持表情)不能为空", trigger: "blur" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  mounted() {
    this.initChart();
  },

  
  methods: {
    
    /** 2. 新增初始化图表的方法 */
    initChart() {
      const userId = this.queryParams.userId; // 获取搜索的userId
      getChartData(userId).then(response => {
          const dataList = response.data;
          // 准备X轴(时间)和Y轴(分数)的数据
          const dateList = dataList.map(item => this.parseTime(item.createTime, '{y}-{m}-{d} {h}:{i}'));
          const scoreList = dataList.map(item => item.moodScore);

          // 初始化 ECharts 实例
          const chart = echarts.init(document.getElementById('moodChart'));

          // 配置图表样式
          const option = {
              title: {
                  text: userId ? `用户${userId}近七日情绪波动趋势` : '近七日情绪波动趋势'
              },
          tooltip: { trigger: 'axis' },
          xAxis: {
            type: 'category',
            data: dateList, // X轴数据
            axisLabel: { rotate: 30 } // 日期斜着显示，防止重叠
          },
          yAxis: {
            type: 'value',
            min: 0,
            max: 100,
            name: '情绪分'
          },
          visualMap: {
  show: false,
  dimension: 1, // 映射纵坐标（分数）
  pieces: [
    { gt: 0, lte: 40, color: '#FF4D4F' },  // 正常
    { gt: 40, lte: 70, color: '#FFA940' }, // 中风险
    { gt: 70, color: '#52C41A' }           // 高风险
  ]
},
          series: [
            {
              name: '情绪得分',
              type: 'line', // 折线图
              data: scoreList, // Y轴数据
              markPoint: { // 在最高点增加“气泡”提示
    data: [{ type: 'min', name: '最低风险点' }, { type: 'max', name: '最高分' }]
  }
            }
          ]
        };
        // 渲染图表
        chart.setOption(option);
      });
    },
    
    /** 查询学生心情日记列表 */
    getList() {
      this.loading = true
      listDiary(this.queryParams).then(response => {
        this.diaryList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        userId: null,
        content: null,
        moodScore: null,
        moodTag: null,
        aiAdvice: null,
        createTime: null,
        updateTime: null,
        delFlag: null
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
      this.initChart(); // 搜索时重新加载图表
  },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加学生心情日记"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getDiary(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改学生心情日记"
      })
    },
    handlePushToRecord(row) {
      // 1. 自动计算风险等级 (1/2/3/4)
      let calculatedLevel = '4'; // 默认最严重
      const score = row.moodScore * 1; // 转数字

      if (score >= 80) calculatedLevel = '1';
      else if (score >= 60) calculatedLevel = '2';
      else if (score >= 40) calculatedLevel = '3';

      console.log("正在跳转，携带数据:", row.userId, "等级:", calculatedLevel);

      // 2. 跳转并携带参数 (advice, name, level)
      this.$router.push({
        path: '/psychology/record', // 确保你的路由路径是这个
        query: {
          advice: row.aiAdvice,
          name: row.nickName,
          level: calculatedLevel // <--- 新增：传过去等级
        }
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateDiary(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addDiary(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids
      this.$modal.confirm('是否确认删除学生心情日记编号为"' + ids + '"的数据项？').then(function() {
        return delDiary(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/diary/export', {
        ...this.queryParams
      }, `diary_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
