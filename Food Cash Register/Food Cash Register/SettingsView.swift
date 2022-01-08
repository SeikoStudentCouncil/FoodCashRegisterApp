//
//  SettingsUIView.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/07/18.
//

import SwiftUI

class Settings :ObservableObject{
    @Published var store : String
    @Published var scan : Bool
    @Published var stores : [String]
    
    func saveStoreSetting(){
        UserDefaults.standard.set(store, forKey: "StoreSetting")
    }
    func saveScanFeatureSetting(){
        UserDefaults.standard.set(scan, forKey: "ScanFeatureSetting")
    }
    init(){
        let storeOptions = getStoreOptions()
        self.stores = storeOptions
        if let storeSettings = UserDefaults.standard.string(forKey: "StoreSetting"){
            self.store = storeSettings
        } else {
            self.store = storeOptions[0]
        }
        self.scan = UserDefaults.standard.bool(forKey: "ScanFeatureSetting")
    }
}

struct SettingsView: View {
    @EnvironmentObject var settings : Settings
    
    var body: some View {
        Form{
            Section(header:Text("店舗"),footer:Text("この情報に基づいてメニューが変更されます")){
                HStack {
                    Picker(selection: $settings.store, label: Text("変更"), content: {
                        ForEach((0..<settings.stores.count), id: \.self){ index in
                            Text(settings.stores[index])
                        }
                    })
                    .pickerStyle(MenuPickerStyle())
                }
                .onChange(of: settings.store, perform: { value in
                    settings.saveStoreSetting()
                })
            }
            Section(header:Text("実験的機能")){
                Toggle(isOn: $settings.scan.animation()) {
                    Text("バーコードスキャン")
                }
                .onChange(of: settings.scan, perform: {value in
                    settings.saveScanFeatureSetting()
                })
            }
        }
        .navigationTitle("設定")
    }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Settings())
    }
}
