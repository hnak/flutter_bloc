# flutter_bloc

## 概要
FlutterにBlocパターンを導入してFirebaseのGoogleログインと連携するようにしたサンプルです。  
bloc_providerとして以下のライブラリを使用しています。 

https://github.com/mono0926/bloc_provider  
https://pub.dev/packages/bloc_provider

## セットアップ
- Firebaseにて新規プロジェクトの作成とiOSアプリの登録を行う
- Firebaseから GoogleService-Info.plist をダウンロードして ios/Runner/GoogleService-Info.plist に配置する
- ios/Runner/Info.plist.original を ios/Runner/Info.plist にリネームする
- Info.plist 内の paste-the-reversed-client-id-from-googleservice-info.plist-here と記載された場所に GoogleService-Info.plist 内の REVERSED_CLIENT_ID の Value を貼り付ける

## アプリの起動
```
flutter run
```

## ディレクトリ構成（検討中）
TODO:service,repository,blocあたりが曖昧なので整理する

```
─ lib  
  ├── bloc : ビジネスロジック
  ├── main.dart
  ├── models : モデル
  ├── repository : データ層に関する操作をビジネスロジックから分離するレポジトリ層
  ├── screens : 画面を構成するウィジェット
  ├── services : （リファクタリング予定）　
  ├── utils : 共通で使用する関数
  └── widgets : 共通で使用するウィジェット
```