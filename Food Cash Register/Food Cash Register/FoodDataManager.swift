//
//  FoodDataManager.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/08/25.
//

import Foundation

func menuDataBase() -> [FoodDetail] {
    var content = [FoodDetail]()
    let path = Bundle.main.path(forResource:"menu", ofType:"csv")!
    do{
        let csvData = try String(contentsOfFile: path,encoding:String.Encoding.utf8)
        csvData.components(separatedBy: .newlines).forEach{ each in
            if !each.isEmpty{
                let data = each.components(separatedBy: ",")
                content.append(FoodDetail(id: data[0], store: stores.firstIndex(of: data[1])!, titile: data[2], subtitle: data[3], price: Int(data[4])!))
            }
        }
        return content
    } catch {
        print("エラー")
        return content
    }
}

func search(_ id: String) ->  FoodDetail{
    let dataBase = menuDataBase()
    let index = dataBase.firstIndex(where: {$0.id == id})!
    return dataBase[index]
}
