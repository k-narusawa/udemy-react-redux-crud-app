#!/bin/sh
#============================================================
# ファイルにCopyright文言を挿入する。
#
# 対象拡張子を変更する際は .vscode/settings.json の emeraldwalk.runonsave
# も編集して下さい。
#============================================================
extension="$1"
filePath="$2"

ALL_RIGHTS_RESERVED="All Rights Reserved"
COPYRIGHT="Copyright (c) `date +'%Y'`. teamLab Engineering. ${ALL_RIGHTS_RESERVED}."

# 既に書き込み済みの場合はスキップ
if [ $(grep "${ALL_RIGHTS_RESERVED}" "${filePath}" | wc -l | xargs) -ge 1 ]; then
  exit 0
fi

# 拡張子毎に位置・形式を変えてCopyrightを挿入する
if [ ${extension} == ".ts" ] || \
    [ ${extension} == ".tsx" ] || \
    [ ${extension} == ".js" ] || \
    [ ${extension} == ".jsx" ]; then
  LF=$(printf '\\\012_')
  LF=${LF%_}
  sed -i "" "1s|^|// ${COPYRIGHT}${LF}${LF}|" "${filePath}"
elif [ ${extension} == ".md" ]; then
  echo "\n\n<!-- ${COPYRIGHT} -->" >> ${filePath}
fi
