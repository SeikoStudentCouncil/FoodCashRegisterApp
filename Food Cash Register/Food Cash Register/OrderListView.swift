//
//  OrderListView.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/30.
//

import SwiftUI

struct OrderListView: View {
    @EnvironmentObject private var data : OrderData
    @State private var uploading = false
    var body: some View {
        List{
            ForEach(data.paid){ each in
                NavigationLink(
                    destination: EmptyView(),
                    label: {
                        Text("\(each.food.count)個のアイテム")
                    })
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing){
                if uploading{
                    ProgressView()
                } else {
                    Button(action: {
                        
                    }, label: {
                        Label("アップロード",systemImage: "icloud.and.arrow.up")
                    })
                }
            }
        })
        .navigationTitle("オーダー")
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OrderListView()
        }
        .environmentObject(OrderData())
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
