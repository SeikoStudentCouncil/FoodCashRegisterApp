//
//  ContentView.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/18.
//

import SwiftUI

struct ContentView: View {
    @State private var showSettings = false
    var body: some View {
            NavigationView{
                FoodListView()
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Button(action: {
                                showSettings.toggle()
                            }, label: {
                                Label("設定",systemImage:"gear")
                            })
                            NavigationLink(
                                destination: SettingsView(),
                                label: {
                                })
                        }
                    }
            }
            .sheet(isPresented: $showSettings, content: {
                NavigationView {
                    SettingsView()
                        .toolbar(content: {
                            ToolbarItem(placement: .navigationBarTrailing){
                                Button(action: {showSettings.toggle()}, label: {
                                    Text("完了")
                                })
                            }
                        })
                        .navigationBarTitleDisplayMode(.inline)
                }
            })
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
