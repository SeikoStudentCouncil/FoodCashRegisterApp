# 電子決済アプリケーション version_2
第62回聖光祭で起きた不満点を改善した電子決済アプリケーションです。
## version_1からの主な修正点
- 無駄な画面遷移がないようにUIを変更
- 食品一覧をグリッド表示からリスト表示に変更
- 食品一覧のサムネイルを削除
- アイテムをカート内から削除できるように改善
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
## 注意
[Private.swift](/Food%20Cash%20Register/Food%20Cash%20Register/Private.swift)内のSquare API用のIDは[Square Developer](https://developer.squareup.com/jp/ja)にて割り当てられるIDを入力してください。
```
import Foundation

let callbackURL = URL(string: "food-register-app://")! //アプリにリダイレクトするURLスキーム
let applicationID = //Square APIの ApplicationID
let locationID = //Square APIの LocationID
```
