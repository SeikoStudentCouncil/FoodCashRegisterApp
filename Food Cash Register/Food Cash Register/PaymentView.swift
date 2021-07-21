//
//  CashPaymentView.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/19.
//

import SwiftUI

struct PaymentView: View {
    @ObservedObject var orders : FoodSelection
    @State private var sheetIsActive = false
    @State private var change: Int? =  nil
    
    var body: some View {
        HStack {
            List{
                ForEach(orders.selected){ order in
                    VStack(alignment:.leading) {
                        HStack{
                            Text("\(order.food.titile) \(order.food.subtitle)")
                                .font(.title)
                            Spacer()
                            Text("\(order.food.price * order.count)円")
                                .font(.title3)
                        }
                        Text("数量 \(order.count)個 | 商品価格 \(order.food.price)円")
                            .foregroundColor(.secondary)
                    }
                }
            }
            Divider()
            VStack(alignment:.trailing){
                VStack(alignment:.trailing){
                    Text("¥\(totalPrice())")
                    if let change = change{
                        Text("¥\(change)")
                        Text("¥\(change - totalPrice())")
                    }
                }
                .font(.system(size: 30))
                .padding(.top)
                Spacer()
                if change == nil{
                    HStack {
                        Button(action: {
                            sheetIsActive = true
                        }){
                            VStack {
                                Image(systemName: "banknote")
                                    .font(.system(size: 60))
                                Text("現金決済")
                                    .font(.system(size: 20))
                                    .foregroundColor(.primary)
                            }
                            .background(
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 150, height: 100)
                                .foregroundColor(Color(UIColor.systemGray5)))
                        }
                        .accentColor(.primary)
                        .padding(.trailing,80)
                        Button(action: {
                            
                        }){
                            VStack {
                                Image(systemName: "creditcard")
                                    .font(.system(size: 60))
                                Text("電子決済")
                                    .font(.system(size: 20))
                                    .foregroundColor(.primary)
                            }
                            .foregroundColor(.accentColor)
                            .background(
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 150, height: 100)
                                .foregroundColor(Color(UIColor.systemGray5)))
                        }
                    }
                    .padding(.bottom)
                }
            }
            .frame(width:350)
        }
        .sheet(isPresented: $sheetIsActive){
            SheetView(change: $change,price : .constant(totalPrice()),isActive: $sheetIsActive)
        }
        .navigationTitle("決済")
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
    @Binding var change : Int?
    @Binding var price : Int
    @Binding var isActive: Bool
    @State private var yen = String()
    var body: some View {
        NavigationView{
            VStack {
                Text("おつりの金額を入力")
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
                                    change = Int(yen)
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

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(orders: FoodSelection())
    }
}
