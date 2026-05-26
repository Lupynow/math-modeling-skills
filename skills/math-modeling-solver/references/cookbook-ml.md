# ML 类算法手册

覆盖：XGBoost、LightGBM、随机森林、SVM、BP 神经网络

---

## 0. 前置：EDA 与特征工程（ML 建模的基础）

**C 题评分红线：不做 EDA 直接调包的论文天然低一档。**

### EDA 必做清单
1. 描述性统计表（均值/标准差/最大/最小/分位数）
2. 缺失值检查（每列缺失比例）
3. 分布检查（直方图 + 正态性检验）
4. 相关性分析（热力图 + 散点图矩阵）
5. 异常值检测（箱线图 / 3σ 原则）

### 特征工程清单
1. **缺失值处理**：删除（缺失>50%）/ 均值填补 / KNN 填补 / 多重插补
2. **异常值处理**：盖帽法 / 分箱 / 保留（如异常值有业务意义）
3. **标准化**：Z-score（距离类模型必须）/ Min-Max / RobustScaler
4. **编码**：One-Hot（无序类别）/ Label Encoding（有序类别）/ Target Encoding（高基数类别）
5. **特征构造**：多项式特征 / 交互项 / 领域知识特征 / 时间特征分解
6. **特征选择**：相关性过滤 / 方差阈值 / 逐步回归 / RF 重要性 / SHAP / RFE

---

## 1. XGBoost

### 适用场景
- 表格数据，回归或分类
- 样本>500，特征<10K
- 存在非线性关系、交互效应
- 对预测精度要求高

### 核心公式（简化）

目标函数：
$$\text{Obj} = \sum_{i} L(y_i, \hat{y}_i) + \sum_{k} \Omega(f_k)$$

其中 $\Omega(f_k) = \gamma T + \frac{1}{2}\lambda\|w\|^2$（T 为叶节点数，w 为叶权重）

### 关键设计决策

| 参数 | 含义 | 建议范围 | 调参顺序 |
|------|------|---------|---------|
| n_estimators | 树的数量 | 100-1000 | ①先定 |
| max_depth | 树的最大深度 | 3-10 | ② |
| learning_rate | 学习率 | 0.01-0.3 | ③与 n_estimators 联动 |
| subsample | 样本采样比例 | 0.6-1.0 | ④ |
| colsample_bytree | 特征采样比例 | 0.6-1.0 | ④ |
| reg_alpha / reg_lambda | L1/L2 正则化 | 0-10 | ⑤ |
| min_child_weight | 最小叶节点权重和 | 1-10 | ⑤ |

### 调参策略
1. 先用默认参数跑 baseline
2. 固定 learning_rate=0.1，用 cv 确定 n_estimators
3. 调整 max_depth 和 min_child_weight
4. 调 subsample 和 colsample_bytree
5. 调正则化参数
6. 降低 learning_rate，增加 n_estimators

### Python 模板

见 `code-templates/python/ml/xgboost_template.py`

---

## 2. 随机森林 (Random Forest)

### 适用场景
- 中等样本量(100-1000)
- 需要可解释的特征重要性
- 对异常值和缺失值鲁棒
- baseline 模型首选

### 优势 vs XGBoost
- 不需要精细调参就能获得不错效果
- 对过拟合天然鲁棒（Bagging）
- 特征重要性更直观

### 关键参数
- n_estimators: 100-500
- max_depth: None（不限制）或 5-15
- min_samples_split: 2-10
- max_features: sqrt(n_features)（分类）/ n_features（回归建议 1/3）

### Python 模板

见 `code-templates/python/ml/random_forest_template.py`

---

## 3. SVM（支持向量机）

### 适用场景
- 小样本(<1000)、高维特征
- 分类边界复杂、非线性可分
- 需要良好泛化能力

### 不适用场景
- 大样本(>10000)：训练复杂度 O(n²)~O(n³)，改用 LinearSVC 或 RF/XGBoost
- 需要概率输出：SVM 不直接输出概率，需额外 Platt scaling
- 特征数远大于样本数：需谨慎选择核函数，线性核通常更安全

### 问题适配框架

| SVM 要素 | 问题映射 | 设计要点 |
|---------|---------|---------|
| 核函数选择 | 数据线性可分程度 | 线性核（特征>样本数）→ RBF 核（默认首选）→ Poly 核（已知多项式关系） |
| 惩罚参数 C | 对误分类的容忍度 | C 大 → 尽量分对（可能过拟合）；C 小 → 允许更多误分类 |
| Gamma（RBF核） | 单个样本的影响范围 | gamma 大 → 复杂边界（过拟合风险）；gamma 小 → 更平滑 |
| 类别权重 | 样本不均衡 | `class_weight='balanced'` 自动调整 |

### 调参步骤

```python
from sklearn.svm import SVC
from sklearn.model_selection import GridSearchCV
from sklearn.preprocessing import StandardScaler

# 必须标准化（SVM 对特征尺度极其敏感）
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

param_grid = {'C': [0.1, 1, 10, 100], 'gamma': ['scale', 'auto', 0.01, 0.1], 'kernel': ['rbf', 'linear']}
grid = GridSearchCV(SVC(), param_grid, cv=5, scoring='accuracy', n_jobs=-1)
grid.fit(X_scaled, y)
```

### 竞赛建议
1. 先试 LinearSVC 作为快速 baseline
2. 再试 RBF 核 + 粗粒度 GridSearch
3. **论文中必须说明为什么选 SVM**（如：样本量小、需要最大间隔分类器），并与 RF/XGBoost 对比精度

---

## 4. BP 神经网络

### 适用场景
- 大样本(>5000)，传统 ML 效果不佳
- 高度非线性关系
- 图像/序列/文本等非表格数据

### 不适用场景
- 小样本(<500)：RF/XGBoost 更稳定，NN 容易过拟合
- 需要可解释性：评审要求解释每个特征的影响时用 RF/Logistic
- 表格数据+中等样本：先试 XGBoost，大概率效果更好

### 网络结构设计（竞赛实用）

| 设计要素 | 建议 | 理由 |
|---------|------|------|
| 隐藏层数 | 1-3 层 | 竞赛不需要 100 层，1-2 层通常足够 |
| 每层节点数 | 32-256 | 输入层→第一隐藏层可稍大（如 128），逐层递减 |
| 激活函数 | 隐藏层 ReLU，输出层按任务 | 分类→softmax，回归→linear，二分类→sigmoid |
| Dropout | 0.2-0.5 | 防过拟合，小数据用更大 dropout |
| Batch Size | 32/64/128 | 2 的幂方便 GPU 优化 |
| 学习率 | 1e-3 起步，Adam 优化器 | Adam 自适应，通常不需手动调 |
| Early Stopping | patience=10-20 | val_loss 不再下降就停，防止过拟合 |

### 最小可用模板

```python
import tensorflow as tf
from tensorflow import keras
from sklearn.preprocessing import StandardScaler

scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

model = keras.Sequential([
    keras.layers.Dense(128, activation='relu', input_shape=(X.shape[1],)),
    keras.layers.Dropout(0.3),
    keras.layers.Dense(64, activation='relu'),
    keras.layers.Dropout(0.3),
    keras.layers.Dense(1, activation='sigmoid')  # 二分类
])
model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])

early_stop = keras.callbacks.EarlyStopping(monitor='val_loss', patience=15, restore_best_weights=True)
history = model.fit(X_train, y_train, validation_data=(X_val, y_val),
                    epochs=200, batch_size=32, callbacks=[early_stop], verbose=1)
```

### 竞赛注意事项
- 多次运行取平均（权重初始化影响大），至少 5 次报告均值±标准差
- 论文中必须画网络结构图（用 NN-SVG 或 draw.io）
- 训练曲线必须放（epoch vs loss/accuracy），证明收敛且未过拟合
- 不需要极致调参——评委看的是「为什么选 NN」「结果分析」，不是调参竞赛

---

## 5. 模型对比要求（C 题必备）

评审期望看到至少 3 种方法的系统对比：

| 对比维度 | 表格内容 |
|---------|---------|
| 模型 | 线性回归 / 随机森林 / XGBoost / ... |
| 超参数 | 关键参数值 |
| 训练集 R² | ... |
| 测试集 R² | ... |
| MAE / RMSE | ... |
| 训练时间 | ... |

选最终模型时给出理由：不只看精度，还要讨论复杂度、可解释性、过拟合风险。
