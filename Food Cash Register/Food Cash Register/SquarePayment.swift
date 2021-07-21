//
//  SquarePayment.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/20.
//

import Foundation

let yourCallbackURL = URL(string: "your-url-scheme://")!
//
//SCCAPIRequest.setClientID("YOUR_CLIENT_ID")
//
//do {
//    // Specify the amount of money to charge.
//    let money = try SCCMoney(amountCents: 1000, currencyCode: "JPY")
//
//    // Create the request.
//    let apiRequest =
//        try SCCAPIRequest(
//            callbackURL: yourCallbackURL,
//            amount: money,
//            userInfoString: nil,
//            merchantID: nil,
//            notes: "Coffee",
//            customerID: nil,
//            supportedTenderTypes: .all,
//            clearsDefaultFees: false,
//            returnAutomaticallyAfterPayment: false
//        )
//
//    // Open Point of Sale to complete the payment.
//    try SCCAPIConnection.perform(apiRequest)
//
//} catch let error as NSError {
//    print(error.localizedDescription)
//}
//
//func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
//    guard let sourceApplication = options[.sourceApplication] as? String,
//        sourceApplication.hasPrefix("com.squareup.square") else {
//        return false
//    }
//
//    do {
//        let response = try SCCAPIResponse(responseURL: url)
//
//        if let error = response.error {
//            // エラー時の処理です
//            print(error.localizedDescription)
//        } else {
//            // 成功時の処理です
//        }
//
//    } catch let error as NSError {
//        // 例外発生時の処理です
//        print(error.localizedDescription)
//    }
//
//    return true
//}
