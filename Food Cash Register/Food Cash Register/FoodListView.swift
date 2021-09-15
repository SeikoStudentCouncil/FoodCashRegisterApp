//
//  FoodListView.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/18.
//

import SwiftUI

struct FoodDetail :Identifiable{
    let id :String
    
    let store : Int
    let titile: String
    let subtitle: String
    let price: Int
}

struct FoodOrder :Identifiable{
    let id = UUID()
    
    let food: String
    var count: Int
}

struct OrderSet :Identifiable{
    let id = UUID()
    
    var food: [FoodOrder]
}

class OrderData: ObservableObject {
    @Published var selected = [FoodOrder]()
    @Published var paid = [OrderSet(food: [FoodOrder(food: menuDataBase()[0].id, count: 4),FoodOrder(food: menuDataBase()[1].id, count: 2)])]
}


struct FoodListView: View {
    @EnvironmentObject private var settings : Settings
    @EnvironmentObject private var orders : OrderData
    @State private var navigationActive = false
    
    var body: some View {
        HStack {
            NavigationLink(
                destination: PaymentView(orders: orders,navigationActive: $navigationActive),isActive: $navigationActive,
                label: {
                    EmptyView()
                })
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum:300, maximum: 400),spacing: 20)]) {
                    ForEach(menuDataBase().filter{ $0.store == settings.store}){ each in
                        EachFoodView(data: each,orders: orders)
                            .frame(width: 300, height: 300)
                            .padding(.all)
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement:.navigationBarTrailing){
                    if countTheNumberOfOrders() != 0{
                        Button(action: {
                            navigationActive.toggle()
                        }, label: {
                            Text("決定")
                        })
                    }
                }
            }
            .navigationTitle("商品一覧")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func countTheNumberOfOrders() -> Int {
        var count = 0
        self.orders.selected.forEach{ food in
            count += food.count
        }
        return count
    }
}

private struct EachFoodView: View {
    let data: FoodDetail
    @ObservedObject var orders: OrderData
    
    @State private var count = 0
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
            VStack(alignment:.leading){
                HStack {
                    Spacer()
                    Image(data.id)
                        .resizable()
                        .scaledToFit()
                    Spacer()
                }
                Spacer()
                Text(data.titile)
                    .font(.title)
                    .lineLimit(data.subtitle.isEmpty ? 2 :1)
                if !data.subtitle.isEmpty{
                    Text(data.subtitle)
                        .font(.title2)
                }
                Stepper(value: $count, in: 0...20) {
                    Text(count != 0 ? "\(count)個" : "なし")
                }
                .onChange(of: count, perform: { value in
                    if let index = orders.selected.firstIndex(where: { $0.food == data.id }){
                        if value == 0 {
                            orders.selected.remove(at: index)
                        } else{
                            orders.selected[index].count = value
                        }
                    } else{
                        orders.selected.append(FoodOrder(food: data.id, count: value))
                    }
                    print(orders.selected)
                })
            }
//            .frame(width: 300, height: 300)
            .padding(10)
        }
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView()
            .environmentObject(Settings())
            .environmentObject(OrderData())
    }
}
