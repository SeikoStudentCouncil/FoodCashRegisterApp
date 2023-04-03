# 電子決済アプリケーション Archive版
新規システムへの移行により恐らく今後のアプデはありません。
## version_2からの主な修正点
- 無駄な画面遷移がないようにUIを変更
- 食品一覧をグリッド表示からリスト表示に変更
- 食品一覧のサムネイルを削除
- アイテムをカート内から削除できるように修正
- 商品についているバーコードをスキャンすることにより、カートに商品を追加できる機能を追加
## 仕様
- 注文されている商品を入力する。
　 表示されている商品が別店舗の場合は、左上の設定ボタンから店舗を変更できる。
  ![Simulator Screen Shot - iPad (9th generation) - 2022-02-25 at 09 53 55](https://user-images.githubusercontent.com/87298805/155632771-5e20b115-d26e-4482-ab8e-05e9610e6c58.png)
  ![Simulator Screen Shot - iPad (9th generation) - 2022-02-25 at 09 56 42](https://user-images.githubusercontent.com/87298805/155633060-517947c3-ce0a-4857-b4b9-69581de8bf72.png)
- 合計金額をお客様に伝えて、現金決済と電子決済のどちらにするか聞く
  ![Simulator Screen Shot - iPad (9th generation) - 2022-02-25 at 09 57 10](https://user-images.githubusercontent.com/87298805/155633104-08657d1a-f27b-485f-b9b6-e1d0615c6563.png)

- 右下のどちらかのボタンを押すと、Square POS レジアプリに飛ぶ。
事前に伝えられたパスワードを入力する。
![square_password-keypad](https://user-images.githubusercontent.com/87298805/155630855-c1afe61a-56fe-4fa3-a4ac-ad47cc95509c.jpg)
- 決済
  - 現金決済

    お預かり金額を選ぶ。
    選択肢にない場合は、「カスタム」を押して入力する。
    ![square_cash-payment-custom](https://user-images.githubusercontent.com/87298805/155630902-87cb4881-b554-4527-8338-07a7c251c60a.jpg)
  - 電子決済

    決済方法を聞いて選んで、カードリーダーにかざしてもらう。決済が完了すると、元のアプリに戻る。
    ![square_e-payment_selection](https://user-images.githubusercontent.com/87298805/155630887-0cf5597d-9b31-4ae4-ba18-e669f56b078b.jpg)
    ![square_e-payment_scan](https://user-images.githubusercontent.com/87298805/155631143-56cc3537-5582-4bcf-b6bf-be960800e653.jpg)
## 注意事項
### SquareAPI　トークン
[Private.swift](/Food%20Cash%20Register/Food%20Cash%20Register/Private.swift)内のSquare API用のIDは[Square Developer](https://developer.squareup.com/jp/ja)にて割り当てられるIDを入力してください。
```
import Foundation

let callbackURL = URL(string: "food-register-app://")! //アプリにリダイレクトするURLスキーム
let applicationID = //Square APIの ApplicationID
let locationID = //Square APIの LocationID
```
### アプリケーションスキーム
Square POSレジアプリケーションが遷移して戻ってくるために、[Square Developer](https://developer.squareup.com/jp/ja)側でこのアプリケーションのURLスキームを設定してください。
詳しくは、[Point of Sale API公式リファレンス(英語)](https://developer.squareup.com/docs/pos-api/build-on-ios)を参照してください
### メニューの編集
このアプリでは内包されている[csvファイル](/Food%20Cash%20Register/Food%20Cash%20Register/menu.csv)を利用して、設定画面の食品店舗一覧やメニュー表を生成しています。
形式は以下の通りです。
```
店舗名,タイトル,サブタイトル(任意),価格,JANコード(任意)
```
- タイトルには商品の名前を、サブタイトルには味や用量などを記入してください。
（例）`牛肉どまん中,プレーン`
- 価格は半角数字の自然数を入力してください。
- JANコードはバーコードでカートに追加機能を使用したいときに使用します。
