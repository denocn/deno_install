# deno_install [![Build Status](https://github.com/denocn/deno_install/workflows/ci/badge.svg?branch=master)](https://github.com/denocn/deno_install/actions)

> **通过单行命令将 Deno 安装到系统中（国内加速）**

- Deno 官方最新版本 [![](https://img.shields.io/github/release/denoland/deno)](https://github.com/denoland/deno/releases)
- Deno 镜像最新版本 ![](https://img.shields.io/badge/release-v1.4.3-blue.svg)

国内加速镜像使用的七牛云 CDN，每天的下载量为 3GB+(六月份)。如果这个下载镜像帮助到了你，可以通过下面二维码进行捐赠：

<p align="center"><img src="https://cdn.devtips.cn/buy-me-a-coffee-wechat.png" width="200" height="200" alt="" /></p>

## 安装最新版

**使用 Shell:**

```sh
curl -fsSL https://x.deno.js.cn/install.sh | sh
```

**使用 PowerShell:**

```powershell
iwr https://x.deno.js.cn/install.ps1 -useb | iex
```

## 安装某个特定版本

**使用 Shell:**

```sh
curl -fsSL https://x.deno.js.cn/install.sh | sh -s v1.0.0
```

**使用 PowerShell:**

```powershell
$v="1.0.0"; iwr https://x.deno.js.cn/install.ps1 -useb | iex
```

## 使用包管理器

**使用 [Scoop](https://github.com/ScoopInstaller/Main/blob/master/bucket/deno.json):**

```powershell
scoop install deno
```

**使用 [Homebrew](https://formulae.brew.sh/formula/deno):**

```sh
brew install deno
```

**使用 [Chocolatey](https://chocolatey.org/packages/deno):**

```powershell
choco install deno
```

## 使用多版本管理工具

**使用 Yay (AUR) ([deno](https://aur.archlinux.org/packages/deno) 和 [deno-bin](https://aur.archlinux.org/packages/deno-bin)):**

```sh
# From source
yay -S deno
# Pre-compiled
yay -S deno-bin
```

**使用 [asdf](https://asdf-vm.com) 和 [asdf-deno](https://github.com/asdf-community/asdf-deno):**

```sh
asdf plugin-add deno https://github.com/asdf-community/asdf-deno.git

asdf install deno 1.0.0

# Activate globally with:
asdf global deno 1.0.0

# Activate locally in the current folder with:
asdf local deno 1.0.0
```

**使用 [Scoop](https://github.com/lukesampson/scoop/wiki/Switching-Ruby-And-Python-Versions):**

```sh
# 安装某个特定版本的 Deno：
scoop install deno@1.0.0

# 切换到 v1.0.0
scoop reset deno@1.0.0

#切换到最新版
scoop reset deno
```

## 环境变量

- `DENO_INSTALL` - Deno 的安装目录。默认为 `$HOME/.deno`。Deno 可执行文件将安装在 `$DENO_INSTALL/bin` 目录。
  安装成功后将对所有用户有效：

  **使用 Shell (`/usr/local`):**

  ```sh
  curl -fsSL https://x.deno.js.cn/install.sh | sudo DENO_INSTALL=/usr/local sh
  ```

  **使用 PowerShell (`C:\Program Files\deno`):**

  ```powershell
  # 使用管理员模式运行：
  $env:DENO_INSTALL = "C:\Program Files\deno"
  iwr https://x.deno.js.cn/install.ps1 -useb | iex
  ```

## 兼容性

- 此安装脚本可以运行在 [WSL（适用于 Linux 的 Windows 子系统）](https://docs.microsoft.com/zh-cn/windows/wsl/about)。

## 已知问题

### 禁止运行脚本

```
PS C:\> iwr https://x.deno.js.cn/install.ps1 -useb -outf install.ps1; .\install.ps1 v0.41.0
.\install.ps1 : 无法加载文件 C:\Users\justjavac\install.ps1，因为在此系统上禁止运行脚本。有关详细信息，请参阅 https:/go.microsoft.com/fwlink/?LinkID=135170 中的 about_Execution_Policies。
所在位置 行:1 字符: 63
+ ... deno.js.cn/install.ps1 -useb -outf install.ps1; .\install.ps1 v0.41.0
+                                                     ~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) []，PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess
```

**什么情况下会出现这个错误？**

当您的系统的 [ExecutionPolicy](https://docs.microsoft.com/zh-cn/powershell/module/microsoft.powershell.core/about/about_execution_policies) 为 `Undefined` 或 `Restricted` 时。

**如何修复这个错误？**

允许系统运行从网络上下载的脚本文件，将执行策略设置为 `RemoteSigned`：

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
```

### unzip is required

Shell 安装脚本需要 [`unzip`](https://linux.die.net/man/1/unzip) 软件。

**什么情况下会出现这个错误？**

```sh
$ curl -fsSL https://deno.land/x/install/install.sh | sh
Error: unzip is required to install Deno (see: https://deno.js.cn/t/topic/167).
```

当运行 `install.sh` 时，`unzip` 用来解压 Deno 的二进制 zip 包。

**如何修复这个错误？**

你可以通过在 macOS 上运行 `brew install unzip` 或者 Linux 上运行 `apt-get install unzip -y` 来安装 `unzip` 程序。
