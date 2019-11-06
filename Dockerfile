FROM ruby:2.4.5
# ↑ イメージ（rubyというリポジトリの2.4.5というタグのイメージ）を取り込んでる
RUN apt-get update -qq && apt-get install -y build-essential nodejs
# ↑ ruby:2.4.5のイメージからコンテナを起動して、コンテナ内で実行するコマンド
# apt-get（ubuntuのパッケージ管理システム）でbuild-essentialとnodejsのパッケージ（railsの動作に必要）をインストールしている
RUN mkdir /app
# ↑ ルートディレクトリ内にapp（フォルダ）を作成
# appディレクトリの中で、railsのプロジェクトファイルを作成する
WORKDIR /app
# ↑ 作業ディレクトリを/appに変更
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
# ↑ それぞれにファイルを/appディレクトリ内にコピー
# Gemfileとは、gem（rubyのライブラリ）を管理するためのファイル
# railsのプログラムもgemで公開されている
RUN bundle install
# ↑ Gemfileがあるディレクトリでbundle installすると、そのGemfileを実行（gemをインストールしたりなど）
COPY . /app
# ↑ Dockerfileの置いてあるフォルダの内容を全て、コンテナ内のappディレクトリにコピー
# コピーする理由は、railsのアプリケーション実行に必要なファイルをすべてコンテナに含めるため
