//
//  CashPaymentView.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/22.
//

import SwiftUI

struct CashPaymentView: View {
    @ObservedObject var orders : FoodSelection
    @Binding var navigationActive: Bool
    @State private var sheetIsActive = true
    @State private var paid: Int? =  nil
    
    var body: some View {
        let total = totalPrice()
        
        VStack {
            HStack {
                Text("金額")
                Spacer()
                Text("¥\(total)")
            }
            if let paid = paid{
                HStack{
                    Text("お預かり")
                    Spacer()
                    Text("¥\(paid)")
                }
                Divider()
                HStack{
                    Text("お釣り")
                    Spacer()
                    Text("¥\(paid-total)")
                }
            }
        }
        .frame(width:300)
        .font(.system(size: 30))
        .sheet(isPresented: $sheetIsActive){
            SheetView(paid: $paid,price : total,isActive: $sheetIsActive)
        }
        .toolbar(content: {
            ToolbarItem(placement:.navigationBarTrailing){
                Button(action: {navigationActive = false}, label: {
                    Text("完了")
                })
            }
        })
        .navigationTitle("現金決済")
        .navigationBarBackButtonHidden(true)
    }
    func totalPrice() -> Int {
        var price = 0
        self.orders.selected.forEach{ food in
            price += (food.count * food.food.price)
        }
        return price
    }
}

private struct SheetView: View {
    @Binding var paid : Int?
    @State var price : Int
    @Binding var isActive: Bool
    @State private var yen = String()
    var body: some View {
        NavigationView{
            VStack {
                Text("お預かり")
                    .font(.system(size: 30))
                Text("¥\(yen)")
                    .font(.system(size: 50))
                NumberPadView(number: $yen)
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing){
                    if let entered = Int(yen) {
                        if entered >= price{
                            Button(action:{
                                    paid = Int(yen)
                                    isActive = false
                                }){
                                    Text("完了")
                                }
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {isActive = false}, label: {
                        Text("キャンセル")
                    })
                }
            })
        }
    }
}

struct CashPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        CashPaymentView(orders: FoodSelection(), navigationActive: .constant(true))
    }
}
