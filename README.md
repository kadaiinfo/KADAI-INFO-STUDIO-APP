# 環境構築

## gitのインストール<br>
gitをインストールしていない場合はインストールします。<br>
https://kinsta.com/jp/knowledgebase/install-git/

## flutterの環境構築方法<br>
<br>Windowsの場合<br>
https://zenn.dev/heyhey1028/books/flutter-basics/viewer/getting_started_windows
<br>Macの場合<br>
https://zenn.dev/heyhey1028/books/flutter-basics/viewer/getting_started_mac

このプロジェクトを使って開発を始めるには、まずプロジェクトを自分のコンピュータにクローンする必要があります。Gitを使用している場合は、以下のコマンドをターミナルで実行してください。

クローンが完了したら、プロジェクトディレクトリに移動します。
プロジェクトに必要な依存関係をインストールします。

```
% git clone https://github.com/kadaiinfo/KADAI-INFO-STUDIO-APP.git
% cd KADAI-INFO-STUDIO-APP
% flutter pub get
```
依存関係のインストールが完了したら、開発を始める準備が整いました。

シミュレータが起動した状態で以下のコマンドで実行することで、プロジェクトをシミュレータ上で起動できます。
```
% flutter run
```

以下のコマンドで、接続可能なデバイスを一覧表示することができます。
```
% flutter deveices
```

上記のコマンドで取得したデバイスIDを指定して実行することで、実機上で起動することもできます。
```
% flutter run -d "<デバイスID>"
```

# 開発の進め方
1. まずはIssuesからIssueを立てるor引き受けます。右側のAssigneesのassign yourselfを押してください。
2. Assigneesの下の方にあるDevelopmentからbranchを作って作業してください。
3. 作業が一区切りついたら、コミットします。
    ```
    % git add .
    % git commit -m "<コミットメッセージ>"
    % git push origin <ブランチ名>
    ```
4. 全ての作業が終わったら、リポジトリの上部に黄色で表示されているCompere & pull requestを押します。プルリクを送ってください。
5. 誰かがコードを確認しておかしなところがなければMerge Pull requestを押して、マージします。
6. mainに戻ってpullします。
    ```
    % git checkout main 
    % git pull 
    ```
7. これでブランチで作業したものがmainに統合されます。

# バージョンの指定
バージョンは、pubspec.yamlファイルに指定します。<br>
``1.5.0+11``の場合、<br>
・1.5.0はリリースのバージョン<br>
・11はビルド番号<br>

リリースのバージョンは以下のように運用してきます。

大幅なシステム改変に伴うアップデートの場合。<br>
```1.0.0→2.0.0```<br>
中規模なアップデートの場合。新規機能の追加など<br>
```1.0.0→1.1.0```<br>
小規模なアップデートやメンテナンス、バグ修正など<br>
```1.0.0→1.0.1```<br>

ビルド番号はバージョンに限らず、ビルドするたび(ストアにリリースするたび)に一つずつ上げていきます。<br>
```1→2→3```<br>






