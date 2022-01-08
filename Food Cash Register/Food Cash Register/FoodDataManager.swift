//
//  FoodDataManager.swift
//  Food Cash Register
//
//  Created by Yoshihiro on 2021/08/25.
//

import Foundation

func menuDataBase() -> [FoodDetail] {
    var content = [FoodDetail]()
    var id = 0
    let path = Bundle.main.path(forResource:"menu", ofType:"csv")!
    do{
        let csvData = try String(contentsOfFile: path,encoding:String.Encoding.utf8)
        csvData.components(separatedBy: .newlines).forEach{ each in
            if !each.isEmpty{
                let data = each.components(separatedBy: ",")
                content.append(FoodDetail(id: String(id), store: data[0], titile: data[1], subtitle: data[2], price: Int(data[3])!, jan: data[4]))
                id += 1
            }
        }
        return content
    } catch {
        print("エラー")
        return content
    }
}

func getStoreOptions() -> [String]{
    var content = [String]()
    let path = Bundle.main.path(forResource:"menu", ofType:"csv")!
    do{
        let csvData = try String(contentsOfFile: path,encoding:String.Encoding.utf8)
        csvData.components(separatedBy: .newlines).forEach{ each in
            if !each.isEmpty{
                let data = each.components(separatedBy: ",")
                content.append(data[0])
            }
        }
    } catch {
        print("エラー")
    }
    return unique(content)
}

func unique(_ array: [String]) -> [String]{
    let orderedSet:NSOrderedSet = NSOrderedSet(array: array)
    return orderedSet.array as! [String]
}

func search(_ id: String) ->  FoodDetail{
    let dataBase = menuDataBase()
    let index = dataBase.firstIndex(where: {$0.id == id})!
    return dataBase[index]
}
