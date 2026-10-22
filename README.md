# 《大语言模型与科研智能体：农业与生命科学研究实践指南》配套仓库

本仓库存放教材的配套材料，供读者下载使用：

| 路径 | 内容 | 对应章节 |
|---|---|---|
| `selfcheck.sh` | 环境自检脚本（macOS/Linux） | 附录 A.6 |
| `selfcheck.ps1` | 环境自检脚本（Windows PowerShell） | 附录 A.6 |
| `data/rice_traits.csv` | 案例 A：水稻品种 × 施氮梯度田间试验表型数据（教学模拟） | 全书多数章节 |
| `data/mini_rnaseq_counts.csv` | 案例 B：1500 个基因 × 6 个样本的原始计数（教学模拟） | 第 1、4、5、7–11、16 章 |
| `data/rnaseq_design.csv` | 案例 B：样本分组设计表 | 第 1、4、5、7–11、16 章 |
| `data/de_genes_truth.csv` | 案例 B：模拟时植入的 80 个真实差异基因（基准真值，供完成练习后对照） | 第 10、11 章 |
| `UPDATES.md` | 在线更新页：各节步骤的最新核验结果与官方入口地址 | 附录 A.1 |
| `workshops/vetmed-2026/` | 动物医学院研究生工作坊的上机数据包：猪源大肠杆菌药敏（A）、PRRSV 感染巨噬细胞转录组（B），教学模拟 | 教材之外的工作坊 |

两套数据均为教学模拟数据，由固定随机种子（42）生成，不含真实个人或未公开科研数据，可用于云端模型练习（第 9 章 §9.1）。

建议先独立完成第 10、11 章的分析，再打开 `de_genes_truth.csv` 对照；先看答案会失去已知答案测试的意义（第 4 章 §4.10）。

## 使用方式

1. 点击页面右上角 **Code → Download ZIP**，解压到一个英文、无空格的文件夹（附录 B.2）。
2. 按附录 A.6 运行自检脚本：
   - macOS/Linux：`bash selfcheck.sh`
   - Windows：`powershell -ExecutionPolicy Bypass -File .\selfcheck.ps1`
3. 教材正文与本仓库内容不一致时，以 `UPDATES.md` 为准。

## 反馈

勘误、步骤失效、工具版本变化，请在 [Issues](https://github.com/hnnd/AI4S/issues) 提交。求助时请附上操作系统与版本、完整命令、完整报错原文（附录 B 末尾）。
