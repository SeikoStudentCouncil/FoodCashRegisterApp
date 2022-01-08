//
//  ContentView.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/18.
//

import SwiftUI

struct ContentView: View {
    @State private var showSettings = false
    @State private var scan = false
    @State private var inCart = [FoodOrder]()
    @EnvironmentObject var settings : Settings
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(UIColor.systemGroupedBackground))
                .ignoresSafeArea()
            HStack{
                NavigationView{
                    Group{
                    if !settings.scan{
                        FoodListView(orders: $inCart)
                    } else {
                        TabView(selection: $scan){
                            FoodListView(orders: $inCart).tag(false)
                            ScanView(orders: $inCart).tag(true)
                        }
                        .tabViewStyle(.page)
                    }
                    }
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Button(action: {
                                    showSettings.toggle()
                                }, label: {
                                    Label("設定",systemImage:"gear")
                            })
                        }
                        ToolbarItem(placement: .navigationBarTrailing){
                            if settings.scan{
                            Picker(selection: $scan.animation(), content: {
                                Image(systemName: "list.bullet").tag(false)
                                Image(systemName: "barcode.viewfinder").tag(true)
                            }, label: {Text("モード選択")})
                                .pickerStyle(.segmented)
                            }
                        }
                    }
                    .sheet(isPresented: $showSettings, content: {
                        NavigationView {
                            SettingsView()
                                .toolbar(content: {
                                    ToolbarItem(placement: .confirmationAction){
                                        Button(action: {showSettings.toggle()}, label: {
                                            Text("完了")
                                        })
                                    }
                                })
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    })
                    .navigationTitle(scan ? "バーコードスキャン" : "商品リスト")
                    .navigationBarTitleDisplayMode(.inline)
                }
                PaymentView(orders: $inCart, scanMode: $scan)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Settings())
//            .previewInterfaceOrientation(.landscapeLeft)
    }
}
