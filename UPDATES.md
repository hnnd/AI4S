# 在线更新页

本页登记教材各节步骤的最新核验结果与官方入口地址。教材正文（含"时效框"）与本页不一致时，以本页为准。

## 2026-10（第二版定稿核验）

| 项目 | 核验结果 | 官方入口 | 教材位置 |
|---|---|---|---|
| Node.js | 安装 LTS 版，`node -v` 主版本号 ≥ 18 | https://nodejs.org | 附录 A.2 |
| Python | 从官方下载页获取，Windows 不使用 Microsoft Store 版本 | https://www.python.org/downloads/ | 附录 A.2 |
| opencode | npm 包 `@opencode/cli`，2.x（2026-10-03 npm 最新 2.0.22）；旧版 `opencode-ai` 1.x 不再推荐 | https://opencode.ai | 附录 A.2、A.4 |
| DeepSeek API | 调用名 `deepseek-flash`（V4.1 Flash），以平台当日模型列表为准 | https://platform.deepseek.com | 附录 A.4、第 6 章 |
| Open Science Desktop | v0.5.2（2026-09-08 发布），无应用内自动更新 | https://github.com/ai4s-research/open-science/releases | 附录 A.5 |

### 已知行为（opencode 2.0.19 实测）

- 未登记凭据时：不指定模型或由项目 `opencode.json` 指定模型，会静默改用内置免费模型并正常回复；用 `-m deepseek/deepseek-flash` 显式指定时报 `Model unavailable`。核对时看回复首行模型名（附录 A.4 第二步）。
- 环境变量 `DEEPSEEK_API_KEY` 也会被当作凭据读取；残留旧 key 会导致 401（附录 B.5）。

## 待核实

- Windows/PowerShell 实机：附录 A 安装步骤、`selfcheck.ps1`、第 6 章 §6.4 检索命令。
- 第 2 章 §2.5 种子管理平台（seed.moa.gov.cn）检索框名称与通过标准（需国内网络）。
