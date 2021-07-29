//
//  SquarePayment.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/20.
//

import Foundation
import SquarePointOfSaleSDK

enum PaymentMethod {
    case cash
    case card
}

func payBySquare(price:Int,store:String,method:PaymentMethod){
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
                    locationID: locationID,
                    notes: "聖光祭食品店舗 \(store)",
                    customerID: nil,
                supportedTenderTypes: (method == .card ? .card : .cash),
                    clearsDefaultFees: false,
                    returnsAutomaticallyAfterPayment: true,
                    disablesKeyedInCardEntry: true,
                    skipsReceipt: true
            )

        // Open Point of Sale to complete the payment.
        try SCCAPIConnection.perform(apiRequest)

    } catch let error as NSError {
        print(error.localizedDescription)
    }
}
