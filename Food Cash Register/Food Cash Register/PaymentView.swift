//
//  CashPaymentView.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/19.
//

import SwiftUI
import SquarePointOfSaleSDK

struct PaymentView: View {
    @ObservedObject var orders : OrderData
    @EnvironmentObject private var settings : Settings
    @Binding var navigationActive : Bool
    @State private var sheetIsActive = false
    @State private var change: Int? =  nil
    @State private var alert = false
    
    var body: some View {
        VStack {
            List{
                ForEach(orders.selected){ order in
                    let orderData = search(order.food)
                    VStack(alignment:.leading) {
                        HStack{
                            Text("\(orderData.titile) \(orderData.subtitle)")
                                .font(.title)
                            Spacer()
                            Text("\(orderData.price * order.count)円")
                                .font(.title3)
                        }
                        Text("数量 \(order.count)個 | 商品価格 \(orderData.price)円")
                            .foregroundColor(.secondary)
                    }
                }
            }
            Divider()
            HStack{
                VStack(alignment:.trailing){
                    Text("¥\(totalPrice())")
                    if let change = change{
                        Text("¥\(change)")
                        Text("¥\(change - totalPrice())")
                    }
                }
                .font(.system(size: 30))
                .padding(.leading)
                Spacer()
                Button(action: {
                    payBySquare(price: totalPrice(), store: stores[settings.store],method: .cash)
                }){
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 150, height: 100)
                            .foregroundColor(Color(UIColor.systemGray5))
                        VStack {
                            Image(systemName: "banknote")
                                .font(.system(size: 60))
                            Text("現金決済")
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                        }
                    }
                }
                    .accentColor(.primary)
                if totalPrice() >= 100{
                    Button(action: {
                        payBySquare(price: totalPrice(), store: stores[settings.store],method: .card)
                        }){
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 150, height: 100)
                                    .foregroundColor(Color(UIColor.systemGray5))
                                VStack {
                                    Image(systemName: "creditcard")
                                        .font(.system(size: 60))
                                    Text("電子決済")
                                        .font(.system(size: 20))
                                        .foregroundColor(.primary)
                                }
                                .foregroundColor(.accentColor)
                            }
                    }
                }
            }
            .padding([.vertical, .trailing])
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: {
                    navigationActive = false
//                    orders.selected = [FoodOrder]()
                }, label: {
                    Label("やり直す",systemImage: "chevron.left")
                })
            }
        })
        .onOpenURL(perform: { url in
            do {
                let response = try SCCAPIResponse(responseURL: url)
                
                if let error = response.error {
                            alert = true
                            print(error.localizedDescription)
                        } else {
                           navigationActive = false
                            orders.selected = [FoodOrder]()
                        }
            } catch{
            }
        })
        .alert(isPresented: $alert, content: {
            Alert(title: Text("決済失敗"), message: Text("もう一度お試しください"))
        })
        .navigationTitle("決済")
    }
    func totalPrice() -> Int {
        var content = Int()
        orders.selected.forEach{ each in
            content += (search(each.food).price*each.count)
        }
        return content
    }
}


struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(orders: OrderData(), navigationActive: .constant(true))
    }
}
