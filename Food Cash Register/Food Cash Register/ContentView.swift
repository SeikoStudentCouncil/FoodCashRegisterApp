//
//  ContentView.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/18.
//

import SwiftUI

struct ContentView: View {
    @State private var showSettings = false
    @State private var showHistory = false
    @State private var scan = false
    @State private var inCart = [FoodOrder]()
    var body: some View {
            NavigationView{
                ZStack{
                    Rectangle()
                        .foregroundColor(Color(UIColor.systemGroupedBackground))
                        TabView(selection: $scan){
                            HStack{
                                FoodListView(orders: $inCart)
                                PaymentView(orders: $inCart)
                            }
                            .tag(false)
                            HStack{
                                ScanView(orders: $inCart)
                                PaymentView(orders: $inCart)
                            }
                            .tag(true)
                        }
                        .tabViewStyle(.page)
                }
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        Button(action: {
                                showSettings.toggle()
                            }, label: {
                                Label("設定",systemImage:"gear")
                        })
                    }
                    ToolbarItem(placement: .navigationBarLeading){
                        Picker(selection: $scan.animation(), content: {
                            Text("リスト").tag(false)
                            Text("スキャン").tag(true)
                        }, label: {Text("モード選択")})
                            .pickerStyle(.segmented)
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
                .sheet(isPresented: $showHistory, content: {
                    NavigationView {
                        SettingsView()
                            .toolbar(content: {
                                ToolbarItem(placement: .confirmationAction){
                                    Button(action: {showHistory.toggle()}, label: {
                                        Text("完了")
                                    })
                                }
                            })
                            .navigationBarTitleDisplayMode(.inline)
                    }
                })
                .navigationTitle(scan ? "バーコードスキャン" : "商品一覧")
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Settings())
//            .previewInterfaceOrientation(.landscapeLeft)
    }
}
