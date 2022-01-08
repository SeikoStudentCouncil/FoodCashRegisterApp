//
//  CashPaymentView.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/19.
//

import SwiftUI
import SquarePointOfSaleSDK

struct PaymentView: View {
    @Binding var orders : [FoodOrder]
    @Binding var scanMode : Bool
    @EnvironmentObject private var settings : Settings
    @State private var sheetIsActive = false
    @State private var change: Int? =  nil
    @State private var alert = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Form{
                Section{
                    ForEach(orders){ order in
                        RowView(orders: $orders, scanMode: $scanMode, order: order)
                        
//                        .onChange(of: orders[orders.firstIndex(where: {$0.food == order.food})!].count, perform: { value in
//                            if value == 0{
//                                withAnimation{
//                                    orders.remove(at: orders.firstIndex(where: {$0.food == order.food})!)
//                                }
//                            }
//                        })
                    }
                }
            }
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .frame(height: 130)
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
                    if totalPrice() != 0{
                        Button(action: {
                            payBySquare(price: totalPrice(), store: settings.store,method: .cash)
                        }){
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 150, height: 100)
                                    .foregroundColor(Color(UIColor.secondarySystemBackground))
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
                    }
                    if totalPrice() >= 100{
                        Button(action: {
                            payBySquare(price: totalPrice(), store: settings.store,method: .card)
                            }){
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width: 150, height: 100)
                                        .foregroundColor(Color(UIColor.secondarySystemBackground))
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
                            .padding(.leading,10)
                    }
                }
                .padding(.trailing,15)
            }
            .padding([.vertical, .trailing])
        }
        .navigationBarBackButtonHidden(true)
        .onOpenURL(perform: { url in
            do {
                let response = try SCCAPIResponse(responseURL: url)
                
                if let error = response.error {
                            alert = true
                            print(error.localizedDescription)
                        } else {
                            orders = [FoodOrder]()
                        }
            } catch{
                print("Error occured while opening url scheme")
            }
        })
        .alert(isPresented: $alert, content: {
            Alert(title: Text("決済失敗"), message: Text("もう一度お試しください"))
        })
    }
    func totalPrice() -> Int {
        var content = Int()
        orders.forEach{ each in
            content += (search(each.food).price*each.count)
        }
        return content
    }
}

private struct RowView: View {
    @Binding var orders : [FoodOrder]
    @Binding var scanMode : Bool
    @EnvironmentObject private var settings : Settings
    let order : FoodOrder
    var body: some View {
        let foodData = search(order.food)
        if let index = orders.firstIndex(where: {$0.food == order.food}){
            HStack{
                VStack(alignment:.leading) {
                    Text("\(foodData.titile) \(foodData.subtitle)")
                        .font(.title2)
                    Text("数量 \(order.count)個 | 商品価格 \(foodData.price)円")
                        .foregroundColor(.secondary)
                }
                Spacer()
                if scanMode{
                    Stepper(value: $orders[index].count, in: 1...20){
                        EmptyView()
                    }
                    .frame(width: 100)
                }
                Text("\(foodData.price * order.count)円")
                    .font(.title3)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: true){
                Button(role: .destructive,action: {
                    orders[index].count = 0
                    orders.remove(at: index)
                }){
                    Image(systemName: "trash.fill")
                }
            }
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(orders: .constant([FoodOrder(food: "hogehoge", count: 3)]), scanMode: .constant(true))
    }
}
