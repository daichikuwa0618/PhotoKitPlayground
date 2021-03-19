# PhotoKitPlayground

PhotoKit で遊んでみました。

## Overview

`PHPickerViewController` 経由で Photo Library の写真を選択、画面に表示するアプリです。  
API の簡単な解説、実装の解説は[ブログとして記事](https://daichidaiji.com/photokit-playground/)を書いています。

<img width="300" src="https://user-images.githubusercontent.com/31601805/111728455-4351fb80-88b0-11eb-8b8d-b00a5448a591.gif">

## Features

`PHPickerViewController` で画像が選択された時 `assetIdentifier` または `itemProvider` 経由で `UIImage` に変換できますが、

- `assignImage(from id: String?)`
  - `assetIdentifier` から `UIImage` を取得して、 `imageView` に反映させる
- `assignImage(from provider: NSItemProvider)`
  - `itemProvider` から `UIImage` を取得して、 `imageView` に反映させる

のメソッドを用意しているので、いずれの方法でも画面に反映させることが可能です。
