# Fintan執筆テンプレート

Fintan記事を執筆する際に、markdownで書いた記事をWordpressに貼り付け可能な形（html）に変換します。個人またはチームごとに管理することを想定しています。

# 環境
- Windows
- Git Bashが使える環境
- node:v16.18


# 使い方
- 本リポジトリをcloneします
- 本リポジトリのarticle配下に記事のmarkdownファイルを作成します。画像は`./article/resources`配下に配置します。
- 本リポジトリ配下で`bash .\utility\release-wordpress.sh local`を叩きます
- `test`配下にhtmlファイルが作成されるので、WordPressの画面にコピペしてください


## 画像がある場合 （TODO：方針決め）
- WordPress側上で画像をアップロードし、画像のURLを取得します
- markdown上で`img`タグを作成します

## 未投稿の他記事へのリンクを含む場合
- 2つ以上の記事を同時に投稿する場合など、未投稿の他の記事へのリンクを含む場合は下記の手順でファイルを命名してください
- WordPress側の画面でリンク先の記事を新規作成し、記事の番号を取得します。
- `article` 配下の記事の命名を「XXXX(記事番号4桁)_記事名.md」に変更します
- Markdownファイル上ではローカルパスのまま記事を作成してください

## lintをかけたい場合
nodeがインストールされている場合、Markdownファイルに対してlintをかけることが可能です。lintの設定ファイルは下記3つです。それぞれサンプルの記載があるので、チームごとにカスタマイズが可能です。
- prh.yml
- .textlintrc
- .markdownlint.yml

textlintをかける場合は、`npm run textlint`、markdownlintをかける場合は`npm run lint:markdown`を実行してください。
