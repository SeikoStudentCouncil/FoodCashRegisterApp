//
//  ScanView.swift
//  Food Cash Register
//
//  Created by Yoshihiro Saigusa on 2021/12/22.
//

import SwiftUI
import CodeScanner

struct ScanView: View {
    @Binding var orders : [FoodOrder]
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.systemGroupedBackground))
            CodeScannerView(codeTypes: [.ean8,.ean13], simulatedData: "4901777334410", completion: self.handleScan)
                .frame(width: 500, height: 500)
                .cornerRadius(30)
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let result):
            let code = result.string
            if menuDataBase().first(where: {$0.id == code}) != nil{
                withAnimation{
                    if let index = orders.firstIndex(where: { $0.food == code }){
                        orders[index].count += 1
                    } else {
                        orders.append(FoodOrder(food: code, count: 1))
                    }
                }
            } else {
                print("Barcode Not Found")
            }
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView(orders: .constant([FoodOrder(food: "hogehoge", count: 3)]))
    }
}
