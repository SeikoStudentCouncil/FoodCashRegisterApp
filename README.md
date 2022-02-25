# 電子決済アプリケーション version_1
第62回聖光祭で実際に使用された電子決済アプリケーションです。
## 仕様
- 注文されている商品を入力する。
　 表示されている商品が別店舗の場合は、左上の設定ボタンから店舗を変更できる。
  ![square_primary-interface](https://user-images.githubusercontent.com/87298805/155630798-00292b78-a344-4019-aadc-45c11046d1d6.png)
- 合計金額をお客様に伝えて、現金決済と電子決済のどちらにするか聞く
  ![square_second-interface](https://user-images.githubusercontent.com/87298805/155630821-0ad4d02b-1dd6-4637-99db-e50998d593d8.png)
  ¥includegraphics[scale=0.15]{assets/square_second-interface.png}
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
