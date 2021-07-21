//
//  FoodListView.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/18.
//

import SwiftUI

struct FoodDetail :Identifiable{
    let id = UUID()
    
    let titile: String
    let subtitle: String
    let price: Int
}

struct FoodOrder :Identifiable{
    let id = UUID()
    
    let food: FoodDetail
    var count: Int
}

class FoodSelection: ObservableObject {
    @Published var selected = [FoodOrder]()
}

let data :[FoodDetail] = [FoodDetail(titile: "焼きそば", subtitle: "塩", price: 100),FoodDetail(titile: "焼きそば", subtitle: "ソース", price: 100)]

struct FoodListView: View {
    
    @StateObject private var orders = FoodSelection()
    @State private var navigationActive = false
    
    var body: some View {
        ScrollView{
            LazyHGrid(rows: [GridItem(.adaptive(minimum: 300, maximum: 450),spacing: 30)]) {
                ForEach(data){ each in
                    EachFoodView(data: each,orders: orders)
                }
            }
            .padding(.top)
        }
        .toolbar{
            ToolbarItem(placement:.navigationBarTrailing){
                if countTheNumberOfOrders() != 0{
                    NavigationLink(
                        destination: PaymentView(orders: orders,navigationActive: $navigationActive),isActive: $navigationActive,
                        label: {
                            Text("決定")
                        })
                }
            }
        }
        .navigationTitle("レジ")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func countTheNumberOfOrders() -> Int {
        var count = 0
        self.orders.selected.forEach{ food in
            count += food.count
        }
        return count
    }
}

struct EachFoodView: View {
    let data: FoodDetail
    @ObservedObject var orders: FoodSelection
    
    @State private var count = 0
    var body: some View{
        VStack(alignment:.leading) {
            Rectangle()
                .frame(width: 250, height: 150)
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
        .onAppear{
            self.count = 0
        }
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView()
    }
}
