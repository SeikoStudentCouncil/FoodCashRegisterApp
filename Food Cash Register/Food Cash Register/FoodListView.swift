//
//  FoodListView.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/18.
//

import SwiftUI

struct FoodDetail :Identifiable{
    let id = UUID()
    
    let store : Int
    let image : String
    let titile: String
    let subtitle: String
    let price: Int
}

struct FoodOrder :Identifiable{
    let id = UUID()
    
    let food: FoodDetail
    var count: Int
}

struct OrderSet :Identifiable{
    let id = UUID()
    
    var food: [FoodOrder]
}

class OrderData: ObservableObject {
    @Published var selected = [FoodOrder]()
    @Published var paid = [OrderSet(food: [FoodOrder(food: data[0], count: 4),FoodOrder(food: data[1], count: 2)])]
}

let data :[FoodDetail] = [FoodDetail(store: 1, image: "sample", titile: "焼きそば", subtitle: "塩", price: 100),FoodDetail(store: 2,image: "sample", titile: "焼きそば", subtitle: "ソース", price: 100)]

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
                    ForEach(data.filter{ $0.store == settings.store}){ each in
                        EachFoodView(data: each,orders: orders)
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
            .navigationTitle("レジ")
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
                Image(data.image)
                    .resizable()
                    .scaledToFill()
                Text(data.titile)
                    .font(.system(.largeTitle))
                Text(data.subtitle)
                    .font(.system(.subheadline))
                Stepper(value: $count, in: 0...20) {
                    Text(count != 0 ? "\(count)個" : "なし")
                }
                .onChange(of: count, perform: { value in
                    if let index = orders.selected.firstIndex(where: { $0.food.id == data.id }){
                        if value == 0 {
                            orders.selected.remove(at: index)
                        } else{
                            orders.selected[index].count = value
                        }
                    } else{
                        orders.selected.append(FoodOrder(food: data, count: value))
                    }
                    print(orders.selected)
                })
            }
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
