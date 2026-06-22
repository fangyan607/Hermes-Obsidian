# Day 1：基础自动化（3个实例）

> ⏱ 预计学习时间：8个番茄钟（约3.5小时）
> 🎯 学习目标：搭建3个基础自动化工作流，掌握 Schedule Trigger + HTTP Request + 通知推送
> 🧠 教学方法：费曼学习法 × 刻意练习（每个实例最后有费曼检测）

---

## 今日学习路径

```
🍅 番茄1-2：实例1 · 每日天气播报
🍅 番茄3-4：实例2 · RSS新闻聚合器
🍅 番茄5-6：实例3 · 定时数据备份
🍅 番茄7-8：今日复习 + 费曼综合检测
```

---

## 实例1：每日天气播报

### 🎯 场景与目标

**现实问题**：每天早上出门前需要查看天气，但手动打开 App 太麻烦。如果能每天早上 7:00 自动抓取天气数据，格式化成一段可读的中文消息，推送到钉钉/Slack，就能一起床就看到今天的穿衣指南。

**你将学会**：
- Schedule Trigger 定时触发
- HTTP Request 调用外部 API
- Code 节点格式化数据
- Webhook 推送通知

---

### 🏗️ 工作流架构图

```
┌──────────────────┐     ┌──────────────────┐     ┌──────────────┐     ┌──────────────────┐
│  Schedule Trigger │────▶│  HTTP Request     │────▶│    Code      │────▶│  HTTP Request     │
│   每天 7:00 AM    │     │  OpenWeather API  │     │  格式化消息   │     │  钉钉/Slack推送   │
└──────────────────┘     └──────────────────┘     └──────────────┘     └──────────────────┘
```

---

### 🔑 API/凭证准备

**OpenWeatherMap API Key 获取**：

1. 打开 https://openweathermap.org/api
2. 点击顶部 "Sign Up" 注册账号
3. 注册成功后，进入 https://home.openweathermap.org/api_keys
4. 页面上会显示你的默认 API Key，点击复制
5. **注意**：新 Key 需要等待 10-30 分钟才能生效

| 项目 | 说明 |
|------|------|
| 免费额度 | 1000 次/天 |
| 所需接口 | Current Weather Data |
| 响应速度 | Key 生效后约 10-30 分钟 |

**钉钉机器人 Webhook 获取**（如使用 Slack 可跳过）：

1. 打开钉钉群 → 群设置 → 机器人 → 添加机器人 → 自定义
2. 安全设置选择"加签"，复制 Webhook URL 和加签密钥
3. 保存备用

**Slack Webhook 获取**（如使用钉钉可跳过）：

1. 打开 https://api.slack.com/apps → Create New App
2. 选择 "From scratch"，输入 App Name 和 Workspace
3. 左侧菜单 → Incoming Webhooks → 打开开关 → Add New Webhook to Workspace
4. 选择要发送消息的频道，复制 Webhook URL

---

### 🔧 逐节点配置

#### Node 1：Schedule Trigger

| 字段 | 值 |
|------|-----|
| 节点类型 | Schedule Trigger |
| Trigger Rule | Cron |
| Cron Expression | `0 7 * * *` |
| 时区 | Asia/Shanghai |

> 解释：`0 7 * * *` 表示每天 7:00 AM 触发。n8n 使用服务器时区，如果你的 n8n 部署在 Docker 中，默认时区可能是 UTC，需设置为 `23 * * *`（UTC 23:00 = 北京 7:00），或者在 Docker Compose 中设置环境变量 `TZ=Asia/Shanghai`。

---

#### Node 2：HTTP Request（获取天气）

| 字段 | 值 |
|------|-----|
| 节点类型 | HTTP Request |
| Method | GET |
| URL | `https://api.openweathermap.org/data/2.5/weather` |

**Query Parameters**：

| 参数名 | 值 | 说明 |
|--------|-----|------|
| `q` | `Beijing` | 城市名（可用中文拼音或英文） |
| `appid` | `YOUR_API_KEY` | 替换为你的 OpenWeatherMap Key |
| `units` | `metric` | 摄氏温度（imperial=华氏） |
| `lang` | `zh_cn` | 中文返回 |

**Authentication**：None（Key 在 URL 参数中传递）

> 验证 API 是否生效：在浏览器中打开
> `https://api.openweathermap.org/data/2.5/weather?q=Beijing&appid=YOUR_KEY&units=metric&lang=zh_cn`
> 应返回 JSON 天气数据

---

#### Node 3：Code（格式化消息）

| 字段 | 值 |
|------|-----|
| 节点类型 | Code |
| Language | JavaScript |
| Mode | Run Once for All Items |

**代码**：

```javascript
// 获取上一个节点的天气数据
const weatherData = $input.first().json;

// 提取关键字段
const city = weatherData.name;
const temp = Math.round(weatherData.main.temp);
const feelsLike = Math.round(weatherData.main.feels_like);
const humidity = weatherData.main.humidity;
const pressure = weatherData.main.pressure;
const windSpeed = weatherData.wind.speed;
const description = weatherData.weather[0].description;
const visibility = (weatherData.visibility / 1000).toFixed(1);

// 日出日落时间转换
const sunrise = new Date(weatherData.sys.sunrise * 1000);
const sunset = new Date(weatherData.sys.sunset * 1000);
const formatTime = (date) =>
  `${date.getHours().toString().padStart(2, '0')}:${date.getMinutes().toString().padStart(2, '0')}`;

// 温度对应 emoji 和穿衣建议
let tempEmoji, dressAdvice;
if (temp >= 35) {
  tempEmoji = '🔥';
  dressAdvice = '高温预警，注意防暑，穿轻薄透气衣物';
} else if (temp >= 28) {
  tempEmoji = '☀️';
  dressAdvice = '天气炎热，穿短袖短裤即可';
} else if (temp >= 20) {
  tempEmoji = '🌤️';
  dressAdvice = '温度舒适，薄长袖或短袖+薄外套';
} else if (temp >= 10) {
  tempEmoji = '🌥️';
  dressAdvice = '天气偏凉，建议穿外套或卫衣';
} else if (temp >= 0) {
  tempEmoji = '❄️';
  dressAdvice = '天气寒冷，穿厚外套、围巾保暖';
} else {
  tempEmoji = '🥶';
  dressAdvice = '极寒天气，注意全副保暖！';
}

// 组装消息
const message = `${tempEmoji} ${city}今日天气播报

📅 日期：${new Date().toLocaleDateString('zh-CN', { year: 'numeric', month: 'long', day: 'numeric', weekday: 'long' })}

🌡️ 当前温度：${temp}°C（体感 ${feelsLike}°C）
🌤️ 天气状况：${description}
💧 湿度：${humidity}%
🌬️ 风速：${windSpeed} m/s
👁️ 能见度：${visibility} km
🌅 日出：${formatTime(sunrise)}
🌇 日落：${formatTime(sunset)}

👔 穿衣建议：${dressAdvice}

—— 来自 n8n 自动化播报`;

return [{
  json: {
    message: message,
    city: city,
    temp: temp
  }
}];
```

---

#### Node 4：HTTP Request（钉钉推送）

| 字段 | 值 |
|------|-----|
| 节点类型 | HTTP Request |
| Method | POST |
| URL | `https://oapi.dingtalk.com/robot/send?access_token=YOUR_TOKEN` |
| Authentication | None |

**Body（JSON）**：

| 字段 | 值 |
|------|-----|
| `msgtype` | `"text"` |
| `text.content` | `={{ $json.message }}` |

**Headers**：

| Header | 值 |
|--------|-----|
| `Content-Type` | `application/json` |

**Body 完整表达式**：

```json
{
  "msgtype": "text",
  "text": {
    "content": "{{ $json.message }}"
  }
}
```

---

**如果你使用 Slack 推送**，Node 4 替换为：

| 字段 | 值 |
|------|-----|
| 节点类型 | HTTP Request |
| Method | POST |
| URL | 你的 Slack Webhook URL |
| Authentication | None |

**Body（JSON）**：

```json
{
  "text": "{{ $json.message }}"
}
```

**Headers**：

| Header | 值 |
|--------|-----|
| `Content-Type` | `application/json` |

---

### 🧪 测试验证

**步骤 1：测试 API 连通性**

在工作流编辑器中，点击 HTTP Request（获取天气）节点，然后点击 "Execute Node"。如果配置正确，你应该看到返回的 JSON 数据包含城市名、温度、天气描述等字段。

**步骤 2：测试格式化**

点击 Code 节点 → "Execute Node"，检查输出中 `message` 字段是否为格式化的中文消息。

**步骤 3：测试推送**

点击最后一个 HTTP Request（推送）节点 → "Execute Node"，检查钉钉群/Slack 频道是否收到消息。

**步骤 4：整流测试**

点击工作流顶部的 "Execute Workflow"，确认所有节点依次执行成功。

**预期输出**（钉钉/Slack 收到的消息）：

```
🌤️ Beijing今日天气播报

📅 日期：2026年6月8日星期一

🌡️ 当前温度：28°C（体感 30°C）
🌤️ 天气状况：晴
💧 湿度：45%
🌬️ 风速：3.2 m/s
👁️ 能见度：10.0 km
🌅 日出：04:46
🌇 日落：19:47

👔 穿衣建议：天气炎热，穿短袖短裤即可

—— 来自 n8n 自动化播报
```

**curl 快速验证 API**：

```bash
curl "https://api.openweathermap.org/data/2.5/weather?q=Beijing&appid=YOUR_KEY&units=metric&lang=zh_cn"
```

---

### 💡 变体与扩展

1. **多城市播报**：在 Code 节点中定义城市数组，用 Loop 遍历每个城市，一次推送多城天气
2. **极端天气预警**：在 Code 节点中加判断逻辑，当温度 > 35°C 或 < -10°C 时发送加急通知
3. **天气预报**：改用 OpenWeatherMap 的 `/data/2.5/forecast` 接口，获取未来 5 天预报

---

### ✋ 费曼检测

1. **解释 Schedule Trigger 的 Cron 表达式 `0 7 * * *` 中每个字段的含义。如果要改为每工作日早上 8:00 触发，表达式应该怎么写？**
2. **HTTP Request 节点中，Query Parameter 和 Body 的区别是什么？本例中为什么天气 API 用的是 Query Parameter？**
3. **如果 OpenWeatherMap API 返回的数据结构变了（比如 `weather` 数组变成了对象），Code 节点会发生什么？你会如何防御这种情况？**

---

⏸️ ── 休息 5 分钟 ── ⏸️

---

## 实例2：RSS新闻聚合器

### 🎯 场景与目标

**现实问题**：信息源分散，每天要打开多个网站看新闻。如果能定时抓取 RSS 源，提取最新 5 篇文章，汇总成一条消息推送，就能在一个地方看所有新闻摘要。

**你将学会**：
- HTTP Request 获取 XML 格式的 RSS
- Code 节点解析 XML 数据
- Split Out 拆分数组
- 数据过滤与截取
- 组合多条数据为摘要消息

---

### 🏗️ 工作流架构图

```
┌──────────────────┐     ┌──────────────────┐     ┌──────────────┐     ┌──────────────┐
│  Schedule Trigger │────▶│  HTTP Request     │────▶│    Code      │────▶│  Split Out   │
│   每 4 小时触发    │     │  获取 RSS XML     │     │  解析XML提取  │     │  拆分文章数组  │
└──────────────────┘     └──────────────────┘     └──────────────┘     └──────────────┘
                                                                              │
                                                                              ▼
┌──────────────────┐     ┌──────────────────┐     ┌──────────────┐
│  HTTP Request     │◀────│    Code          │◀────│    Code      │
│  推送摘要通知      │     │  合并为摘要消息   │     │  格式化单篇   │
└──────────────────┘     └──────────────────┘     └──────────────┘
```

---

### 🔑 API/凭证准备

本实例不需要 API Key！RSS 是开放的 XML 格式，直接 HTTP GET 即可。

**推荐 RSS 源**：

| RSS 源 | URL | 说明 |
|--------|-----|------|
| BBC World News | `https://feeds.bbci.co.uk/news/world/rss.xml` | 英文，稳定可靠 |
| 知乎热榜 | `https://www.zhihu.com/rss` | 中文，内容丰富 |
| Hacker News | `https://hnrss.org/frontpage` | 技术圈新闻 |

> 验证 RSS 是否可用：在浏览器中打开上面的 URL，应该能看到 XML 格式的内容。

钉钉/Slack Webhook 准备方式与实例1相同。

---

### 🔧 逐节点配置

#### Node 1：Schedule Trigger

| 字段 | 值 |
|------|-----|
| 节点类型 | Schedule Trigger |
| Trigger Rule | Interval |
| Interval | Every 4 hours |

> 也可以用 Cron 表达式 `0 */4 * * *` 实现同样的效果。

---

#### Node 2：HTTP Request（获取 RSS）

| 字段 | 值 |
|------|-----|
| 节点类型 | HTTP Request |
| Method | GET |
| URL | `https://feeds.bbci.co.uk/news/world/rss.xml` |
| Response Format | String |

> **关键**：Response Format 必须选择 String（而不是 JSON），因为 RSS 返回的是 XML 文本，我们需要在 Code 节点中手动解析。

---

#### Node 3：Code（解析 XML，提取文章）

| 字段 | 值 |
|------|-----|
| 节点类型 | Code |
| Language | JavaScript |
| Mode | Run Once for All Items |

**代码**：

```javascript
// 获取 RSS XML 文本
const xmlText = $input.first().json.data;

// n8n 内置 xml2js 解析器
const xml = require('xml2js');

// 解析 XML
const parser = new xml.Parser({ explicitArray: false });
let result;
parser.parseString(xmlText, (err, parsed) => {
  if (err) throw new Error(`XML 解析失败: ${err.message}`);
  result = parsed;
});

// 提取文章列表
const items = result.rss.channel.item;

// 提取前 5 篇文章的关键字段
const articles = items.slice(0, 5).map((item, index) => {
  return {
    index: index + 1,
    title: item.title || '无标题',
    link: item.link || '',
    description: item.description || '',
    pubDate: item.pubDate || '',
    // 清理 description 中的 HTML 标签
    cleanDescription: (item.description || '')
      .replace(/<[^>]*>/g, '')
      .trim()
      .slice(0, 100) + '...'
  };
});

return articles.map(article => ({ json: article }));
```

> **注意**：n8n 的 Code 节点内置了 `xml2js` 模块，可以直接 `require('xml2js')` 使用。如果你的 n8n 版本不支持，可以使用更简单的方式——用正则表达式提取 `<title>` 和 `<link>` 标签内容。

**正则备选方案**（兼容性更好）：

```javascript
const xmlText = $input.first().json.data;

const titleRegex = /<title><!\[CDATA\[(.*?)\]\]><\/title>|<title>(.*?)<\/title>/g;
const linkRegex = /<link>(.*?)<\/link>/g;
const descRegex = /<description><!\[CDATA\[(.*?)\]\]><\/description>|<description>(.*?)<\/description>/g;

const titles = [...xmlText.matchAll(titleRegex)].map(m => m[1] || m[2]);
const links = [...xmlText.matchAll(linkRegex)].map(m => m[1]);
const descs = [...xmlText.matchAll(descRegex)].map(m => (m[1] || m[2] || '').replace(/<[^>]*>/g, '').trim());

// 跳过第一个（通常是 feed 的标题）
const articles = titles.slice(1, 6).map((title, i) => ({
  json: {
    index: i + 1,
    title: title || '无标题',
    link: links[i + 1] || '',
    description: descs[i] || '',
    cleanDescription: (descs[i] || '').slice(0, 100) + '...'
  }
}));

return articles;
```

---

#### Node 4：Split Out

| 字段 | 值 |
|------|-----|
| 节点类型 | Split Out |
| Field to Split Out | （留空，因为 Code 节点已经拆分为多个 Item） |

> **说明**：如果 Node 3 的 Code 节点返回的是一个包含数组的 JSON 字段（如 `articles`），则 Split Out 需要指定该字段名。但上面的代码已经返回了多个独立 Item，所以可以跳过 Split Out 节点，直接进入下一个 Code 节点。

**简化架构**：如果你用上面的 Code 代码（已拆分为多个 Item），可以省略 Split Out，直接连接下一个节点。

---

#### Node 5：Code（格式化单篇文章）

| 字段 | 值 |
|------|-----|
| 节点类型 | Code |
| Language | JavaScript |
| Mode | Run Once for Each Item |

**代码**：

```javascript
const item = $input.item.json;

const formatted = `📰 ${item.index}. ${item.title}
   🔗 ${item.link}
   📝 ${item.cleanDescription}`;

return {
  json: {
    ...item,
    formatted: formatted
  }
};
```

---

#### Node 6：Code（合并为摘要消息）

| 字段 | 值 |
|------|-----|
| 节点类型 | Code |
| Language | JavaScript |
| Mode | Run Once for All Items |

**代码**：

```javascript
// 收集所有格式化的文章
const articles = $input.all().map(item => item.json.formatted);

// 组装最终消息
const now = new Date();
const timeStr = now.toLocaleString('zh-CN', {
  year: 'numeric',
  month: '2-digit',
  day: '2-digit',
  hour: '2-digit',
  minute: '2-digit',
  timeZone: 'Asia/Shanghai'
});

const message = `📰 RSS 新闻摘要 | ${timeStr}
━━━━━━━━━━━━━━━━

${articles.join('\n\n')}

━━━━━━━━━━━━━━━━
📌 来源：BBC World News
🔄 下次更新：4小时后
—— 来自 n8n 自动化`;

return [{
  json: {
    message: message,
    articleCount: articles.length
  }
}];
```

---

#### Node 7：HTTP Request（推送通知）

配置方式与实例1的 Node 4 完全相同（钉钉或 Slack），只是推送的内容是 `{{ $json.message }}`。

**钉钉推送 Body**：

```json
{
  "msgtype": "text",
  "text": {
    "content": "{{ $json.message }}"
  }
}
```

**Slack 推送 Body**：

```json
{
  "text": "{{ $json.message }}"
}
```

---

### 🧪 测试验证

**步骤 1：验证 RSS 获取**

点击 HTTP Request（获取 RSS）节点 → "Execute Node"，确认返回了 XML 文本。你应该能在输出中看到 `<rss>`、`<channel>`、`<item>` 等 XML 标签。

**步骤 2：验证 XML 解析**

点击 Code（解析 XML）节点 → "Execute Node"，检查是否输出了 5 个 Item，每个包含 `title`、`link`、`description` 字段。

**步骤 3：验证格式化和合并**

依次点击后续 Code 节点，确认消息格式正确。

**步骤 4：验证推送**

执行最后一个 HTTP Request，确认钉钉/Slack 收到摘要消息。

**curl 快速验证 RSS**：

```bash
curl -s "https://feeds.bbci.co.uk/news/world/rss.xml" | head -50
```

**预期输出**（钉钉/Slack 收到的消息）：

```
📰 RSS 新闻摘要 | 2026/06/08 08:00

━━━━━━━━━━━━━━━━

📰 1. Ukraine war: Zelensky calls for more support
   🔗 https://www.bbc.co.uk/news/...
   📝 Ukraine's president has renewed his appeal...

📰 2. US inflation falls to lowest level in three years
   🔗 https://www.bbc.co.uk/news/...
   📝 Consumer prices in the US rose at a slower...

📰 3. Climate summit opens with bold pledges
   🔗 https://www.bbc.co.uk/news/...
   📝 World leaders gathered for the climate...

📰 4. Tech giant announces major layoffs
   🔗 https://www.bbc.co.uk/news/...
   📝 The company said it would cut 10,000 jobs...

📰 5. New study reveals benefits of meditation
   🔗 https://www.bbc.co.uk/news/...
   📝 Researchers found that regular meditation...

━━━━━━━━━━━━━━━━
📌 来源：BBC World News
🔄 下次更新：4小时后
—— 来自 n8n 自动化
```

---

### 💡 变体与扩展

1. **多源聚合**：添加多个 HTTP Request 节点分别获取不同 RSS 源，在 Code 节点中合并去重，实现「多源新闻摘要」
2. **关键词过滤**：在格式化 Code 节点中加关键词匹配，只推送包含特定关键词（如 "AI"、"科技"）的新闻
3. **AI 摘要增强**：在提取文章后加一个 OpenAI 节点，让 AI 对每篇文章生成一句话中文摘要

---

### ✋ 费曼检测

1. **RSS 返回的是 XML 而不是 JSON，为什么 HTTP Request 的 Response Format 必须设为 String？如果设为 JSON 会发生什么？**
2. **解释 Split Out 节点的作用。本例中为什么可以省略它？（提示：跟 Code 节点的返回格式有关）**
3. **如果 RSS 源临时不可用（HTTP 请求返回 500 错误），工作流会怎样？你会如何增加容错机制？**

---

⏸️ ── 休息 5 分钟 ── ⏸️

---

## 实例3：定时数据备份

### 🎯 场景与目标

**现实问题**：很多 SaaS 服务的数据只保存在云端，没有本地备份。如果服务宕机或账号出问题，数据就丢了。如果每天凌晨 2:00 自动拉取数据、加上时间戳和元信息、保存到本地文件，就拥有了离线数据副本。

**你将学会**：
- HTTP Request 获取 JSON API 数据
- Code 节点添加备份元信息
- 文件写入（Write Binary File）
- 时间戳命名规范

---

### 🏗️ 工作流架构图

```
┌──────────────────┐     ┌──────────────────┐     ┌──────────────┐     ┌──────────────────┐
│  Schedule Trigger │────▶│  HTTP Request     │────▶│    Code      │────▶│  Write Binary     │
│   每天 2:00 AM    │     │  获取 API 数据    │     │  添加元信息   │     │  写入备份文件     │
└──────────────────┘     └──────────────────┘     └──────────────┘     └──────────────────┘
```

---

### 🔑 API/凭证准备

本实例使用 JSONPlaceholder（免费假数据 API）作为演示数据源，不需要 API Key。

| 项目 | 说明 |
|------|------|
| 数据源 | https://jsonplaceholder.typicode.com/users |
| 认证 | 无需 |
| 返回格式 | JSON 数组 |

> 在实际使用中，你可以将 URL 替换为任何需要备份的 API 端点（如 Notion API、Airtable API 等）。

---

### 🔧 逐节点配置

#### Node 1：Schedule Trigger

| 字段 | 值 |
|------|-----|
| 节点类型 | Schedule Trigger |
| Trigger Rule | Cron |
| Cron Expression | `0 2 * * *` |
| 时区 | Asia/Shanghai（或在 Docker 中设置 TZ） |

---

#### Node 2：HTTP Request（获取数据）

| 字段 | 值 |
|------|-----|
| 节点类型 | HTTP Request |
| Method | GET |
| URL | `https://jsonplaceholder.typicode.com/users` |
| Response Format | JSON |
| Authentication | None |

> 如果你备份的是需要认证的 API（如 Notion），在 Authentication 中选择 Header Auth，添加 `Authorization: Bearer YOUR_TOKEN` 和 `Notion-Version: 2022-06-28`。

---

#### Node 3：Code（添加元信息 + 生成文件）

| 字段 | 值 |
|------|-----|
| 节点类型 | Code |
| Language | JavaScript |
| Mode | Run Once for All Items |

**代码**：

```javascript
// 获取原始数据
const rawData = $input.first().json;

// 生成时间戳
const now = new Date();
const timestamp = now.toISOString();                        // 2026-06-08T02:00:00.000Z
const fileTimestamp = now.toISOString().replace(/[:.]/g, '-'); // 2026-06-08T02-00-00-000Z

// 构建备份数据结构
const backupData = {
  _metadata: {
    backupTime: timestamp,
    source: 'https://jsonplaceholder.typicode.com/users',
    sourceType: 'REST API',
    recordCount: Array.isArray(rawData) ? rawData.length : 1,
    format: 'json',
    n8nWorkflow: '定时数据备份',
    version: '1.0'
  },
  data: rawData
};

// 将 JSON 转为字符串
const jsonStr = JSON.stringify(backupData, null, 2);

// 生成文件名
const fileName = `backup_users_${fileTimestamp}.json`;

// n8n Write Binary File 需要 Buffer
const buffer = Buffer.from(jsonStr, 'utf-8');

return [{
  json: {
    fileName: fileName,
    metadata: backupData._metadata
  },
  binary: {
    data: await this.helpers.prepareBinaryData(buffer, fileName, 'application/json')
  }
}];
```

> **关键概念**：n8n 中文件操作需要 `binary` 字段。`this.helpers.prepareBinaryData()` 将 Buffer 转换为 n8n 能识别的二进制格式。Code 节点中必须使用 `await`，因为 `prepareBinaryData` 是异步方法。

---

#### Node 4：Write Binary File（写入文件）

| 字段 | 值 |
|------|-----|
| 节点类型 | Write Binary File |
| File Name | `/backups/{{ $json.fileName }}` |
| Binary Property | `data` |

> **路径说明**：
> - 如果 n8n 运行在 Docker 中，路径是容器内路径
> - 建议在 Docker Compose 中挂载卷：`-v ./n8n-backups:/backups`
> - 这样备份文件会保存到宿主机的 `./n8n-backups/` 目录

**Docker Compose 卷挂载示例**：

```yaml
services:
  n8n:
    image: n8nio/n8n
    volumes:
      - n8n_data:/home/node/.n8n
      - ./n8n-backups:/backups  # 挂载备份目录
```

---

**备选方案：使用 HTTP Request 写入文件**

如果 Write Binary File 节点不可用（某些 n8n 版本），可以用 Code 节点直接写入：

```javascript
const fs = require('fs');
const path = require('path');

const jsonStr = $input.first().json.jsonStr;
const fileName = $input.first().json.fileName;

const backupDir = '/backups';
const filePath = path.join(backupDir, fileName);

// 确保目录存在
if (!fs.existsSync(backupDir)) {
  fs.mkdirSync(backupDir, { recursive: true });
}

fs.writeFileSync(filePath, jsonStr, 'utf-8');

return [{
  json: {
    success: true,
    filePath: filePath,
    fileSize: fs.statSync(filePath).size
  }
}];
```

---

### 🧪 测试验证

**步骤 1：验证数据获取**

点击 HTTP Request 节点 → "Execute Node"，确认返回 JSON 数组（10 个用户对象）。

**步骤 2：验证元信息添加**

点击 Code 节点 → "Execute Node"，检查输出中：
- `fileName` 是否为 `backup_users_2026-06-08T02-00-00-000Z.json` 格式
- `metadata.recordCount` 是否为 10
- `binary` 字段是否包含文件数据

**步骤 3：验证文件写入**

点击 Write Binary File 节点 → "Execute Node"，检查：
- 输出中 `fileName` 路径是否正确
- 宿主机备份目录中是否生成了对应文件
- 打开 JSON 文件，检查 `_metadata` 和 `data` 字段是否完整

**步骤 4：整流测试**

点击 "Execute Workflow"，确认从触发到文件写入全流程通过。

**curl 快速验证 API**：

```bash
curl -s "https://jsonplaceholder.typicode.com/users" | python -m json.tool | head -20
```

**预期备份文件内容**：

```json
{
  "_metadata": {
    "backupTime": "2026-06-08T02:00:00.000Z",
    "source": "https://jsonplaceholder.typicode.com/users",
    "sourceType": "REST API",
    "recordCount": 10,
    "format": "json",
    "n8nWorkflow": "定时数据备份",
    "version": "1.0"
  },
  "data": [
    {
      "id": 1,
      "name": "Leanne Graham",
      "username": "Bret",
      ...
    },
    ...
  ]
}
```

---

### 💡 变体与扩展

1. **多数据源备份**：添加多个 HTTP Request 节点，分别拉取不同 API，在 Code 节点中合并为一个备份文件，或分别保存
2. **备份到云存储**：将 Write Binary File 替换为 S3 节点或 Google Drive 节点，实现云端备份
3. **备份校验**：在写入后加一个 Code 节点，重新读取文件并与原始数据比对 MD5，确保写入完整

---

### ✋ 费曼检测

1. **备份数据中的 `_metadata` 字段有什么作用？如果只保存原始数据不加元信息，恢复时会遇到什么问题？**
2. **解释 `this.helpers.prepareBinaryData()` 的作用。为什么不能直接把 JSON 字符串传给 Write Binary File 节点？**
3. **如果备份文件越来越大（比如从 1MB 增长到 500MB），你会如何优化这个工作流？（提示：增量备份、压缩、分片）**

---

⏸️ ── 休息 5 分钟 ── ⏸️

---

## 🍅 番茄7：今日复习

### 三个工作流对比总结

| 维度 | 实例1：天气播报 | 实例2：RSS聚合 | 实例3：数据备份 |
|------|----------------|---------------|----------------|
| **触发方式** | Cron（每天7:00） | Interval（每4小时） | Cron（每天2:00） |
| **数据获取** | HTTP GET（天气API） | HTTP GET（RSS XML） | HTTP GET（JSON API） |
| **数据处理** | Code（格式化） | Code（解析XML+格式化） | Code（添加元信息） |
| **数据输出** | HTTP POST（推送通知） | HTTP POST（推送通知） | Write Binary File（保存文件） |
| **数据格式** | JSON → 文本 | XML → JSON → 文本 | JSON → JSON文件 |
| **节点数量** | 4 | 5-7 | 4 |
| **核心技能** | API调用+消息格式化 | XML解析+数据拆分合并 | 二进制文件操作 |

### 触发器类型对比

| 触发器类型 | 使用场景 | Cron 表达式示例 |
|-----------|---------|----------------|
| **Schedule - Cron** | 精确时间点触发 | `0 7 * * *`（每天7:00） |
| **Schedule - Interval** | 固定间隔循环 | Every 4 hours |
| **Webhook** | 外部事件触发（Day5学习） | — |
| **Manual** | 手动测试 | — |

### 关键表达式速查

| 表达式 | 含义 | 示例 |
|--------|------|------|
| `{{ $json.field }}` | 当前节点的字段 | `{{ $json.message }}` |
| `{{ $input.first().json }}` | 上一个节点的第一个 Item | `{{ $input.first().json.data }}` |
| `{{ $input.all() }}` | 上一个节点的所有 Items | 在合并 Code 中使用 |
| `{{ $input.item.json }}` | 当前 Item（Each Item 模式） | 在逐项格式化中使用 |
| `{{ $now }}` | 当前时间 | `{{ $now.toISO() }}` |

---

### 刻意练习——基础自动化全流程

**练习目标**：在 20 分钟内不借助教程，独立完成一个完整的基础自动化工作流（触发器→数据获取→处理→输出）

**任务序列（重复×3）：**

```
===== 循环 1：触发器变换 =====
将每日天气播报的 Schedule Trigger 改为 Manual Trigger，再改为 Webhook Trigger
验证：三种触发器都能正确启动工作流，输出结果一致

===== 循环 2：数据流扩展 =====
在天气播报的 HTTP Request 与 Code 之间依次插入：
1. Set 节点添加城市字段
2. IF 节点判断温度是否超过阈值
3. Code 节点添加 emoji 标记
验证：每次插入后工作流仍能正确输出

===== 循环 3：从零构建 =====
在空白画布上构建一个完整工作流：Webhook → HTTP Request（任意公开 API）→ Code（数据处理）→ HTTP Request（输出到 Webhook 响应）
验证：curl 测试返回了正确的处理结果
```

**刻意练习自检清单：**

| 技能 | 1次 | 2次 | 3次 |
|:-----|:---:|:---:|:---:|
| 触发器配置与切换 | ⬜ | ⬜ | ⬜ |
| HTTP Request API 调用 | ⬜ | ⬜ | ⬜ |
| Code 节点数据处理 | ⬜ | ⬜ | ⬜ |
| 完整流程 Debug | ⬜ | ⬜ | ⬜ |

> ✋ **费曼自测**：如果你要给一个完全没接触过 n8n 的朋友讲解"自动化工作流"是什么，你会用什么比喻来解释？这个比喻能覆盖"触发→处理→输出"三个步骤吗？

---

## 🍅 番茄8：费曼综合检测 + 输出成果

### 工作流自检清单

完成以下清单，确认 3 个工作流都能正常运行：

- [ ] **实例1：每日天气播报**
  - [ ] Schedule Trigger 配置正确，触发时间无误
  - [ ] HTTP Request 成功返回天气数据（状态码 200）
  - [ ] Code 节点输出的 message 格式正确、包含中文
  - [ ] 钉钉/Slack 成功收到推送消息
  - [ ] 整流执行成功，无报错

- [ ] **实例2：RSS新闻聚合器**
  - [ ] Schedule Trigger 间隔设置为 4 小时
  - [ ] HTTP Request 成功获取 RSS XML 文本
  - [ ] Code 节点成功解析 XML，提取 5 篇文章
  - [ ] 合并后的消息格式正确
  - [ ] 钉钉/Slack 成功收到摘要推送
  - [ ] 整流执行成功，无报错

- [ ] **实例3：定时数据备份**
  - [ ] Schedule Trigger 配置为凌晨 2:00
  - [ ] HTTP Request 成功获取 API 数据
  - [ ] Code 节点正确添加 `_metadata` 元信息
  - [ ] Write Binary File 成功写入文件
  - [ ] 备份文件可打开，内容完整
  - [ ] 整流执行成功，无报错

---

### 费曼一句话总结

> **用一句话解释今天学到的核心**：
>
> n8n 基础自动化的模式 = **定时触发 → 拉取数据 → 处理转换 → 输出结果**，无论天气、新闻还是备份，都是这个模式的不同变体。

---

### 学习笔记模板

```markdown
## Day 1 学习笔记

### 今日收获
1.
2.
3.

### 遇到的问题
1. 问题描述：______ → 解决方式：______
2. 问题描述：______ → 解决方式：______

### 个人改造
- 我把实例 ___ 改造成了 ______
- 新增了 ______ 功能

### 明日期待
- Day 2 数据处理管道，学习 ______
```

---

## 🎉 Day 1 完成!

今天你搭建了 3 个完整的基础自动化工作流：
1. ☀️ 每日天气播报 — 掌握了定时触发 + API调用 + 消息推送
2. 📰 RSS新闻聚合器 — 掌握了XML解析 + 数据拆分合并
3. 💾 定时数据备份 — 掌握了数据元信息 + 文件写入

明天进入 **数据处理管道**，学习数据清洗、格式转换、批量文件处理！

→ **继续学习 [[实例Day2-数据处理管道]]**

---

> **相关文件：**
> - [[实例训练-README]] - 实例训练总览
> - [[Day1-安装部署与界面初探]] - 理论 Day 1（安装部署）
> - [[实例Day2-数据处理管道]] - 下一天实例
