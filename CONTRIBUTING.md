# Contributing to Math Modeling Skills

感谢你对本项目的关注！欢迎任何形式的贡献。

## 贡献方式

### 报告问题（Bug Report）

如果你发现 skill 输出不对、代码模板有 bug、或者文档有错误：

1. 在 [Issues](https://github.com/Lupynow/math-modeling-skills/issues) 搜索是否已有相同问题
2. 如果没有，新建 Issue，描述：
   - 你用的是哪个 skill（solver / paper）
   - 你输入了什么
   - 期望输出什么
   - 实际输出什么

### 提改进建议（Feature Request）

如果你希望增加新功能、新的 Cookbook/Playbook/代码模板：

1. 在 Issues 中说明场景和需求
2. 如果能附上参考论文或数据来源就更好了

### 提交代码（Pull Request）

1. **Fork** 本仓库
2. 创建分支：`git checkout -b feature/xxx`
3. 遵循现有目录结构：
   - 新 Cookbook → `skills/math-modeling-solver/references/cookbook-xxx.md`
   - 新 Playbook → `skills/math-modeling-solver/references/playbooks/xxx.md`
   - 新代码模板 → `skills/math-modeling-solver/references/code-templates/xxx.py` 或 `.m`
   - 论文写作参考 → `skills/math-modeling-paper/references/xxx.md`
4. 提交时写清楚改了什么、为什么改
5. 提 PR 到 `main` 分支

### 补充获奖论文

本项目规则和模板来自对获奖论文的系统分析。如果你手头有高质量获奖论文（省一及以上 / MCM M 及以上），欢迎通过 Issue 分享，但请确保：
- 不侵犯原作者版权（仅用于规则提炼，不直接复制论文内容）
- 标注论文年份、竞赛、奖项

## 质量标准

### Cookbook 要求
- 至少包含：核心原理、参数说明、适用场景、边界条件、Python/MATLAB 伪代码
- 必须标注文献来源（至少 1 篇 SCI 或中文核心）

### Playbook 要求
- 完整的"赛题分析 → 模型选择 → 求解 → 论文输出"流程
- 必须是真实赛题（历年真题）的可行解法

### 代码模板要求
- Python：`numpy` + `scipy` + `matplotlib` 即可，不引入重依赖
- MATLAB：保持独立脚本，所有函数内联
- 必须能直接跑，注释用中文

## 沟通

所有讨论在 GitHub Issues 中进行，保持友善和专业。参考 [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)。

## License

提交贡献即表示你同意将代码以 MIT 协议授权，详见 [LICENSE](LICENSE)。
