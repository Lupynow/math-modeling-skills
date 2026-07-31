# Security Policy

## Reporting a Vulnerability

本项目是一个数学建模竞赛工具链（Claude Code Skills），主要包含文档模板、代码示例和规则指南，不涉及网络通信、数据库或用户数据存储。

如果你发现任何安全问题（包括但不限于代码注入风险、恶意代码、拼写错误导致的误导性指令），请通过以下方式报告：

- **GitHub Issues**：[提交 Issue](https://github.com/Lupynow/math-modeling-skills/issues)（如果不涉及敏感信息）
- **私密报告**：如果涉及敏感安全问题，请通过 GitHub 的 [Security Advisories](https://github.com/Lupynow/math-modeling-skills/security/advisories/new) 功能提交

## 预期响应

- 一般问题：1 周内回复
- 严重问题：3 天内回复并给出修复时间表

## 范围

安全策略适用于：
- `skills/` 目录下的所有 SKILL.md 和 references
- 代码模板（Python/MATLAB）
- 本仓库的 GitHub Actions 配置（如有）

## 已知局限

本项目是 Claude Code 的 skill 文件集合，运行时依赖 Claude Code 环境。安全性依赖于：
1. Claude Code 自身的沙箱机制
2. 用户的 Python/MATLAB 运行环境
3. 用户对代码模板输出结果的理解和验证

建议用户在运行任何代码模板前，先理解代码逻辑，尤其在处理真实数据时。
