# 安装文档索引

这个目录放安装、更新、卸载和自定义接入说明。

普通用户的路径很短：

1. 打开 [`one-click-install-release-copy.md`](./one-click-install-release-copy.md)。
2. 选择宿主、动作和版本。
3. 复制一段提示词到你要安装 VibeSkills 的 AI 客户端里。

## 前置条件

- Python 3.10+
- PowerShell 7（`pwsh`），用于完整 governed verification
- 能访问这个 GitHub 仓库

Linux 和 macOS 仍然可以使用 `bash` 安装脚本。推荐安装 PowerShell 7，是因为部分 governed verification gate 会使用 PowerShell 命令面。

## 主要页面

| 需求 | 阅读 |
|:---|:---|
| 公开安装/更新入口 | [`one-click-install-release-copy.md`](./one-click-install-release-copy.md) |
| 直接命令参考 | [`recommended-full-path.md`](./recommended-full-path.md) |
| 宿主根目录选择 | [`../cold-start-install-paths.md`](../cold-start-install-paths.md) |
| 离线/手动安装 | [`manual-copy-install.md`](./manual-copy-install.md) |
| OpenClaw 细节 | [`openclaw-path.md`](./openclaw-path.md) |
| OpenCode 细节 | [`opencode-path.md`](./opencode-path.md) |
| 安装后配置 | [`configuration-guide.md`](./configuration-guide.md) |
| 自定义 Skill 接入 | [`custom-workflow-onboarding.md`](./custom-workflow-onboarding.md) |

维护者/参考页：

- [`installation-rules.md`](./installation-rules.md)：安装助手必须遵守的 truth-first 规则
- [`host-plugin-policy.md`](./host-plugin-policy.md)：宿主和插件边界说明
- [`../one-shot-setup.md`](../one-shot-setup.md)：one-shot setup 行为与 MCP 报告契约

## 提示词库

公开提示词故意保持很少：

- [`prompts/full-version-install.md`](./prompts/full-version-install.md)
- [`prompts/framework-only-install.md`](./prompts/framework-only-install.md)
- [`prompts/full-version-update.md`](./prompts/full-version-update.md)
- [`prompts/framework-only-update.md`](./prompts/framework-only-update.md)

这个目录里的其他页面是参考说明、兼容说明或宿主补充说明，不再作为平行公开入口。

## 公开版本

| 对外说法 | 运行时 profile |
|:---|:---|
| `全量版本 + 可自定义添加治理` | `full` |
| `仅核心框架 + 可自定义添加治理` | `minimal` |

普通用户用 `full`。只有你明确想先装较小的治理框架时，再用 `minimal`。

## 公开宿主

当前公开 host id：

- `codex`
- `claude-code`
- `cursor`
- `windsurf`
- `openclaw`
- `opencode`

这些宿主的安装模式并不完全一样。`codex` 和 `claude-code` 是最清晰的安装与使用路径；`cursor`、`windsurf`、`openclaw`、`opencode` 仍带宿主差异或 preview 边界。安装报告里要如实写清楚。

## 安装报告的 truth model

不要把安装状态压成一句模糊的“成功”。需要分开报告：

- `installed locally`
- `vibe host-ready`
- `mcp native auto-provision attempted`
- 每个 MCP 的 `host-visible readiness`
- `online-ready`

`$vibe` 或 `/vibe` 只证明 governed runtime 入口可用。它不等于 MCP 完成，也不能证明 provider、凭证、插件或宿主原生 MCP 面都已经配置好。

## 卸载

使用仓库根目录下的卸载入口：

- Windows：`uninstall.ps1 -HostId <host>`
- Linux / macOS：`uninstall.sh --host <host>`

完整的“只清理 Vibe 自己管理内容”契约见 [`../uninstall-governance.md`](../uninstall-governance.md)。
