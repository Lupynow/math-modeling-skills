# 聚类与分组方法手册

覆盖：K-Means、层次聚类（R型/Q型）、DBSCAN、GMM-EM、聚类数确定、聚类评价

---

## 1. 层次聚类（R 型 + Q 型）

### 适用场景
- 样本分类且类别数未知（最常见）
- 需要看到聚类的层次结构（树状图）
- 特征选择和样本分类需要联动

### R 型聚类 vs Q 型聚类

| 类型 | 聚类对象 | 作用 | 典型用法 |
|------|---------|------|---------|
| **R 型聚类** | 变量/特征 | 特征降维、去除冗余变量 | 选出代表性特征后再做 Q 型聚类 |
| **Q 型聚类** | 样本/观测 | 将样本分组 | R 型选出特征变量后对样本聚类 |

**来自真实论文**（2022 C155 古代玻璃分类）：
> 先进行 R 型聚类筛选特征变量（14 种化学成分→选出关键成分），再以选出的特征为基础进行 Q 型聚类划分子类。相比直接用 Q 型聚类，R→Q 两步法具有更高的合理性——避免无关变量稀释聚类结构。

### 聚类步骤

```
Step 1: 数据预处理（标准化/CLR变换，见第4节）
Step 2: R 型聚类 → 选出 k 个代表性特征
Step 3: Q 型聚类（基于 R 型选出的特征）→ 将 N 个样本分为 m 类
Step 4: 画树状图，根据类间距离确定 m
Step 5: 敏感性分析 → 扰动特征值 ±10%，观察分类结果稳定性
```

### 距离度量选择

| 数据类型 | 推荐距离 |
|---------|---------|
| 连续数值（已标准化）| 欧氏距离 |
| 成分数据（定和为1）| Aitchison 距离（需先 CLR 变换） |
| 高维稀疏数据 | 余弦距离 |
| 混合类型（数值+类别）| Gower 距离 |

### Python 实现

```python
from scipy.cluster.hierarchy import dendrogram, linkage, fcluster
from scipy.spatial.distance import pdist

# 层次聚类
Z = linkage(X_scaled, method='ward')  # Ward 最小方差法（推荐）
# 画树状图确定类别数
dendrogram(Z)
# 按距离阈值切分
labels = fcluster(Z, t=3, criterion='maxclust')
```

### MATLAB 实现

```matlab
Z = linkage(X, 'ward');
dendrogram(Z);
labels = cluster(Z, 'maxclust', 3);
```

---

## 2. K-Means 聚类

### 适用场景
- 样本量大、类别数为已知或可估计
- 簇形状近似球形
- 需要快速计算

### 问题适配

| K-Means 要素 | 问题映射 |
|-------------|---------|
| K（簇数）| 通过肘部法则 + 轮廓系数确定 |
| 初始质心 | K-Means++ 初始化（避免局部最优） |
| 距离 | 欧氏距离（需先标准化） |

### 肘部法则 + 轮廓系数（确定 K）

```python
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score

# 肘部法则
inertias = []
for k in range(2, 11):
    km = KMeans(n_clusters=k, init='k-means++', random_state=42)
    km.fit(X_scaled)
    inertias.append(km.inertia_)
# 画 inertia vs k 图，找"肘部"

# 轮廓系数验证
for k in range(2, 11):
    km = KMeans(n_clusters=k, init='k-means++', random_state=42)
    labels = km.fit_predict(X_scaled)
    score = silhouette_score(X_scaled, labels)
    print(f"k={k}, silhouette={score:.3f}")
```

### 常见陷阱
- **忘记标准化**：量纲差异大的特征会主导聚类结果。必须 Z-score 标准化
- **K 随意定**：必须用肘部法则+轮廓系数双重验证
- **异常值敏感**：先做异常值检测（IQR/Isolation Forest）

---

## 3. DBSCAN（密度聚类）

### 适用场景
- 簇形状不规则（非球形）
- 数据中有噪声点需要自动识别
- 类别数完全未知

### 关键参数

| 参数 | 含义 | 调参方法 |
|------|------|---------|
| eps | 邻域半径 | K-距离图：对每个点计算到第 k 近邻的距离，排序后找拐点 |
| min_samples | 核心点最少邻居数 | 通常取 2×特征维度，数据量大时可适当增大 |

```python
from sklearn.cluster import DBSCAN
from sklearn.neighbors import NearestNeighbors

# K-距离图确定 eps
neigh = NearestNeighbors(n_neighbors=2*X.shape[1])
nbrs = neigh.fit(X_scaled)
distances = np.sort(nbrs.kneighbors()[0][:, -1])
# 画 distances 曲线，拐点处即为 eps 推荐值

db = DBSCAN(eps=eps_val, min_samples=2*X.shape[1])
labels = db.fit_predict(X_scaled)
# label=-1 的点为噪声
```

---

## 4. 成分数据预处理（竞赛高频）

### 何时需要
当各变量之和为常数（如化学成分占比和为 100%、市场份额和为 1），数据位于单纯形上而非欧氏空间，直接用欧氏距离聚类会出错。

### CLR 变换（中心化对数比变换）

**来自真实论文**（2022 C155 玻璃成分分类）：

$$clr(x) = \left(\ln\frac{x_1}{g(x)}, \ln\frac{x_2}{g(x)}, ..., \ln\frac{x_D}{g(x)}\right)$$

其中 $g(x) = (\prod_{i=1}^D x_i)^{1/D}$ 为几何均值。

```python
def clr_transform(X):
    """成分数据 CLR 变换"""
    X = np.array(X, dtype=float)
    X = X / X.sum(axis=1, keepdims=True)  # 闭合
    X = np.clip(X, 1e-10, None)           # 避免 log(0)
    gmean = np.exp(np.mean(np.log(X), axis=1, keepdims=True))
    return np.log(X / gmean)
```

**关键**：CLR 变换后可用标准欧氏距离做聚类。论文中必须引用 Aitchison (1986) 的成分数据分析理论。

---

## 5. GMM-EM（高斯混合模型）

### 适用场景
- 数据来自多个高斯分布的混合
- 需要软聚类（每个点属于各类的概率）
- 与 K-Means 对比时需要更灵活的簇形状

```python
from sklearn.mixture import GaussianMixture

# BIC 准则选择分量数
bic_scores = []
for k in range(1, 11):
    gmm = GaussianMixture(n_components=k, random_state=42)
    gmm.fit(X_scaled)
    bic_scores.append(gmm.bic(X_scaled))
# 选 BIC 最小的 k

# 最终模型
gmm = GaussianMixture(n_components=best_k, random_state=42)
labels = gmm.fit_predict(X_scaled)
probs = gmm.predict_proba(X_scaled)  # 软分配概率
```

---

## 6. 聚类结果评价与验证

### 内部评价（无标签时）

| 指标 | 含义 | 越 X 越好 |
|------|------|---------|
| 轮廓系数 (Silhouette) | 簇内紧密度 vs 簇间分离度 | 越大（接近 1） |
| Davies-Bouldin Index | 簇间相似度的均值 | 越小 |
| Calinski-Harabasz | 簇间方差 / 簇内方差 | 越大 |

### 敏感性分析（竞赛必备）

**来自真实论文**：对特征值在 [0.1, 0.2] 范围内随机扰动，重新聚类。若分类结果一致率 > 90%，模型敏感度良好。

---

## 7. 常见陷阱

| 陷阱 | 正确做法 |
|------|---------|
| 成分数据不转换直接聚类 | CLR 变换后聚类 |
| 只用一种方法确定类别数 | 肘部法则 + 轮廓系数 + 业务解释三重验证 |
| 聚类后不分析每类的含义 | 对每个簇做描述统计，给出"这个簇代表什么"的业务解释 |
| 不检验聚类稳定性 | 扰动输入 ±10%，对比聚类结果一致性 |
| 高维数据直接聚类 | 先做 R 型聚类或 PCA 降维，选关键特征再聚类 |

---

## 参考模板

- `code-templates/python/ml/gmm_em_template.py` — GMM-EM 模板

## 参考文献线索

- 2022 国赛 C 题「古代玻璃文物分类」— 典型 R+Q 型聚类 + CLR 变换
- Aitchison, J. (1986). The Statistical Analysis of Compositional Data
