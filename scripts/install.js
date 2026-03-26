#!/usr/bin/env node

// Code Agent Pro — Cross-Agent Installer
// Supports: Claude Code, Codex, OpenClaw/QClaw, OpenCode, Trae, Cursor

import { existsSync, mkdirSync, cpSync, readdirSync, statSync } from "fs";
import { join, resolve, dirname } from "path";
import { fileURLToPath } from "url";
import { homedir, platform } from "os";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const SKILL_DIR = resolve(__dirname, "..");

// ── Colors ──────────────────────────────────────────────────
const C = {
  reset: "\x1b[0m",
  green: "\x1b[32m",
  red: "\x1b[31m",
  yellow: "\x1b[33m",
  blue: "\x1b[34m",
  dim: "\x1b[2m",
  bold: "\x1b[1m",
};

function log(msg, color = C.reset) {
  console.log(`${color}${msg}${C.reset}`);
}

function logOk(msg) { log(`  ✅ ${msg}`, C.green); }
function logMiss(msg) { log(`  ❌ ${msg}`, C.red); }
function logInfo(msg) { log(`  ℹ️  ${msg}`, C.blue); }
function logWarn(msg) { log(`  ⚠️  ${msg}`, C.yellow); }

// ── Agent Detection ─────────────────────────────────────────

const AGENTS = [
  {
    name: "Claude Code",
    id: "claude",
    paths: [
      join(homedir(), ".claude", "skills"),
      join(homedir(), ".claude", "commands"),
    ],
  },
  {
    name: "Codex",
    id: "codex",
    paths: [join(homedir(), ".codex", "skills")],
  },
  {
    name: "OpenClaw / QClaw",
    id: "openclaw",
    paths: [join(homedir(), ".qclaw", "workspace", "skills")],
  },
  {
    name: "OpenCode",
    id: "opencode",
    paths: [join(homedir(), ".config", "opencode", "skills")],
  },
  {
    name: "Cursor",
    id: "cursor",
    paths: [
      join(homedir(), ".cursor", "rules"),
      join(homedir(), ".cursor", "skills"),
    ],
  },
];

// ── Install Logic ──────────────────────────────────────────

function getTargetDir(agent) {
  for (const p of agent.paths) {
    return p; // Use first path regardless of existence
  }
  return null;
}

function copySkill(sourceDir, targetDir) {
  const items = ["SKILL.md", "skill.json"];

  // Copy top-level files
  for (const item of items) {
    const src = join(sourceDir, item);
    if (existsSync(src)) {
      const dst = join(targetDir, "code-agent-pro", item);
      cpSync(src, dst, { force: true });
    }
  }

  // Copy directories
  const dirs = ["references", "scripts"];
  for (const dir of dirs) {
    const src = join(sourceDir, dir);
    if (existsSync(src)) {
      const dst = join(targetDir, "code-agent-pro", dir);
      mkdirSync(dst, { recursive: true });
      cpSync(src, dst, { recursive: true });
    }
  }
}

function isInstalled(targetDir) {
  return existsSync(join(targetDir, "code-agent-pro", "SKILL.md"));
}

// ── Parse Args ──────────────────────────────────────────────

function parseArgs() {
  const args = process.argv.slice(2);
  const opts = { target: null, list: false, force: false, all: true };

  for (let i = 0; i < args.length; i++) {
    const arg = args[i];
    if (arg === "--help" || arg === "-h") {
      opts.help = true;
    } else if (arg === "--list" || arg === "-l") {
      opts.list = true;
    } else if (arg === "--force" || arg === "-f") {
      opts.force = true;
    } else if (arg === "--all" || arg === "-a") {
      opts.all = true;
    } else if (arg.startsWith("--")) {
      // Treat any --xxx as agent id (e.g. --claude, --openclaw, --cursor)
      opts.target = arg.slice(2).toLowerCase();
    } else {
      opts.target = arg.toLowerCase();
    }
  }
  return opts;
}

// ── Main ────────────────────────────────────────────────────

function main() {
  const opts = parseArgs();

  if (opts.help) {
    log("\n  code-agent-pro — Cross-Agent Skill Installer\n", C.bold);
    log("  Usage:\n");
    log("    npx code-agent-pro              Install to all detected agents");
    log("    npx code-agent-pro --claude     Install to Claude Code only");
    log("    npx code-agent-pro --codex      Install to Codex only");
    log("    npx code-agent-pro --openclaw   Install to OpenClaw / QClaw only");
    log("    npx code-agent-pro --cursor     Install to Cursor only");
    log("    npx code-agent-pro --list       List installable agents");
    log("    npx code-agent-pro --force      Overwrite existing installation");
    log("");
    return;
  }

  if (opts.list) {
    log("\n  Available agents:\n", C.bold);
    for (const agent of AGENTS) {
      const dir = getTargetDir(agent);
      const installed = isInstalled(dir);
      const status = installed ? "installed" : "not installed";
      const color = installed ? C.green : C.dim;
      log(`    ${agent.name.padEnd(20)} ${dir}  ${C.dim}(${status})${C.reset}`);
    }
    log("");
    return;
  }

  // Determine targets
  let targets = [];
  if (opts.target) {
    const agent = AGENTS.find((a) => a.id === opts.target);
    if (!agent) {
      log(`\n  Unknown agent: ${opts.target}`, C.red);
      log(`  Available: ${AGENTS.map((a) => a.id).join(", ")}\n`, C.dim);
      process.exit(1);
    }
    targets = [agent];
  } else {
    targets = AGENTS;
  }

  log("");
  log("  ╔═══════════════════════════════════════╗", C.bold);
  log("  ║   Code Agent Pro — Installer         ║", C.bold);
  log("  ╚═══════════════════════════════════════╝", C.bold);
  log("");

  let installed = 0;
  let skipped = 0;
  let failed = 0;

  for (const agent of targets) {
    const targetDir = getTargetDir(agent);
    if (!targetDir) continue;

    const alreadyInstalled = isInstalled(targetDir);

    if (alreadyInstalled && !opts.force) {
      logOk(`${agent.name} — already installed at ${targetDir}`);
      skipped++;
      continue;
    }

    try {
      mkdirSync(targetDir, { recursive: true });
      copySkill(SKILL_DIR, targetDir);

      if (alreadyInstalled && opts.force) {
        logOk(`${agent.name} — reinstalled at ${targetDir}`);
      } else {
        logOk(`${agent.name} — installed to ${targetDir}`);
      }
      installed++;
    } catch (err) {
      logMiss(`${agent.name} — failed: ${err.message}`);
      failed++;
    }
  }

  log("");
  if (installed > 0) {
    log(`  Done! Installed to ${installed} agent(s).`, C.green);
  }
  if (skipped > 0) {
    log(`  Skipped ${skipped} (already installed). Use --force to reinstall.`, C.dim);
  }
  if (failed > 0) {
    log(`  ${failed} installation(s) failed.`, C.red);
  }
  log("");
}

main();
