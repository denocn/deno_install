# deno_install

>> **通过单行命令将 Deno 安装到系统中（国内加速）**

[![Build Status](https://github.com/denocn/deno_install/workflows/ci/badge.svg?branch=master)](https://github.com/denocn/deno_install/actions)

## 1. 安装最新版

**1.1 使用 Shell:**

```sh
curl -fsSL https://x.deno.js.cn/install.sh | sh
```

**1.2 使用 PowerShell:**

```powershell
iwr https:/x.deno.js.cn/install.ps1 -useb | iex
```

## 2. 安装某个特定版本

**2.1 使用 Shell:**

```sh
curl -fsSL https://x.deno.js.cn/install.sh | sh -s v0.41.0
```

**2.2 使用 PowerShell:**

```powershell
iwr https://x.deno.js.cn/install.ps1 -useb -outf install.ps1; .\install.ps1 v0.41.0
```

## 3. 使用包管理器

**3.1 使用 [Scoop](https://scoop.sh):**

```powershell
scoop install deno
```

**3.2 使用 [Homebrew](https://formulae.brew.sh/formula/deno):**

```sh
brew install deno
```

**3.3 使用 [Chocolatey](https://chocolatey.org/packages/deno):**

```powershell
choco install deno
```

## 4. 使用多版本管理工具

**4.1 使用 [asdf](https://asdf-vm.com) 和 [asdf-deno](https://github.com/asdf-community/asdf-deno):**

```sh
asdf plugin-add deno https://github.com/asdf-community/asdf-deno.git

asdf install deno 0.38.0

# Activate globally with:
asdf global deno 0.38.0

# Activate locally in the current folder with:
asdf local deno 0.38.0
```

**4.2 使用 [Scoop](https://github.com/lukesampson/scoop/wiki/Switching-Ruby-And-Python-Versions):**

```sh
# 安装某个特定版本的 Deno：
scoop install deno@0.22.0

# 切换到 v0.22.0
scoop reset deno@0.22.0

#切换到最新版
scoop reset deno
```

## 5. 环境变量

- `DENO_INSTALL` - The directory in which to install Deno. This defaults to
  `$HOME/.deno`. The executable is placed in `$DENO_INSTALL/bin`. One
  application of this is a system-wide installation:

  **With Shell (`/usr/local`):**

  ```sh
  curl -fsSL https://deno.land/x/install/install.sh | sudo DENO_INSTALL=/usr/local sh
  ```

  **With PowerShell (`C:\Program Files\deno`):**

  ```powershell
  # Run as administrator:
  $env:DENO_INSTALL = "C:\Program Files\deno"
  iwr https://deno.land/x/install/install.ps1 -useb | iex
  ```

## 6. 兼容性

- The Shell installer can be used on Windows via the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about).

## 7. Known Issues

### 7.1 Running scripts is disabled

```
PS C:\> iwr https://deno.land/x/install/install.ps1 -useb -outf install.ps1; .\install.ps1 v0.38.0
.\install.ps1 : File C:\install.ps1 cannot be loaded because running scripts is disabled on this system. For more information, see about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.
At line:1 char:71
+ ... /x/install/install.ps1 -useb -outf install.ps1; .\install.ps1 v0.38.0
+                                                     ~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) [], ParentContainsErrorRecordException
    + FullyQualifiedErrorId : UnauthorizedAccess
```

**When does this issue occur?**

If your systems' [ExecutionPolicy](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies) is `Undefined` or `Restricted`.

**How can this issue be fixed?**

Allow scripts that are downloaded from the internet to be executed by setting the execution policy to `RemoteSigned`:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
```
