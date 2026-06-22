---
created: 2026-06-19
module: B
total_pomodoros: 5
tags:
  - Vercel
  - Sandbox
  - 云开发
  - AI
  - 教程
---

# 模块B：Vercel Sandbox 云开发环境（5🍅）

> 目标：掌握 Vercel Sandbox——一个可在云端安全运行代码的隔离微VM环境

---

## 🍅11 Sandbox 概念与创建（25分钟）

### 费曼输入

Vercel Sandbox 是运行在 **Firecracker 微 VM** 中的隔离环境。它就像一台"一次性云电脑"——你可以安装软件、运行代码、启动服务，用完即销毁。

**核心用途**：
- 安全执行 AI 生成的代码（防止恶意代码影响生产环境）
- 运行不受信任的第三方脚本
- 创建临时的开发/测试环境
- 在线编程教育平台

**关键特性**：
- 内核级隔离：每个 Sandbox 有独立内核
- 支持 Node.js (22/24/26) 和 Python 3.13
- 支持 Docker、VPN、FUSE（需要 sudo 权限）
- 持久存储：文件系统自动保存，下次启动恢复
- 最多 8 vCPU，2GB RAM 每 vCPU

### 刻意练习

```bash
# 1. 安装 Sandbox CLI
npm install -g sandbox

# 2. 登录
sandbox login

# 3. 创建第一个 Sandbox
sandbox create my-first-sandbox

# 4. 运行命令
sandbox exec my-first-sandbox -- 'echo "Hello from Sandbox!"'

# 5. 交互式 Shell
sandbox shell my-first-sandbox

# 在里面可以：
node --version    # Node.js 24
python3 --version # Python 3.13
ls -la
echo 'console.log("hi")' > test.js && node test.js
exit  # 退出 shell，Sandbox 保留状态
```

### ✅ 完成标准

- [ ] 安装 Sandbox CLI 并登录
- [ ] 创建第一个 Sandbox 并执行命令
- [ ] 体验交互式 Shell
- [ ] 理解 Sandbox 的基本使用场景

### 📖 费曼三句话

1. Sandbox 是 Vercel 提供的一台"一次性云电脑"，用完可以销毁
2. 每个 Sandbox 完全隔离，在里面干任何事都不会影响其他应用
3. 文件系统是持久的——退出后重新进入，文件还在

---

## 🍅12 Sandbox SDK 编程操作（25分钟）

### 费曼输入

除了 CLI，还可以通过 **JavaScript/TypeScript SDK** 编程式地操作 Sandbox。这让开发者可以在自己的应用里动态创建和管理 Sandbox。

### 刻意练习

```bash
# 1. 安装 SDK
npm install @vercel/sandbox
```

```typescript
// sandbox-sdk-demo.ts
import { Sandbox } from '@vercel/sandbox';

async function main() {
  // 创建 Sandbox
  const sandbox = await Sandbox.create({
    name: 'demo-sandbox',
    runtime: 'node24',
    cpu: 2,
    persistent: true
  });

  console.log('Sandbox ID:', sandbox.id);

  // 执行命令
  const result = await sandbox.exec('echo "Hello SDK!" && node -e "console.log(1+1)"');
  console.log('输出:', result.stdout);
  console.log('退出码:', result.exitCode);

  // 写入文件
  await sandbox.writeFile('/home/user/app.js', `
    const express = require('express');
    const app = express();
    app.get('/', (req, res) => res.send('Hello from Sandbox!'));
    app.listen(3000, () => console.log('Server running'));
  `);

  // 安装依赖
  const install = await sandbox.exec('cd /home/user && npm init -y && npm install express');
  console.log('依赖安装完成');

  // 启动服务（后台）
  await sandbox.exec('cd /home/user && node app.js &');

  // 创建可公开访问的 URL
  const url = await sandbox.publishPort(3000);
  console.log('服务运行在:', url);

  // 获取 Sandbox 状态
  const status = await sandbox.status();
  console.log('状态:', status);

  // 销毁
  // await sandbox.destroy();
}

main().catch(console.error);
```

### ✅ 完成标准

- [ ] 安装 `@vercel/sandbox` SDK
- [ ] 用 SDK 创建 Sandbox 并执行命令
- [ ] 用 SDK 上传文件并安装依赖
- [ ] 发布端口获得公开访问 URL

### 📖 费曼三句话

1. Sandbox SDK 让你用 JavaScript 代码来控制 Sandbox 的创建/运行/销毁
2. 上传文件 → 安装依赖 → 启动服务 → 生成公开 URL 是一条完整的工作流
3. 发布端口功能可以给 Sandbox 里的服务一个临时域名

---

## 🍅13 持久化 Sandbox 与快照（25分钟）

### 费曼输入

持久化 Sandbox (2026 GA) 会自动保存文件系统状态并在下次使用时恢复。这意味着你可以在 Sandbox 中做复杂的开发工作，关闭后回来继续。

**核心 API**：
- `Sandbox.get(id)` — 恢复已有 Sandbox
- `Sandbox.fork(id)` — 从现有 Sandbox 创建分支（类似 git fork）
- `Sandbox.getOrCreate(name, opts)` — 获取或创建
- 生命周期钩子：`onCreate`、`onResume`

### 刻意练习

```typescript
import { Sandbox } from '@vercel/sandbox';

// 方案1：getOrCreate — 同名复用
const devEnv = await Sandbox.getOrCreate('my-dev-env', {
  runtime: 'node24',
  cpu: 2,
  persistent: true
});

// 方案2：fork — 基于模板创建
const template = await Sandbox.get('base-node-env');
const project = await template.fork('project-123', {
  persistent: true
});

// 方案3：生命周期钩子
const sandbox = await Sandbox.create({
  name: 'worker-pool-1',
  persistent: true,
  onCreate: async (sb) => {
    // 首次创建时执行初始化
    await sb.exec('npm install -g typescript ts-node');
    console.log('初始化完成');
  },
  onResume: async (sb) => {
    // 从持久化恢复时检查状态
    const status = await sb.exec('systemctl is-active my-service');
    console.log('服务状态:', status.stdout);
  }
});

// 快照管理
const snapshot = await sandbox.snapshot();  // 手动创建快照
const snapshots = await sandbox.listSnapshots();  // 列出快照
await sandbox.restore(snapshot.id);  // 恢复到某个快照
```

### ✅ 完成标准

- [ ] 理解持久化 Sandbox 的工作原理
- [ ] 用 `getOrCreate` 实现 Sandbox 复用
- [ ] 用 `fork` 从模板创建新的 Sandbox
- [ ] 理解生命周期钩子的使用场景
- [ ] 掌握快照管理的基本操作

### 📖 费曼三句话

1. 持久化 = Sandbox 关了再开，文件和状态还在，就像电脑睡眠唤醒
2. fork = 从现有的 Sandbox 复制一份作为新起点，就像 git clone
3. 生命周期钩子让你在创建/恢复时自动执行初始化代码

---

## 🍅14 安全策略与网络配置（25分钟）

### 费曼输入

Sandbox 的核心优势之一是安全隔离。通过配置网络策略，可以控制 Sandbox 能访问哪些外部资源——这对执行 AI 生成的不信任代码至关重要。

**网络策略等级**：

| 策略 | 允许 | 拒绝 | 适用场景 |
|:-----|:-----|:------|:---------|
| `allow-all` | 所有出站连接 | — | 一般开发环境 |
| `deny-all` | — | 所有出站连接 | 执行完全不信任代码 |
| `allowed-domain` | 指定的域名/IP | 其他所有 | AI 代码执行 + 安全API |

### 刻意练习

```typescript
import { Sandbox, NetworkPolicy } from '@vercel/sandbox';

// 限制网络的白名单 Sandbox
const secureSandbox = await Sandbox.create({
  name: 'secure-exec',
  runtime: 'node24',
  network: {
    policy: NetworkPolicy.ALLOWED_DOMAINS,
    allowedDomains: [
      'api.openai.com',
      'api.github.com',
      'registry.npmjs.org'
    ]
  },
  // 禁止 sudo（防止系统级操作）
  allowSudo: false
});

// 执行不信任代码
const code = `
  // 这段代码无法访问外部网络（除了白名单）
  // 无法运行系统级命令
  const result = await fetch('https://api.openai.com/v1/models');
  // fetch('https://malicious-site.com') ❌ 会被阻止
  console.log('代码在沙盒中安全执行');
`;

const result = await secureSandbox.exec(`node -e "${code.replace(/"/g, '\\"')}"`);
console.log(result.stdout);
```

**Sandbox 安全最佳实践**：

| 做法 | 说明 |
|:-----|:------|
| 最小权限网络 | 只允许 API 白名单，拒绝一切其他出站 |
| 禁用 sudo | 禁止系统级操作 |
| 超时控制 | 设置 Sandbox 最大运行时间（Hobby 45min，Pro 5h） |
| 资源限制 | 限制 CPU 和内存，防止资源耗尽攻击 |
| 输入净化 | 在执行用户代码前做输入验证 |
| 审计日志 | 记录所有 Sandbox 操作 |

### ✅ 完成标准

- [ ] 理解三种网络策略的差异和适用场景
- [ ] 创建一个受网络限制的安全 Sandbox
- [ ] 理解 Sandbox 安全最佳实践
- [ ] 能设计安全的代码执行沙盒方案

### 📖 费曼三句话

1. Sandbox 的安全核心是"隔离"——里面跑什么都不会影响外面
2. 网络白名单控制 Sandbox 能连哪些服务器，是最重要的安全措施
3. 执行不信任代码时：限制网络 + 禁用系统权限 + 设置超时 = 三层保护

---

## 🍅15 AI 代码安全执行实战（25分钟）

### 费曼输入

Sandbox 最常见的应用场景是**安全执行 AI 生成的代码**。当 v0、Claude、GPT 等 AI 工具生成代码时，先在 Sandbox 中隔离运行验证，确认安全后再部署。

**典型工作流**：
```
AI 生成代码 → Sandbox 隔离执行 → 验证结果 → 确认安全 → 部署到生产
```

### 刻意练习

```typescript
import { Sandbox, NetworkPolicy } from '@vercel/sandbox';

// 定义一个"AI 代码执行器"
class AICodeExecutor {
  async executeAICode(code: string, language: 'js' | 'py' = 'js') {
    // 1. 创建安全沙盒
    const sandbox = await Sandbox.create({
      name: `ai-exec-${Date.now()}`,
      runtime: language === 'js' ? 'node24' : 'python3.13',
      cpu: 1,
      network: { policy: NetworkPolicy.DENY_ALL },  // 禁止网络
      allowSudo: false,
      persistent: false,  // 用完即毁
      timeout: 30_000  // 30 秒超时
    });

    try {
      // 2. 写入代码文件
      const filename = language === 'js' ? 'script.js' : 'script.py';
      await sandbox.writeFile(`/home/user/${filename}`, code);

      // 3. 执行代码
      const runCommand = language === 'js' ? 'node' : 'python3';
      const result = await sandbox.exec(
        `${runCommand} /home/user/${filename}`,
        { timeout: 25_000 }
      );

      return {
        success: result.exitCode === 0,
        output: result.stdout,
        error: result.stderr,
        exitCode: result.exitCode
      };
    } finally {
      // 4. 销毁沙盒（自动清理）
      await sandbox.destroy().catch(() => {});
    }
  }
}

// 使用示例
const executor = new AICodeExecutor();

// 安全代码
const safeCode = `
  function fibonacci(n) {
    if (n <= 1) return n;
    return fibonacci(n-1) + fibonacci(n-2);
  }
  console.log('fib(10) =', fibonacci(10));
`;

const result = await executor.executeAICode(safeCode);
console.log(result.output);  // fib(10) = 55

// 不安全代码（在 Sandbox 中无害）
const unsafeCode = `
  // 尝试删除文件系统（在 Sandbox 中不影响外部）
  const fs = require('fs');
  fs.rmSync('/', { recursive: true });
  console.log('inside sandbox only');
`;

const badResult = await executor.executeAICode(unsafeCode);
console.log('Sandbox 已隔离，外部安全');
```

### ✅ 完成标准

- [ ] 理解 AI 代码安全执行的完整工作流
- [ ] 实现一个基本的 AI 代码执行器
- [ ] 验证 Sandbox 对恶意代码的隔离能力
- [ ] 理解"创建 → 执行 → 销毁"的生命周期管理

### 📖 费曼三句话

1. AI 生成的代码不能直接信任，先放到 Sandbox 跑一遍确认安全
2. 安全三层：禁止网络 + 禁止系统权限 + 用完销毁
3. Sandbox 是 AI 时代的"消毒室"——所有不干净的代码先过一遍再进生产

---

## 🍅 模块B 综合考核

1. 用 SDK 创建一个持久化 Sandbox，安装 Express，写一个 Hello API
2. 从该 Sandbox fork 一个新版本，修改 API 添加一个新路由
3. 创建一个受网络限制的安全 Sandbox，让 AI 生成代码在里面安全执行
4. 写三句话总结什么时候用 Sandbox 以及如何确保安全

**预期耗时**：45-60分钟（2个番茄）
**完成标准**：能独立创建和管理 Sandbox，能设计安全的 AI 代码执行方案
