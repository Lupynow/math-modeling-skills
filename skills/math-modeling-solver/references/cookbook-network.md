# 图论与网络算法手册

覆盖：网络流、最短路径、二分图匹配、中心性分析、K-Shell 分解、多层网络

---

## 1. 有向图网络流（水资源/基础设施类）

### 适用场景
- 水资源调度（流域、水库群）、电网潮流分配、供应链物流
- 节点间存在物理流（水/电/货）的单向传递系统

### 问题适配框架

| 图要素 | 问题映射 | 设计要点 |
|--------|---------|---------|
| 节点 V | 湖/水库/站点/仓库 | 每个节点需定义容量上限和初始状态 |
| 边 E | 连接水道/线路/运输路径 | 方向由高到低或由供到需 |
| 边权重 | 流量 Q / 运输量 | 受物理约束（管道容量、道路限行） |
| 源点 | 系统入口（上游水库/工厂） | 可多个源点 |
| 汇点 | 系统出口（下游/消费者） | 可多个汇点 |

### 质量守恒约束（核心公式）

对于任意非源非汇节点 v：
$$\sum_{(u,v)\in E} Q_{in}(u,v) = \sum_{(v,w)\in E} Q_{out}(v,w)$$

水位变化（水库类）：$$\Delta H = \frac{Q_{in} - Q_{out}}{A}$$

### 求解框架

**单目标**：最大流（Ford-Fulkerson / Edmonds-Karp）、最小费用流
**多目标**：NSGA-II，决策变量 = 各边流量 Q，目标 = 各利益方收益/成本函数

### 敏感度分析

扰动关键输入参数（降水、需求等）±10%，观察最优流量和总收益变化幅度。

---

## 2. 最短路径与混合路径规划（交通网络类）

### 适用场景
- 灾后路网评估、公交线网优化、物流路径规划
- 大规模网络中需要快速求解最短路径

### A*-GA 混合路径规划

**来自真实论文**：Baltimore 交通网络优化（D_2504188）

```
Algorithm: A*-GA Hybrid Path Planning
Input: 路网 G=(V,E), 边权重 w(u,v), 起点s, 终点t
Output: 最优路径 P*

1. 用改进 A* 生成 k 条初始路径（作为 GA 初始种群）
2. for generation = 1 to 100:
3.     select parents by tournament
4.     crossover(path1, path2) → 交换一段子路径
5.     if random < 0.05: mutation → 随机替换一个中间节点
6.     fitness = 1 / total_weight(path)
7. return best_path
```

**改进 A* 启发函数**：f'(n) = g(n) + α·h(n)，h(n) 用 Haversine 球面距离，α 可调。

### Dijkstra 多源多点（最短路）

```python
import networkx as nx
G = nx.Graph()
G.add_weighted_edges_from([(u, v, w) for u, v, w in edges])
# 单源最短路
distances = nx.single_source_dijkstra_path_length(G, source)
# 全对最短路
all_pairs = dict(nx.all_pairs_dijkstra_path_length(G))
```

---

## 3. 中心性分析与关键节点识别

### 常用中心性指标

| 指标 | 公式 | 含义 | 适用场景 |
|------|------|------|---------|
| Degree Centrality | $C_D(v)=deg(v)/(N-1)$ | 节点直接连接的边数 | 局部重要性 |
| Closeness Centrality | $C_C(v)=(N-1)/\sum d(v,t)$ | 节点到所有其他节点的平均最短距离的倒数 | 传播效率、断桥影响评估 |
| Betweenness Centrality | $C_B(v)=\sum_{s\neq v\neq t}\frac{\sigma_{st}(v)}{\sigma_{st}}$ | 节点出现在最短路径中的频率 | 枢纽识别、流量瓶颈 |

### 加权 K-Shell 分解（多层重要性分层）

**来自真实论文**：Baltimore 公交站分级（D_2519935）

```
1. 对节点计算综合评分（熵权-TOPSIS 综合多指标）
2. 加权 K-Shell 分解：
   - 迭代剥离度最小的节点
   - 每轮记录被剥离的节点和剥离轮次 k_s
   - 累计各轮节点得分形成分层
3. 输出三层：Core(核心)/Bridge(桥梁)/Outer(外围)
```

---

## 4. 二分图匹配（匈牙利算法）

### 适用场景
- 任务分配（工人→任务、设备→工序）
- RGV 调度中的 CNC 与工序匹配
- 资源配对问题

### 问题适配

| 图要素 | 问题映射 |
|--------|---------|
| 左部节点 | 待分配的资源（工人/设备） |
| 右部节点 | 待完成的任务（工序/位置） |
| 边 | 资源可以完成任务 |
| 边权重 | 完成时间/成本/效率 |

### 匈牙利算法框架

```python
from scipy.optimize import linear_sum_assignment
# cost_matrix[i][j] = 资源i完成任务j的成本
row_ind, col_ind = linear_sum_assignment(cost_matrix)
# row_ind[i] → col_ind[i] 为最优匹配
```

### 建模竞赛中的改进
- 多目标匹配：先求最优匹配集，再用熵权法排序
- 动态匹配：每轮匹配后更新剩余资源和可用任务
- 约束处理：加入不可匹配约束（设置 M=inf）

---

## 5. 多层网络模型

### 适用场景
- 城市交通（公路+公交+轨道层次）
- 供应链多层网络（供应商→制造商→分销商→零售商）
- 基础设施耦合系统（电力+通信+交通）

### 建模框架

```
G = G₁ ∪ G₂ ∪ ... ∪ Gₖ
每层 Gᵢ = (Vᵢ, Eᵢ) 有独立拓扑
层间边 E_inter 连接不同层中的对应节点
```

### 关键分析维度
- **层内分析**：每层独立的最短路径、中心性、连通分量
- **层间耦合**：层间边的权重反映模式转换成本（如公交→轨道交通换乘时间）
- **级联失效**：删除一个节点，观察跨层传播的影响范围

### 双层密度耦合（公交-轨道）

**来自真实论文**：$D_{bus} = a \cdot (D_{rail})^2 + b \cdot D_{rail} + c$，拟合公交站密度与轨道站密度的二次关系，评估轨道交通对公交覆盖的影响。

---

## 6. 常见陷阱

| 陷阱 | 正确做法 |
|------|---------|
| 节点太多导致图密集不可读 | 先聚合（如区域级而非站点级），图节点<50 |
| 只跑最短路不给对比 | 报告至少2条备选路径及各自的 cost |
| 网络流无守恒检验 | 每个节点入流=出流，输出检验表 |
| K-Shell 层数随意定 | 用分数分布的自然断点确定层界 |

---

## 参考模板

- `code-templates/python/optimization/network_flow_template.py` — 网络流求解
- `code-templates/python/optimization/nsga2_template.py` — NSGA-II 模板（多目标网络优化）
