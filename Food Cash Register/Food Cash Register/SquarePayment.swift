//
//  SquarePayment.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/20.
//

import Foundation

// Replace with your app's callback URL as set in the
// Square ApplicationDashboard [https://connect.squareup.com/apps]
// You must also declare this URL scheme in YOUR_PROJECT.plist,
// under URL types.
let yourCallbackURL = URL(string: "hellocharge://callback")!


// Specify the amount of money to charge.
var amount: SCCMoney?
do {
    amount = try SCCMoney(amountCents: 100, currencyCode: "USD")
} catch {}

// Your client ID is the same as your Square Application ID.
// Note: You only need to set your client ID once, before creating your first request.
SCCAPIRequest.clientID = YOUR_CLIENT_ID

var request: SCCAPIRequest?
do {
    request = try SCCAPIRequest(callbackURL: callbackURL,
                                amount: amount,
                                userInfoString: nil,
                                merchantID: nil,
                                notes: "Coffee",
                                customerID: nil,
                                supportedTenderTypes: SCCAPIRequestTenderTypeAll,
                                clearsDefaultFees: false,
                                returnAutomaticallyAfterPayment: false)
} catch {}
