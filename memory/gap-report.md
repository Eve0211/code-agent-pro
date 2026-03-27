# Code Agent Pro — Gap Report

> `/learn` 命令完成后，关于不明确区域的问题清单。

---

## 技术层面

### 1. 外部 Skill 集成状态
`write-a-prd` skill 是 SPEC Phase 2 的核心依赖，但当前是软集成（假设存在）。

**问题：**
- 如果 `write-a-prd` skill 不存在，Phase 2 如何降级？
- 是否需要内嵌一个简化版 PRD 模板作为 fallback？

### 2. 前端框架覆盖范围
当前只对 React/Next.js 有专项 skill 集成（`vercel-react-best-practices`）。

**问题：**
- Vue / Svelte / Solid 是否也需要专项 skill？
- 还是它们的问题足够透明，不需要特殊处理？

### 3. 多语言项目的处理策略
如果一个项目同时有 Python 后端 + React 前端，SPEC 工作流如何适配？

**问题：**
- 是否需要同时加载多个 backend + frontend references？
- 还是只加载当前任务相关部分？

---

## 流程层面

### 4. Plan Mode 的用户确认机制
Plan Mode 输出后，用户说 "proceed" 退出 Plan Mode 并实施。

**问题：**
- 如果用户只确认部分方案怎么办？
- 是否需要支持 "proceed with T1-T3 only" 这种分步确认？

### 5. 质量门禁的失败处理
Phase 5 质量门禁检测到 P0 问题时的标准流程是什么？

**问题：**
- 自动修复 → 重新检测？
- 报告给用户 → 等待用户决策？
- 有没有最大重试次数限制？

### 6. Failure Mode Library 的持久化
学习闭环中的失败记录应该写到哪里？

**问题：**
- 写入项目目录 `.code-agent-pro/failures/`？
- 写入用户全局 `~/.code-agent-pro/failures/`？
- 还是由 Agent 自己的 memory 系统管理？

---

## 安装与发布

### 7. npm 发布
当前 `package.json` 配置完整，但未发布到 npm registry。

**问题：**
- 是否需要现在发布？
- 如果要发布，npm 账号准备好了吗？

### 8. 安装脚本的 Trae 支持
install.js 列出了 Trae 作为支持的 Agent，但路径不确定。

**问题：**
- Trae 的 skills 目录在哪里？`.trae/rules/`？
- 需要验证实际路径。

---

## 下一步建议

1. **高优先级**：确认 `write-a-prd` skill 的 fallback 策略
2. **中优先级**：验证 Trae 安装路径
3. **低优先级**：npm 发布（等你准备好 npm 账号）

---

你想先讨论哪个问题？
