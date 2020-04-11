YoutubeDownloader
====

## 概要
Youtubeから最高画質、最高音質で動画をダウンロードするツール

## 詳細
コマンドラインで実行する。

引数にダウンロード元のYoutubeの動画URLとダウンロード先を指定する。

ダウンロード先の指定は任意で、指定しなければ設定ファイル（config.ini）から取得する。

## 関連ツール
以下のフリーソフトを利用。

それぞれダウンロードし、同じフォルダに格納する。

- [youtube-dl](https://github.com/ytdl-org/youtube-dl)
  - Youtubeから動画をダウンロードする。他の動画サイトからもダウンロードできるみたいだが未検証。

- [ffmpeg](https://ffmpeg.zeranoe.com/builds/)
  - ダウンロードした動画のフォーマットを行う。

## パラメータ
コマンドライン引数の説明

- `%1`（必須）
  - ダウンロード元のYoutubeのURL
- `%2`（任意）
  - ダウンロード先のディレクトリ

## 設定ファイルについて
バッチと同一階層に設定ファイル（config.ini）を格納する。内容は以下の通り。

- `DL_DIR_PATH`
  - ダウンロード先のフォルダパス
- `CONSOLE_INPUT_FLG`
  - 引数が指定されていない場合にその引数をコンソール入力させるかどうか。
- `PAUSE_FLAG`
  - 処理の最後にpauseを実行するかどうか。親バッチが呼ばれることがあればFalseにする。

## 使い方
基本的な使い方：
```
Download.bat "[ダウンロード元URL]" "[ダウンロード先ディレクトリ]"
```
※引数は「"」で囲む。囲まないとバッチがうまく読み取れないことがある。

実行例：
```
Download.bat "https://www.youtube.com/watch?v=VFdLm6gEEE4" "C:\Downloads"
```
