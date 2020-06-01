#!/bin/sh
# Copyright 2019-2020 the Deno authors. All rights reserved. MIT license.
# TODO(everyone): Keep this script simple and easily auditable.

set -e

case $(uname -s) in
Darwin) target="x86_64-apple-darwin" ;;
*) target="x86_64-unknown-linux-gnu" ;;
esac

if [ $(uname -m) != "x86_64" ]; then
	echo "Unsupported architecture $(uname -m). Only x64 binaries are available."
	exit
fi

deno_version=$1

if [ $# -eq 0 ]; then
	deno_version=$(
		command curl -sSf https://x.deno.js.cn/versions.txt |
			command head -n 1
	)
fi

deno_uri="https://deno.devtips.cn/releases/download/${deno_version}/deno-${target}.zip"

echo $deno_uri

deno_install="${DENO_INSTALL:-$HOME/.deno}"
bin_dir="$deno_install/bin"
exe="$bin_dir/deno"

if [ ! -d "$bin_dir" ]; then
	mkdir -p "$bin_dir"
fi

curl --fail --location --progress-bar --output "$exe.zip" "$deno_uri"
cd "$bin_dir"
unzip -o "$exe.zip"
chmod +x "$exe"
rm "$exe.zip"

echo "Deno 已经成功安装"
echo "可执行文件位置为 $exe"

if command -v deno >/dev/null; then
	echo "运行 'deno --help' 查看 Deno 帮助信息"
else
	echo "您需要手动将 Deno 目录添加到 \$HOME/.bash_profile (或者其它类似目录)"
	echo "  export DENO_INSTALL=\"$deno_install\""
	echo "  export PATH=\"\$DENO_INSTALL/bin:\$PATH\""
	echo "运行 '$exe --help' 查看 Deno 帮助信息"
fi
