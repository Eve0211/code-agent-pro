[**English**](#english) · [**中文**](#中文)

---

<a id="english"></a>

# Code Agent Pro

> Professional Code Agent skill for AI coding assistants. Treats specification discipline, code quality, and continuous learning as first-class concerns. Works with Claude Code, Codex, OpenClaw, Cursor, OpenCode, Trae, and more.

Inspired by the [Claude Code `/feature-dev` plugin](https://github.com/anthropics/claude-code/tree/main/plugins/feature-dev) philosophy: **never code without a spec**.

## Features

### 🏗️ SPEC Workflow (6 Phases)

| Phase | What Happens |
|-------|-------------|
| Phase 1 | **Requirement Clarification** — Eliminate ambiguity before writing |
| Phase 2 | **PRD Generation** — Formal spec via `write-a-prd` skill integration |
| Phase 3 | **Architecture Design** — 3 paths: minimal / clean / pragmatic |
| Phase 4 | **Implementation** — Only after user confirmation |
| Phase 5 | **Quality Gates** — Lint → Type check → Tests → Build → Security |
| Phase 6 | **Self-Reflection** — "Is this the best approach?" |

### 🗺️ `/learn` Command — Project Onboarding

Run `/learn [path]` to quickly understand any project in ~30 minutes:

| Step | Duration | Output |
|------|----------|--------|
| Surface Scan | 3 min | Project type, tech stack, size |
| Entry Point Trace | 5 min | Startup sequence, API surface |
| Core Flow Deep Dive | 10 min | Main workflows traced end-to-end |
| Pattern Extraction | 5 min | Code style, testing, logging conventions |
| Mental Model | 5 min | `memory/project-map.md` cheat sheet |
| Gap Report | 2 min | Targeted questions for unclear areas |

### 🧠 Memory System

- 4-layer architecture: session → working → long-term → codebase
- Context window optimization with prioritization and compression
- Knowledge graph construction for codebase relationships

### 🔧 Backend Support (Python / Java / Go / Rust / Node.js)

- **Layered architecture** templates per language
- **Error handling** hierarchies with typed errors
- **Testing strategy** (unit / integration / E2E)
- **Structured logging** setup per language
- **Agent self-check** checklist

### 🌐 Cross-Language Patterns

- API design (REST / GraphQL)
- Concurrency patterns (Fan-Out, Worker Pool, Circuit Breaker, Pipeline)
- Caching strategy with decision tree
- Database schema design and query optimization
- Observability (logs, metrics, traces)

### 🎨 Frontend Integration

| Phase | Skill | Purpose |
|-------|-------|---------|
| Design | `superdesign` | ASCII wireframes, theme templates, animation planning |
| Implementation | `frontend-design` | Aesthetic differentiation, anti-AI-slop |
| Audit | `ui-ux-pro-max` | 99 UX guidelines, accessibility, performance |
| React | `vercel-react-best-practices` | 65 rules across 8 priority categories |

### 🔒 Quality Assurance

- Static analysis tool matrix (Ruff / ESLint / go vet / Clippy)
- Automatic test generation alongside code
- Security audit (secrets, injection, path traversal, license compliance)
- Complexity control (cyclomatic complexity ≤ 10)

### 📚 Learning Loop

- Failure mode library with root cause analysis
- User preference learning across sessions
- Performance accumulation and estimation
- A/B decision framework for architecture choices

## Architecture

```
code-agent-pro/
├── SKILL.md                              # Main entry point
├── skill.json                            # Metadata
├── scripts/
│   ├── setup.sh                          # Dependency check (macOS / Linux)
│   └── setup.ps1                         # Dependency check (Windows)
└── references/
    ├── spec-workflow.md                  # SPEC 6-phase guide + PRD integration
    ├── project-onboarding.md             # /learn command guide
    ├── backend-patterns.md               # Per-language architecture & code templates
    ├── cross-lang-patterns.md            # API, concurrency, caching, DB, observability
    ├── memory-system.md                  # Context management & window optimization
    ├── quality-assurance.md              # Static analysis, testing, self-inspection
    ├── execution-environment.md          # Build verification, sandbox, rollback
    ├── security-audit.md                 # Threat patterns, compliance, license review
    ├── learning-loop.md                  # Failure modes, preferences, A/B decisions
    ├── skill-integrations.md             # Integration router & degradation strategy
    └── frontend-design-fallback.md       # Fallback when superdesign not installed
```

## Installation

### Option A: npx (Recommended)

```bash
# Install to all detected agents automatically
npx code-agent-pro

# Install to a specific agent only
npx code-agent-pro --claude
npx code-agent-pro --codex
npx code-agent-pro --openclaw
npx code-agent-pro --cursor
npx code-agent-pro --opencode

# Reinstall (overwrite existing)
npx code-agent-pro --force

# List detected agents and install status
npx code-agent-pro --list
```

Supported agents: **Claude Code**, **Codex**, **OpenClaw / QClaw**, **Cursor**, **OpenCode**.

### Option B: Git Clone

```bash
git clone https://github.com/Eve0211/code-agent-pro.git

# Copy to your agent's skills directory, e.g.:
cp -r code-agent-pro ~/.claude/skills/
cp -r code-agent-pro ~/.codex/skills/
cp -r code-agent-pro ~/.qclaw/workspace/skills/
cp -r code-agent-pro ~/.cursor/skills/
cp -r code-agent-pro ~/.config/opencode/skills/
```

### Optional: Integration Skills

Works fully standalone. Install these for enhanced capabilities:

```bash
skillhub install write-a-prd         # SPEC generation
skillhub install superdesign         # Frontend design
skillhub install ui-ux-pro-max       # UX quality audit
skillhub install github              # Git workflow
skillhub install webapp-testing      # E2E testing
```

## Usage

### Quick Start

Just describe what you want to build. The SPEC workflow activates automatically for non-trivial tasks.

### Project Onboarding

```
/learn ./my-project    → Scans project in 30 min, generates mental model
```

### Skip SPEC for Small Tasks

Single-line bug fixes, trivial refactors, and emergency hotfixes skip the full workflow. Quality gates always run.

## Design Philosophy

### Three-Layer Model

| Layer | Content | Source |
|-------|---------|--------|
| Layer 1 | Universal patterns (architecture, errors, testing, security) | Embedded in skill |
| Layer 2 | Framework specialists (React/Next.js performance rules) | External skills |
| Layer 3 | Project-specific conventions (CLAUDE.md, ruff.toml) | Project files |

### Graceful Degradation

Every external skill has an embedded fallback. Missing skills never block the workflow.

## License

MIT

---

<a id="中文"></a>

# Code Agent Pro

> 面向 AI 编程助手的专业级 Code Agent 技能。将规格先行、代码质量、持续学习作为核心原则。支持 Claude Code、Codex、OpenClaw、Cursor、OpenCode、Trae 等主流 Agent。

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

### 方式一：npx（推荐）

```bash
# 自动安装到所有检测到的 Agent
npx code-agent-pro

# 仅安装到指定 Agent
npx code-agent-pro --claude
npx code-agent-pro --codex
npx code-agent-pro --openclaw
npx code-agent-pro --cursor
npx code-agent-pro --opencode

# 强制覆盖已有安装
npx code-agent-pro --force

# 查看支持的 Agent 及安装状态
npx code-agent-pro --list
```

支持：**Claude Code**、**Codex**、**OpenClaw / QClaw**、**Cursor**、**OpenCode**。

### 方式二：Git Clone

```bash
git clone https://github.com/Eve0211/code-agent-pro.git

# 复制到对应 Agent 的技能目录，例如：
cp -r code-agent-pro ~/.claude/skills/
cp -r code-agent-pro ~/.codex/skills/
cp -r code-agent-pro ~/.qclaw/workspace/skills/
cp -r code-agent-pro ~/.cursor/skills/
cp -r code-agent-pro ~/.config/opencode/skills/
```

### 可选：集成技能

本技能无需任何外部依赖即可完整运行。安装以下技能可获得增强能力：

```bash
skillhub install write-a-prd         # 规格生成
skillhub install superdesign         # 前端设计
skillhub install ui-ux-pro-max       # UX 质量审查
skillhub install github              # Git 工作流
skillhub install webapp-testing      # E2E 测试
```

## 使用方法

### 快速开始

直接描述你想构建的内容。SPEC 工作流会自动激活。

### 项目快速理解

```
/learn ./my-project    → 30 分钟内扫描项目，生成心智模型
```

### 小任务跳过 SPEC

单行 Bug 修复、简单重构、紧急热修复会自动跳过完整工作流。质量门禁始终执行。

## 设计哲学

### 三层能力模型

| 层级 | 内容 | 来源 |
|------|------|------|
| 第一层 | 通用模式（架构、错误处理、测试、安全） | 技能内嵌 |
| 第二层 | 框架专项（React/Next.js 性能规则） | 外部技能 |
| 第三层 | 项目规范（CLAUDE.md、ruff.toml） | 项目文件 |

### 优雅降级

每个外部技能都有内嵌回退。缺失的技能不会阻断工作流。

## 许可证

MIT
