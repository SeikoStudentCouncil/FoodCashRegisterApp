//
//  SwiftUIView.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/18.
//

import SwiftUI

struct PaymentTypeSelectionView: View {
    @State private var goNext = false
    @ObservedObject var orders : FoodSelection
    
    var body: some View {
        HStack {
            NavigationLink(destination: PaymentView(orders: orders),
                isActive: $goNext,
                label: {
                    EmptyView()
                })
            Group {
                VStack {
                    Image(systemName: "banknote")
                        .font(.system(size: 120))
                    Text("現金決済")
                        .font(.system(size: 50))
                }
                .background(
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 300, height: 200)
                    .foregroundColor(Color(UIColor.systemGray5)))
            }
            .onTapGesture {
                goNext = true
            }
            Spacer(minLength: 30)
            Group {
                VStack {
                    Image(systemName: "creditcard")
                        .font(.system(size: 120))
                    Text("電子決済")
                        .font(.system(size: 50))
                }
                .background(
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 300, height: 200)
                    .foregroundColor(Color(UIColor.systemGray5)))
            }
            .onTapGesture {
        }
        }
        .frame(width: 600)
        .navigationTitle("決済方法")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct PaymentTypeSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        PaymentTypeSelectionView()
//    }
//}
