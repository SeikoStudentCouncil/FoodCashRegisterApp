//
//  SquarePayment.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/20.
//

import Foundation
import SquarePointOfSaleSDK

// Replace with your app's URL scheme.

// Your client ID is the same as your Square Application ID.
// Note: You only need to set your client ID once, before creating your first request.

func payBySquare(price:Int,note:String){
    SCCAPIRequest.setApplicationID(applicationID)
    
    do {
        // Specify the amount of money to charge.
        let money = try SCCMoney(amountCents: price, currencyCode: "JPY")

        // Create the request.
        let apiRequest =
            try SCCAPIRequest(
                    callbackURL: callbackURL,
                    amount: money,
                    userInfoString: nil,
                    locationID: nil,
                    notes: note,
                    customerID: nil,
                    supportedTenderTypes: .all,
                    clearsDefaultFees: false,
                    returnsAutomaticallyAfterPayment: true,
                    disablesKeyedInCardEntry: false,
                    skipsReceipt: true
            )

        // Open Point of Sale to complete the payment.
        try SCCAPIConnection.perform(apiRequest)

    } catch let error as NSError {
        print(error.localizedDescription)
    }
}
