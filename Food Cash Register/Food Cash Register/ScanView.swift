//
//  ScanView.swift
//  Food Cash Register
//
//  Created by Yoshihiro Saigusa on 2021/12/22.
//

import SwiftUI
import CodeScanner

struct ScanView: View {
    @State private var scanned = false
    @Binding var orders : [FoodOrder]
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.systemGroupedBackground))
            if scanned{
                Image(systemName: "checkmark.circle")
                    .foregroundColor(Color(UIColor.green))
                    .font(.system(size: 100))
                    .transition(.scale)
                    .transition(.opacity)
                    
            } else{
                CodeScannerView(codeTypes: [.ean8,.ean13], simulatedData: "4901777334410", completion: self.handleScan)
                    .frame(width: 500, height: 500)
                    .cornerRadius(30)
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let result):
            let code = result.string
            if let order = menuDataBase().first(where: {$0.jan == code}){
                withAnimation{
                    scanned = true
                    if let index = orders.firstIndex(where: { $0.food == order.id }){
                        orders[index].count += 1
                    } else {
                        orders.append(FoodOrder(food: order.id, count: 1))
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation{
                        scanned = false
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
