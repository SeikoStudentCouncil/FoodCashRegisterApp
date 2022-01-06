//
//  ScanView.swift
//  Food Cash Register
//
//  Created by Yoshihiro Saigusa on 2021/12/22.
//

import SwiftUI
//import CodeScanner

struct ScanView: View {
    @Binding var orders : [FoodOrder]
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.systemGroupedBackground))
            Text("Hello, World!")
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView(orders: .constant([FoodOrder(food: "hogehoge", count: 3)]))
    }
}
