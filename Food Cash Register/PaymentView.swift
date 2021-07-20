//
//  CashPaymentView.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/19.
//

import SwiftUI

struct PaymentView: View {
    @ObservedObject var orders : FoodSelection
    
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
                Text("\(totalPrice())円")
                    .font(.system(size: 50))
                    .padding(.bottom)
                HStack {
                    Button(action: {}){
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
                    Button(action: {}){
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
                Spacer()
            }
            .frame(width:400)
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

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(orders: FoodSelection())
    }
}
