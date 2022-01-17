//
//  HomeViewModel.swift
//  MySocialNetwork
//
//  Created by Roberto Antonio on 10/01/22.
//

import Foundation

class HomeViewModel: NSObject {
    private var objects: [HomeObject] = []
    
    var numItems : Int {
        get {
            return objects.count
        }
    }
    
    
    
    override init() {
        let item1 = HomeObject(userImage: "userImage3", userName: "Martin Palmer", timeAgo: "Today 10:34 AM", image: "postal1", price: "$340.00", isFavorite: false)
        
        objects.append(item1)
        
        let item2 = HomeObject(userImage: "userImage1", userName: "Pearl Myers", timeAgo: "Yesterday", image: "", price: "$290.00", isFavorite: true)
        
        objects.append(item2)
    }
    
    func getUserNme(at indexPath: IndexPath) -> String {
        return objects[indexPath.row].userName ?? ""
    }
    
    func getTimeAgo(at indexPath: IndexPath) -> String {
        return objects[indexPath.row].timeAgo ?? ""
    }
    
    func getUserImage(at indexPath: IndexPath) -> String {
        return objects[indexPath.row].userImage ?? ""
    }
    
    func getPostal(at indexPath: IndexPath) -> String {
        return objects[indexPath.row].image ?? ""
    }
    
    func getCost(at indexPath: IndexPath) -> String {
        return objects[indexPath.row].price ?? ""
    }
    
}
