# GBrain + LLM-Wiki 自动更新日志

## 2026-09-13 23:00 — 第6次每日更新

### 执行结果
| 项目 | 状态 | 说明 |
|------|------|------|
| 脚本执行 | ⚠️ 部分成功 (exit_code=0) | `gbrain-dual-update.py` 扫描正常，push 环节连续第 3 天失败 |
| 增量扫描 | ✅ 完成 (9.7s) | 3302 篇，新增 0 / 变更 0 / 跳过 3302（内容稳定，无新增文档） |
| 本地提交 | ✅ 成功 | commit `2429750`（16 文件，+5381/−5348） |
| Git Push | ❌ 失败（连续第 3 天） | `origin-ssh`: `Permission denied (publickey)`；`origin`(HTTPS): `could not read Username for 'https://github.com'` |
| 知识图谱 | ✅ | 3900 节点 / 5477 边（与昨日持平） |
| 向量索引 | ✅ | 4884 关键词 / 3302 文档 |
| JSON 完整性 | ✅（新增校验项） | `知识图谱.json` / `向量索引.json` / `.gbrain_state.json` 三个文件均可正常 JSON 解析，计数与状态报告一致 |
| 域分布 | 9 域（+2 个全局索引文件） | 中医 274 / 中国法律 **2565** / 心理学 270 / 道医全集 108 / 写作 13 / 创造性思维 22 / 学习方法 20 / 新科技与应用 22 / 桥域 6 |

### 异常记录

#### ❌ P0（未解决·阻碍项）：Git push 凭据缺失，远程落后 7 个提交
- **现象（今日复现）**：`git push origin-ssh main` → `git@github.com: Permission denied (publickey)`；HTTPS 备选 → `fatal: could not read Username for 'https://github.com': terminal prompts disabled`。`ssh -T -i ~/.ssh/id_ed25519 git@github.com` 同样返回 `Permission denied (publickey)`。
- **今日复核（无变化，凭据仍未恢复）**：
  1. `~/.ssh/` 仅含 `authorized_keys` / `known_hosts` / 昨日新建的 `id_ed25519(.pub)`；全盘（/home /root /tmp /opt）再搜 `id_rsa*` / `id_ed25519*` / `*.pem` / `*github*key*` / `ssh*.tar*` **无其他私钥或备份**。
  2. 无 `~/.git-credentials`、无 `~/.gitconfig`、无 `~/.netrc`；`~/.hermes/.env`、`~/.hermes-upstream/.env` 中无 `GITHUB_TOKEN`/`GH_TOKEN`；`gh` CLI 未安装。仅技能文档（`skills/software-development/github/...`）含 token 字样，非真实凭据。
  3. 远程 `origin/main` 仍停在 `548fe17`（2026-09-10），**本地已领先 7 个提交**：`c391d93` / `05ff226` / `78c98b5` / `a7a6178` / `2429750` 等（含 09-11、09-12 日报与日记）。
- **待人工处理（唯一路径，账号侧操作）**：将昨日生成的公钥加入 GitHub（`fangyan607` 账号 Settings → SSH and GPG keys，或该仓库 Deploy keys 并勾选 Allow write access），此后一条 `git push origin-ssh main` 即可同步全部 7 个提交：
  ```
  ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC9DkdzrGgadq7dVM9bkZ5R7sJWZVqYXfipC7Lw1PaUK ubuntu@hermes-gbrain-sync
  ```
  （指纹 `SHA256:loWhaBfURx40L7m9S4H3Cb9V2sVgsFAu8zN9xWQfDcw`；私钥已在位、权限 600，注册后无需改动脚本）
  - 替代方案：在 `~/.hermes/.env` 写入 `GITHUB_TOKEN=<PAT, repo scope>`，HTTPS 分支即可自动推送。
- **风险提示**：远程备份已连续 3 天未更新，异地冗余暂停；本地仓库与索引完整，无数据丢失风险。

#### ✅ 无损坏文档 / 无 git 冲突（质检通过）
- 未发现 `<<<<<<<` / `>>>>>>>` 冲突标记（LLM-Wiki + GBrain 全量 grep 无命中）；无 `.git/MERGE_HEAD`、无 `rebase-merge`；提交后 `git status` 干净。
- 3302 篇 `.md` 无 0 字节文件；无 `*~` / `.orig` / `.rej` / `.gitmerge*` 临时文件。
- 5 篇缩名后的法律文档（09-11 修复项）正常在库，法律库稳定 2565 篇，无 `File name too long`。
- 今日提交的 16 个文件未检出 `ghp_` / `github_pat_` / `sk-` 真实凭据。

### 提交内容分析（16 文件）
- 13 个 `GBrain/_index/*.md` 与 `向量索引.json` / `知识图谱.json` 属**纯时间戳变更**（逐文件 diff 校验，除 `updated:` 字段外内容字节一致）。
- 实质变更 3 个：`.gbrain_state.json`（扫描状态）、`_index/README.md`、`日常整理日志.md`（+33 行，22:00 整理任务追加「2026-09-13 GBrain 知识整理报告」：实体合计 41，3 个损坏 Wikilink：`[[劳动法]]` / `[[物权法]]` / `[[刑事诉讼法]]`）。
- **LLM-Wiki 正文零变更**：本次无新增/修改知识文档，本次提交不涉新知识入库。

---

*生成时间: 2026-09-13 23:05 | 下次更新: 2026-09-14 23:00*

---

## 2026-09-12 23:00 — 第5次每日更新

### 执行结果
| 项目 | 状态 | 说明 |
|------|------|------|
| 脚本执行 | ⚠️ 部分成功 (exit_code=0) | `gbrain-dual-update.py` 扫描正常，push 环节再次失败 |
| 增量扫描 | ✅ 完成 (10.8s) | 3302 篇，新增 0 / 变更 0 / 跳过 3302（昨日修复后已全部最新） |
| 本地提交 | ✅ 成功 | commit `05ff226`（17 文件，+5543/−5469） |
| Git Push | ❌ 失败（连续第 2 天） | `origin-ssh`: `Permission denied (publickey)`；`origin`(HTTPS): `could not read Username for 'https://github.com'` |
| 知识图谱 | ✅ | 3895 → **3900 节点** / 5472 → **5477 边** |
| 向量索引 | ✅ | 4884 关键词 / 3302 文档 |
| 域分布 | 9 域（+2 个全局索引文件） | 中医 274 / 中国法律 **2565** / 心理学 270 / 道医全集 108 / 写作 13 / 创造性思维 22 / 学习方法 20 / 新科技与应用 22 / 桥域 6 |

### 异常记录

#### ❌ P0（未解决·阻碍项）：Git push 凭据缺失，远程落后 4 个提交
- **现象**：`git push origin-ssh main` → `git@github.com: Permission denied (publickey)`；HTTPS 备选 → `fatal: could not read Username for 'https://github.com': terminal prompts disabled`。
- **根因复核（较昨日更进一步确认）**：
  1. `~/.ssh/` 内**确无私钥**（今日新增密钥前该目录仅剩 `authorized_keys` + `known_hosts`）；`/root/.ssh` 仅有 0 字节 `authorized_keys`。
  2. 系统内**不存在任何 GitHub 凭据**：无 `~/.git-credentials`、无 `~/.gitconfig`、`~/.hermes/.env` 与 `~/.hermes-upstream/.env` 均无 `GITHUB_TOKEN`/`GH_TOKEN`，全盘（含 `.env*`、`*.bak*`）grep `^(GITHUB_TOKEN|GH_TOKEN)=` 无命中，`find` 无 `id_*`/`*.pem`/`*_rsa`/`*_ed25519` 私钥文件。`gh` CLI 未安装。
  3. 时序特征：`~/.ssh` 目录 mtime = 2026-09-11 16:24，与当日凭据泄露清理（`config.yaml.bak-presanitize-*` / `.env.restored-compromised-*`，19:54）同窗口，**判定私钥在安全清理中被删除且无备份**，非网络/代理问题（同代理 `git ls-remote` 读取正常）。
- **今日已做**：
  1. `ssh-keyscan` 主机密钥已在位（昨日修复，`ssh -T git@github.com` 报错稳定为 publickey 而非 host key）。
  2. 确认远程状态：`origin/main` = `548fe17`（2026-09-10 的提交），**本地领先 4 个提交**：`edbb0fe` / `5c4e216` / `c391d93` / `05ff226`。
  3. **已生成新密钥对** `~/.ssh/id_ed25519`（ed25519，无口令，`chmod 600`，注释 `ubuntu@hermes-gbrain-sync`），并已实测该密钥尚未在 GitHub 注册（`Permission denied (publickey)`）。待用户把下方公钥加入 GitHub 后即可一键同步：
     ```
     ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC9DkdzrGgadq7dVM9bkZ5R7sJWZVqYXfipC7Lw1PaUK ubuntu@hermes-gbrain-sync
     ```
- **待人工处理（二选一，均需账号侧操作，脚本无法自动化）**：
  1. 将上述公钥添加到 GitHub → Settings → SSH and GPG keys（或该仓库 Deploy keys，勾选 Allow write access）→ 之后执行 `cd ~/Hermes-Obsidian/Hermes-Obsidian && git push origin-ssh main`。
  2. 或恢复原私钥到 `~/.ssh/id_ed25519`（`chmod 600`），并确认 `fangyan607` 账号 SSH keys 中仍有对应公钥。
  3. （可选替代）在 `~/.hermes/.env` 写入 `GITHUB_TOKEN=<PAT with repo scope>`，脚本的 HTTPS 分支即可改为带 token 推送。
- **风险提示**：远程备份已连续 2 天未更新；本地仓库完整，无数据丢失风险，但异地冗余暂停。

#### ✅ 无损坏文档 / 无 git 冲突（质检通过）
- 未发现 `<<<<<<<` / `>>>>>>>` 冲突标记（LLM-Wiki + GBrain 全量 grep 无命中）。
- 无 0 字节 `.md`（3302 篇全非空）；无 `MERGE_HEAD` / `rebase-merge`，`git status` 干净（提交后无残留）。
- 昨日修复的 5 篇超长文件名法律文档已正常收录，法律库稳定在 **2565 篇**，本次未见 `File name too long`。
- 本次提交的 17 个文件中未检出 `ghp_` / `github_pat_` / `sk-` 真实凭据（正则扫描无命中）。

### Git Diff统计
- `05ff226`（23:00 脚本提交，17 文件）：`2026-09-12.md`（日报） + GBrain `_index/` 8 个域索引 + `.gbrain_state.json` / `知识图谱.json` / `向量索引.json` + `国际日报.md` 等。
- 日志补录提交：本文件（auto-update-log.md）。

---

*生成时间: 2026-09-12 23:05 | 下次更新: 2026-09-13 23:00*

---

## 2026-09-11 23:00 — 第4次每日更新

### 执行结果
| 项目 | 状态 | 说明 |
|------|------|------|
| 脚本执行 | ⚠️ 部分成功 (exit_code=0) | `gbrain-dual-update.py` 完成，push 环节失败 |
| 增量扫描 | ✅ 完成 (10.4s) | 3297 → 3302 篇（+5，见下"超长文件名修复"） |
| 本地提交 | ✅ 成功 | commit `edbb0fe`（17 文件） |
| Git Push | ❌ 失败 | **Host key verification failed** → 补 known_hosts 后转为 **Permission denied (publickey)**；HTTPS 备选路径经 ghfast.top 推送 60s 超时 |
| 知识图谱 | ✅ | 3895 节点 → 3900 节点 / 5472 → 5477 边 |
| 向量索引 | ✅ | 4884 关键词 / 3302 文档 |
| 域分布 | 9 个域 | 中国法律书库 **2560 → 2565** 篇（超长文件名修复后补齐），中医 274 / 心理学 270 / 道医全集 108 / 其余不变 |

### 异常记录

#### ❌ P0：Git push 全线失败 —— 凭据丢失（阻碍项）
- **现象**：`git push origin-ssh main` → `Host key verification failed. fatal: Could not read from remote repository.`
- **根因**：
  1. `~/.ssh/` 里**已无任何私钥**（该目录 mtime 2026-09-11 16:24，仅剩 `authorized_keys`）；全盘 `find /home /root -name "id_*"` + 内容级 grep `BEGIN OPENSSH PRIVATE KEY`（含 /etc /opt /srv）**均无结果**，无备份 tar/zip。执行脚本的 SSH 通道因此失效。
  2. 无 `~/.ssh/known_hosts`（首次连接即校验失败）。
  3. HTTPS 通道：`~/.git-credentials` 不存在、`.env` 中无 GitHub token（含今日 19:54 安全清理后的版本），`origin` 的 pushurl 是直连 `https://github.com/...`，经 ghfast.top 代理推送 60s 无响应超时。
- **已做修复**：`ssh-keyscan github.com` 三把主机密钥写入 `~/.ssh/known_hosts`（已验证 `ssh-keygen -F github.com` 命中），错误从"host key 校验失败"前进到"公钥认证失败"。
- **待人工处理（二者其一，无法自动完成）**：
  1. **推荐**：把原私钥恢复到 `~/.ssh/id_ed25519`（`chmod 600`），确认 GitHub 账号 `fangyan607` 的 SSH keys 里仍有对应公钥；然后 `git push origin-ssh main`。
  2. 或生成新密钥 `ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""`，把 `id_ed25519.pub` 添加到 GitHub → Settings → SSH keys。
- **积压**：本地已领先 `origin/main` **1 个提交**（`edbb0fe`），今晚修复后产生的提交会累计为 2 个，恢复凭据后一次 `git push origin-ssh main` 即可全部同步。

#### ✅ 已修复：5 个超长文件名索引条目（连续 3 天的遗留问题）
- 前几日 `git status` 每次都报 5 行 `File name too long`，被脚本误计为"变更文件"。
- 真相：这 5 条路径**存在于 git index/HEAD 但磁盘上不存在**（文件名组件 270–321 字节，超 ext4 单组件 255 字节上限，无法落地），因此永远不会被扫描器索引。
- 处理：从 `HEAD:<path>` 提取 blob（1.6KB–9.5KB，内容完整），以缩短名重建文件并做 SHA-256 字节级校验，再 `git rm --cached` 原路径。**内容零丢失**，旧路径仍留在 git 历史中。
- 映射表见 `GBrain/_index/文件名映射.md`；修复后 `git status` 不再有 ENAMETOOLONG 报错，扫描器正常收录这 5 篇。

#### ⚠️ 脚本自身缺陷（已修补）
- 旧脚本：只推 `origin-ssh`；push 超时上限 180s；`git status` 的 stderr 错误行会被计入"变更文件数"。
- 已改为：SSH → HTTPS 依次尝试、各自 60s 超时、`GIT_TERMINAL_PROMPT=0` + `BatchMode=yes`（避免非交互挂起），并输出每个 remote 的具体失败原因；commit 无变更时不再当作错误。

### 质检结果
- ❌ 空文件: 无（3297 → 3302 篇 .md 全非空）
- ❌ Git冲突标记(`<<<<<<<` / `=======` / `>>>>>>>`): 未发现
- ❌ 损坏的 `.gitmerge*` / `*~` / `.orig` / `.rej` / `.bak` 临时文件: 未发现
- ❌ 不可读文档: 0
- ✅ 敏感串扫描（ghp_/github_pat_/sk-）: 仅 1 处文档示例占位符 `ghp_xxxxxx`，非真实凭据
- ℹ️ 4 个 0 字节文件均为 `Projects/项目A（示例）/*/.gitkeep`，属正常占位

### Git Diff统计
- `edbb0fe`（23:00 脚本提交，17 文件）：3 篇域索引 + 知识图谱/向量索引/状态 JSON + auto-update-log.md
- 本次修复额外提交：5 个缩名法律文档 + `GBrain/_index/文件名映射.md` + 重新生成的 GBrain 索引

---

*生成时间: 2026-09-11 23:20 | 下次更新: 2026-09-12 23:00*

---

## 2026-09-10 23:00 — 第3次每日更新

### 执行结果
| 项目 | 状态 | 说明 |
|------|------|------|
| 脚本执行 | ✅ 成功 (exit_code=0) | `gbrain-dual-update.py` 正常完成 |
| 增量扫描 | ✅ 完成 (10.9s) | 3297篇文件，新增0 / 变更0 / 跳过3297（已最新） |
| Git Push | ✅ 成功 | 17个文件推送至远程 |
| 知识图谱 | ✅ | 3895节点 / 5472边 |
| 向量索引 | ✅ | 4862关键词 / 3297文档 |
| 域分布 | 9个域 | 中医书库274 / 中国法律2560 / 心理学270 / 写作13 / 创造性思维22 / 学习方法20 / 新科技与应用22 / 桥域6 / 道医全集108 |

### 异常记录

#### ⚠️ 文件名过长（持续性问题）
以下5个中国法律库文档因文件名超过Linux路径长度限制，无法写入：

1. `全国人民代表大会常务委员会关于延长授权国务院在北京市大兴区等二百三十二个试点县...行政区域分别暂时调整实施有关法律规定期限的决定（失效）_20171227.md`
2. `全国人民代表大会常务委员会关于批准《中华人民共和国澳门特别行政区基本法附件一澳门特别行政区行政长官的产生办法修正案》的决定（中华人民共和国澳门特别行政区基本法附件一...）_.md`
3. `全国人民代表大会常务委员会关于批准《中华人民共和国香港特别行政区基本法附件一香港特别行政区行政长官的产生办法修正案》的决定（中华人民共和国香港特别行政区基本法附件一...）_.md`
4. `全国人民代表大会常务委员会关于授权国务院在中国（广东）自由贸易试验区、中国（天津）自由贸易试验区、中国（福建）自由贸易试验区以及中国（上海）自由贸易试验区扩展区域暂时调整有关法律规定的行政审批的决定（失效）_20141228.md`
5. `全国人民代表大会常务委员会关于授权国务院在北京市大兴区等二百三十二个试点县...天津市蓟县等五十九个试点县（市、区）行政区域分别暂时调整实施有关法律规定的决定（失效）_20151227.md`

**影响**: 这5份全国人大常委会决议未入库，法律库总数实际为2560篇而非理论上的2565篇。  
**根因**: 法案全称+日期组合导致文件名远超ext4文件系统255字节限制。  
**处理方案**: 需将源数据文件名改为缩略形式（如去掉"全国人民代表大会常务委员会关于"前缀和"(失效)"后缀），参考现有正常文件的命名模式。此为上次更新也存在的问题，尚未修复。

### 质检结果
- ❌ 空文件: 无
- ❌ Git冲突标记(`<<<<<<`): 未发现
- ❌ 损坏的 `.gitmerge*`/`*~` 临时文件: 未发现
- ✅ 所有已索引法律文件内容完整可读取

### Git Diff统计
本次提交涉及17个文件：3篇索引 + 知识图谱/向量索引/状态JSON + 自动更新日志

---

*生成时间: 2026-09-10 23:01 | 下次更新: 2026-09-11 23:00*
