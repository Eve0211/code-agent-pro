[**English**](#english) · [**中文**](#中文)

---

<a id="english"></a>

# Code Agent Pro

> Professional Code Agent skill for AI coding assistants. Treats specification discipline, code quality, and continuous learning as first-class concerns. Works with Claude Code, Codex, OpenClaw, Cursor, OpenCode, Trae, and more.

Inspired by the [Claude Code `/feature-dev` plugin](https://github.com/anthropics/claude-code/tree/main/plugins/feature-dev) philosophy: **never code without a spec**.

## ⚡ Quick Routing

```
// Step 0: Skill Check FIRST (1% rule)
Does any internal skill apply?
 → YES → Invoke skill first, then route
 → NO ↓

// Step 1: Route to workflow
Is this a bug with a clear cause, small scope (≤5 lines), no side effects?
 → YES → Quick Fix (execute directly, 0 overhead)
 → NO ↓

Is this a bug that's blocked — unknown root cause, or fixes that break other things?
 → YES → Debug (Observe → Hypothesize → Verify)
 → NO ↓

Is this feature development, complex refactoring, or a task with unclear requirements?
 → YES → Spec-Driven (Clarify → Announce → Execute → Accept)
```

## Three Iron Rules

1. **Don't move without clarity** — wrong direction + high effort = disaster
2. **Announce before you act** — show what you're about to do, wait for confirmation
3. **No root cause, no code** — don't patch symptoms on a half-fixed bug

## Features

### 🏗️ Three Workflows

| Workflow | Trigger | Definition |
|----------|---------|------------|
| **Quick Fix** | Bug with clear cause, ≤5 lines, no side effects | Direct execution, 0 overhead |
| **Debug** | Blocked bugs, unknown root cause | Observe → Hypothesize → Verify |
| **Spec-Driven** | Features, complex refactors, unclear requirements | Clarify → Announce → Execute → Accept |

### Internal Skills Routing

| Task Type | Skill | When |
|-----------|-------|------|
| New feature / unclear requirements | `brainstorming` | Before writing spec |
| Complex logic / architecture | `writing-plans` | During spec phase |
| UI/UX component | `frontend-design` | When frontend involved |
| Unknown codebase | `learn-project` | First time seeing project |
| Before claiming done | `verification-before-completion` | Before delivery |

### 🗺️ `/learn` Command — Project Onboarding

Run `/learn [path]` to quickly understand any project in ~30 minutes:

| Step | Duration | Output |
|------|----------|--------|
| Surface Scan | 3 min | Project type, tech stack, size |
| Entry Point Trace | 5 min | Startup sequence, API surface |
| Core Flow Deep Dive | 10 min | Main workflows traced end-to-end |
| Pattern Extraction | 5 min | Code style, testing, logging conventions |
| Mental Model | 5 min | `memory/project-map.md` cheat sheet |

### 🧠 Memory System

- 4-layer architecture: session → working → long-term → codebase
- Context window optimization with prioritization and compression

### 🔧 Backend Support (Python / Java / Go / Rust / Node.js)

- **Layered architecture** templates per language
- **Error handling** hierarchies with typed errors
- **Testing strategy** (unit / integration / E2E)
- **Structured logging** setup per language

### 🎨 Frontend Integration

| Phase | Skill | Purpose |
|-------|-------|---------|
| Design | `frontend-design` | Aesthetic differentiation |
| Audit | `ui-ux-pro-max` | 99 UX guidelines, accessibility |

### 🔒 Quality Gates (Mandatory After Every Workflow)

| Gate | Command | Requirement |
|------|---------|-------------|
| Lint | `eslint .` / `ruff check .` / `go vet ./...` | 0 errors |
| Type Check | `tsc --noEmit` / `mypy` | 0 errors |
| Tests | `npm test` / `pytest` | 100% pass |
| Security | Scan for secrets / injection patterns | 0 vulnerabilities |

## Project Structure

```
code-agent-pro/
├── SKILL.md                              # Main entry point
├── skill.json                            # Metadata
├── README.md                             # English docs
├── README_CN.md                          # Chinese docs
├── package.json                          # Skill manifest
├── workflow/
│   └── definitions/
│       ├── quick-fix.md                  # Quick Fix workflow
│       ├── spec-driven.md                # Spec-Driven workflow
│       └── debug.md                      # Debug workflow
├── skills/
│   ├── brainstorming/                    # Requirement clarification
│   ├── writing-plans/                    # Task decomposition
│   ├── frontend-design/                  # UI/UX implementation
│   ├── learn-project/                    # Project onboarding
│   └── verification-before-completion/   # Quality gates
├── references/
│   ├── tdd-lightweight.md                # Lightweight TDD
│   ├── preflight-check.md                # UI task checklist
│   ├── version-compatibility.md          # Framework risks
│   ├── backend-patterns.md               # Backend architecture
│   ├── quality-assurance.md              # Static analysis
│   ├── security-audit.md                 # Security patterns
│   └── learning-loop.md                  # Failure modes
├── analyzers/                            # Code analysis scripts
├── memory/                               # Memory templates
└── scripts/
    ├── setup.sh                          # Dependency check (macOS / Linux)
    └── setup.ps1                         # Dependency check (Windows)
```

## Installation

### Git Clone

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
skillhub install frontend-design        # UI/UX implementation
skillhub install ui-ux-pro-max          # UX quality audit
skillhub install github                 # Git workflow
```

## Usage

### Quick Start

Just describe what you want to build. The workflow activates automatically based on task type.

### Skip SPEC for Small Tasks

Single-line bug fixes, trivial refactors, and emergency hotfixes skip the full workflow. Quality gates always run.

## Anti-Patterns

- Don't start coding without routing to a workflow
- Don't skip quality gates
- Don't claim "done" without verification
- Don't fabricate API signatures
- Don't code without a spec

## License

MIT

---

<a id="中文"></a>

# Code Agent Pro

> 面向 AI 编程助手的专业级 Code Agent 技能。将规格先行、代码质量、持续学习作为核心原则。支持 Claude Code、Codex、OpenClaw、Cursor、OpenCode、Trae 等主流 Agent。

灵感来源于 [Claude Code `/feature-dev` 插件](https://github.com/anthropics/claude-code/tree/main/plugins/feature-dev) 的设计哲学：**永远不要在没有规格的情况下写代码**。

## ⚡ 快速路由

```
// Step 0: 技能检查优先 (1% 规则)
// Step 1: 路由到对应工作流
Bug + 清晰根因 + ≤5 行 + 无副作用?
 → YES → Quick Fix (直接执行，零开销)
 → NO ↓

Bug + 阻塞 + 根因未知?
 → YES → Debug (观察 → 假设 → 验证)
 → NO ↓

新功能 / 复杂重构 / 需求不清晰?
 → YES → Spec-Driven (澄清 → 宣布 → 执行 → 验收)
```

## 三条铁律

1. **没有清晰方向不要动** — 错误方向 + 高投入 = 灾难
2. **行动前先宣布** — 展示你要做什么，等待确认
3. **没有根因不写代码** — 不要在只修一半的 bug 上打补丁

## 功能特性

### 🏗️ 三种工作流

| 工作流 | 触发条件 | 定义文件 |
|--------|----------|----------|
| **Quick Fix** | Bug 根因清晰，≤5 行，无副作用 | `workflow/definitions/quick-fix.md` |
| **Debug** | 阻塞性 bug，根因未知 | `workflow/definitions/debug.md` |
| **Spec-Driven** | 新功能、复杂重构、需求不清晰 | `workflow/definitions/spec-driven.md` |

### 内部技能路由

| 任务类型 | 技能 | 调用时机 |
|----------|------|----------|
| 新功能 / 需求不清晰 | `brainstorming` | 写规格前 |
| 复杂逻辑 / 架构 | `writing-plans` | 规格阶段 |
| UI/UX 组件 | `frontend-design` | 涉及前端 |
| 陌生代码库 | `learn-project` | 首次接触项目 |
| 交付前验证 | `verification-before-completion` | 交付前 |

### 🗺️ `/learn` 命令 — 项目快速理解

运行 `/learn [路径]` 在约 30 分钟内快速理解任何项目：

| 步骤 | 耗时 | 产出 |
|------|------|------|
| 表面扫描 | 3 分钟 | 项目类型、技术栈、规模 |
| 入口点追踪 | 5 分钟 | 启动流程、API 接口 |
| 核心流程深挖 | 10 分钟 | 主要业务流程端到端追踪 |
| 模式提取 | 5 分钟 | 代码风格、测试、日志规范 |
| 心智模型 | 5 分钟 | `memory/project-map.md` 速查表 |

### 🧠 记忆系统

- 4 层架构：会话 → 工作记忆 → 长期记忆 → 代码库记忆
- 上下文窗口优化（优先级排序 + 压缩策略）

### 🔧 后端支持（Python / Java / Go / Rust / Node.js）

- **分层架构** 模板（API → Service → Repository → Domain）
- **错误处理** 层级体系（类型化错误）
- **测试策略**（单元 / 集成 / E2E）
- **结构化日志** 每种语言的配置方式

### 🎨 前端集成

| 阶段 | 技能 | 用途 |
|------|------|------|
| 设计 | `frontend-design` | 美学差异化 |
| 审查 | `ui-ux-pro-max` | 99 条 UX 准则、无障碍 |

### 🔒 质量门禁（每个工作流后强制执行）

| 门禁 | 命令 | 要求 |
|------|------|------|
| Lint | `eslint .` / `ruff check .` / `go vet ./...` | 0 错误 |
| 类型检查 | `tsc --noEmit` / `mypy` | 0 错误 |
| 测试 | `npm test` / `pytest` | 100% 通过 |
| 安全 | 扫描密钥/注入/路径穿越 | 0 漏洞 |

## 项目结构

```
code-agent-pro/
├── SKILL.md                              # 主入口
├── skill.json                            # 元数据
├── README.md                             # 英文文档
├── README_CN.md                          # 中文文档
├── package.json                          # 技能清单
├── workflow/
│   └── definitions/
│       ├── quick-fix.md                  # Quick Fix 工作流
│       ├── spec-driven.md                # Spec-Driven 工作流
│       └── debug.md                      # Debug 工作流
├── skills/
│   ├── brainstorming/                    # 需求澄清
│   ├── writing-plans/                    # 任务分解
│   ├── frontend-design/                  # UI/UX 实现
│   ├── learn-project/                    # 项目入门
│   └── verification-before-completion/   # 质量门禁
├── references/
│   ├── tdd-lightweight.md                # 轻量 TDD
│   ├── preflight-check.md                # UI 任务清单
│   ├── version-compatibility.md          # 框架版本风险
│   ├── backend-patterns.md               # 后端架构
│   ├── quality-assurance.md              # 静态分析
│   ├── security-audit.md                 # 安全模式
│   └── learning-loop.md                  # 失败模式
├── analyzers/                            # 代码分析脚本
├── memory/                               # 记忆模板
└── scripts/
    ├── setup.sh                          # 依赖检测（macOS / Linux）
    └── setup.ps1                         # 依赖检测（Windows）
```

## 安装

### Git Clone

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
skillhub install frontend-design        # UI/UX 实现
skillhub install ui-ux-pro-max          # UX 质量审查
skillhub install github                 # Git 工作流
```

## 使用方法

### 快速开始

直接描述你想构建的内容。工作流会根据任务类型自动激活。

### 小任务跳过 SPEC

单行 Bug 修复、简单重构、紧急热修复会自动跳过完整工作流。质量门禁始终执行。

## 反模式

- 不要在没有路由到工作流的情况下开始写代码
- 不要跳过质量门禁
- 不要在没有验证的情况下声称完成
- 不要伪造 API 签名
- 不要在没有规格的情况下写代码

## 许可证

MIT