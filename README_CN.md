---
title: Read this page in English
---

[**English**](./README.md) · [**中文**](./README_CN.md)

---

# Code Agent Pro

> 面向 [OpenClaw](https://openclaw.ai) 的专业级 Code Agent 技能。将规格先行、代码质量、持续学习作为核心原则。

灵感来源于 [Claude Code `/feature-dev` 插件](https://github.com/anthropics/claude-code/tree/main/plugins/feature-dev) 的设计哲学：**永远不要在没有规格的情况下写代码**。

## 功能特性

### 🏗️ SPEC 工作流（6 阶段）

| 阶段 | 内容 |
|------|------|
| 阶段 1 | **需求澄清** — 动手前消除所有歧义 |
| 阶段 2 | **PRD 生成** — 通过 `write-a-prd` 技能生成正式规格文档 |
| 阶段 3 | **架构设计** — 三条路径：最小改动 / 干净架构 / 实用平衡 |
| 阶段 4 | **实施构建** — 用户确认后才动手写代码 |
| 阶段 5 | **质量门禁** — Lint → 类型检查 → 测试 → 构建 → 安全扫描 |
| 阶段 6 | **自我反思** — "这是最优方案吗？" |

### 🗺️ `/learn` 命令 — 项目快速理解

运行 `/learn [路径]` 在约 30 分钟内快速理解任何项目：

| 步骤 | 耗时 | 产出 |
|------|------|------|
| 表面扫描 | 3 分钟 | 项目类型、技术栈、规模 |
| 入口点追踪 | 5 分钟 | 启动流程、API 接口 |
| 核心流程深挖 | 10 分钟 | 主要业务流程端到端追踪 |
| 模式提取 | 5 分钟 | 代码风格、测试、日志规范 |
| 心智模型 | 5 分钟 | `memory/project-map.md` 速查表 |
| 缺口报告 | 2 分钟 | 针对性提问不明确的区域 |

### 🧠 记忆系统

- 4 层架构：会话 → 工作记忆 → 长期记忆 → 代码库记忆
- 上下文窗口优化（优先级排序 + 压缩策略）
- 知识图谱构建（项目实体关系网络）

### 🔧 后端支持（Python / Java / Go / Rust / Node.js）

- **分层架构** 模板（API → Service → Repository → Domain）
- **错误处理** 层级体系（类型化错误）
- **测试策略**（单元 / 集成 / E2E）
- **结构化日志** 每种语言的配置方式
- **Agent 自检** 清单

### 🌐 跨语言通用模式

- API 设计（REST / GraphQL）
- 并发模式（扇出、工作池、熔断器、管道）
- 缓存策略决策树
- 数据库 Schema 设计与查询优化
- 可观测性（日志、指标、链路追踪）

### 🎨 前端集成

| 阶段 | 技能 | 用途 |
|------|------|------|
| 设计 | `superdesign` | ASCII 线框图、主题模板、动画规划 |
| 实施 | `frontend-design` | 美学差异化、反 AI 味 |
| 审查 | `ui-ux-pro-max` | 99 条 UX 准则、无障碍、性能 |
| React | `vercel-react-best-practices` | 65 条规则，8 个优先级分类 |

### 🔒 质量保证

- 静态分析工具矩阵（Ruff / ESLint / go vet / Clippy）
- 代码同步生成测试
- 安全审计（密钥检测、注入防护、路径穿越、许可证合规）
- 复杂度控制（圈复杂度 ≤ 10）

### 📚 学习闭环

- 失败模式库（根因分析）
- 用户偏好跨会话学习
- 性能积累与估算
- A/B 决策框架

## 项目结构

```
code-agent-pro/
├── SKILL.md                              # 主入口
├── skill.json                            # 元数据
├── scripts/
│   ├── setup.sh                          # 依赖检测（macOS / Linux）
│   └── setup.ps1                         # 依赖检测（Windows）
└── references/
    ├── spec-workflow.md                  # SPEC 6 阶段指南 + PRD 集成
    ├── project-onboarding.md             # /learn 命令指南
    ├── backend-patterns.md               # 各语言架构与代码模板
    ├── cross-lang-patterns.md            # API、并发、缓存、数据库、可观测性
    ├── memory-system.md                  # 上下文管理与窗口优化
    ├── quality-assurance.md              # 静态分析、测试、自检
    ├── execution-environment.md          # 构建验证、沙盒、回滚
    ├── security-audit.md                 # 威胁模式、合规、许可证审查
    ├── learning-loop.md                  # 失败模式、偏好、A/B 决策
    ├── skill-integrations.md             # 集成路由表与降级策略
    └── frontend-design-fallback.md       # superdesign 缺失时的回退
```

## 安装

### 作为 OpenClaw 技能安装

1. 将此仓库克隆到技能目录：
```bash
# macOS / Linux
git clone https://github.com/Eve0211/code-agent-pro.git ~/.qclaw/workspace/skills/code-agent-pro

# Windows
git clone https://github.com/Eve0211/code-agent-pro.git %USERPROFILE%\.qclaw\workspace\skills\code-agent-pro
```

2. 运行依赖检测：
```bash
bash skills/code-agent-pro/scripts/setup.sh        # macOS / Linux
.\skills\code-agent-pro\scripts\setup.ps1           # Windows
```

### 可选：安装集成技能

本技能无需任何外部依赖即可完整运行。安装以下技能可获得增强能力：

```bash
# 规格生成
skillhub install write-a-prd

# 前端设计
skillhub install superdesign
skillhub install ui-ux-pro-max

# Git 工作流
skillhub install github

# 测试
skillhub install webapp-testing
```

## 使用方法

### 快速开始

直接描述你想构建的内容。SPEC 工作流会自动激活：

```
你: "给这个 FastAPI 项目添加 OAuth 用户认证"

Agent:
  阶段 1 → 提出澄清问题（范围、约束、OAuth 提供商）
  阶段 2 → 用 write-a-prd 生成 PRD
  阶段 3 → 呈现三种架构方案及权衡分析
  你:   → 选择"实用平衡"方案
  阶段 4 → 同步实现代码和测试
  阶段 5 → 运行 lint、类型检查、测试、构建、安全扫描
  阶段 6 → 自我反思并呈现结果
```

### 项目快速理解

```
你: "/learn ./my-project"

Agent: 30 分钟内扫描项目，生成 memory/project-map.md，
       然后基于完整理解开始工作。
```

### 小任务跳过 SPEC

以下情况自动跳过完整 SPEC 工作流：
- 单行 Bug 修复
- 简单重构
- 已充分理解的小任务
- 紧急热修复（事后补充文档）

质量门禁和安全检查始终执行，无论任务大小。

## 设计哲学

### 三层能力模型

```
第一层：通用模式（始终内嵌，零依赖）
  → 架构、错误处理、测试、安全、性能

第二层：框架专项（可选外部技能）
  → React/Next.js 性能规则（仅针对"静默陷阱"）

第三层：项目规范（来自项目文件）
  → CLAUDE.md、.editorconfig、ruff.toml、tsconfig.json
  → 始终是最准确的真实来源
```

### 优雅降级

每个外部技能都有内嵌回退。缺失的技能不会阻断工作流——只会降低能力深度。安装脚本会明确报告哪些是增强的、哪些是回退的。

### 为什么 React 获得特殊对待

React 的性能问题（静默重渲染、useEffect 依赖 Bug、包体积膨胀）能通过所有静态检查——只有专项规则能捕获它们。后端语言没有类似的"不可见"陷阱，其问题通过标准工具链即可发现。

## 许可证

MIT
