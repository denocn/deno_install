# deno_install

**通过单行命令将 Deno 安装到系统中**

[![Build Status](https://github.com/denocn/deno_install/workflows/ci/badge.svg?branch=master)](https://github.com/denocn/deno_install/actions)

## 安装最新版

**使用 Shell:**

```sh
curl -fsSL https://x.deno.js.cn/install.sh | sh
```

**使用 PowerShell:**

```powershell
iwr https:/x.deno.js.cn/install.ps1 -useb | iex
```

## 安装某个特定版本

**使用 Shell:**

```sh
curl -fsSL https://x.deno.js.cn/install.sh | sh -s v0.41.0
```

**使用 PowerShell:**

```powershell
iwr https://x.deno.js.cn/install.ps1 -useb -outf install.ps1; .\install.ps1 v0.41.0
```

## Install via Package Manager

**With [Scoop](https://scoop.sh):**

```powershell
scoop install deno
```

**With [Homebrew](https://formulae.brew.sh/formula/deno):**

```sh
brew install deno
```

**With [Chocolatey](https://chocolatey.org/packages/deno):**

```powershell
choco install deno
```

## Install and Manage Multiple Versions

**With [asdf](https://asdf-vm.com) and [asdf-deno](https://github.com/asdf-community/asdf-deno):**

```sh
asdf plugin-add deno https://github.com/asdf-community/asdf-deno.git

asdf install deno 0.38.0

# Activate globally with:
asdf global deno 0.38.0

# Activate locally in the current folder with:
asdf local deno 0.38.0
```

**With [Scoop](https://github.com/lukesampson/scoop/wiki/Switching-Ruby-And-Python-Versions):**

```sh
# Install a specific version of deno:
scoop install deno@0.22.0

# Switch to v0.22.0
scoop reset deno@0.22.0

# Switch to the latest version
scoop reset deno
```

## Environment Variables

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

## Compatibility

- The Shell installer can be used on Windows via the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about).

## Known Issues

### Running scripts is disabled

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
