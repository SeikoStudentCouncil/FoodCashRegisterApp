//
//  FoodListView.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/18.
//

import SwiftUI

struct FoodDetail :Identifiable{
    let id :String
    
    let store : String
    let titile: String
    let subtitle: String
    let price: Int
}

struct FoodOrder :Identifiable{
    let id = UUID()
    
    let food: String
    var count: Int
}



struct FoodListView: View {
    @EnvironmentObject private var settings : Settings
    @Binding var orders : [FoodOrder]
    
    var body: some View {
        HStack {
            Form{
                Section{
                    ForEach(menuDataBase().filter{ $0.store == settings.store}){ each in
                        EachFoodView(data: each,orders: $orders)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func countTheNumberOfOrders() -> Int {
        var count = 0
        self.orders.forEach{ food in
            count += food.count
        }
        return count
    }
}

private struct EachFoodView: View {
    let data: FoodDetail
    @Binding var orders: [FoodOrder]
    
    @State private var count = 0
    var body: some View{
        HStack{
            VStack(alignment:.leading){
                Text(data.titile)
                    .font(.title2)
                    .lineLimit(data.subtitle.isEmpty ? 2 :1)
                if !data.subtitle.isEmpty{
                    Text(data.subtitle)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            Stepper(value: $count, in: 0...20){EmptyView()}
            .frame(width: 100)
            .onChange(of: count, perform: { value in
                withAnimation{
                    if let index = orders.firstIndex(where: { $0.food == data.id }){
                        if value == 0 {
                            orders.remove(at: index)
                        } else{
                            orders[index].count = value
                        }
                    } else{
                        orders.append(FoodOrder(food: data.id, count: value))
                    }
                }
                print(orders)
            })
            .onChange(of: orders.first(where: {$0.food == data.id})?.count ?? -1, perform: {value in
                if value != -1{
                    count = value
                }
            })
        }
//        .transition(.slide)
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView(orders: .constant([FoodOrder(food: "hogehoge", count: 3)]))
            .environmentObject(Settings())
    }
}
