//
//  MessagesViewModel.swift
//  MySocialNetwork
//
//  Created by Roberto Antonio on 10/01/22.
//

import Foundation

class MessagesViewModel: NSObject {
    var objects: [MessagesObject] = []
    
    var numItems : Int {
        get {
            return objects.count
        }
    }
    
    override init() {
        let item1 = MessagesObject(userImage: "userImage1", userName: "Vernon Bradley", message: "Shall we meet today", isNewMessage: true, totalMessagesNew: 2, timeStamp: "10:55 AM")
        
        objects.append(item1)
        
        let item2 = MessagesObject(userImage: "userImage2", userName: "Jason Howard", message: "Hahahahaha", isNewMessage: true, totalMessagesNew: 2, timeStamp: "10:40 AM")
        
        objects.append(item2)
        
        
    }
    
    func getUserNme(at indexPath: IndexPath) -> String {
        return objects[indexPath.row].userName ?? ""
    }
    
    
    func getUserImage(at indexPath: IndexPath) -> String {
        return objects[indexPath.row].userImage ?? ""
    }
    
    func getMessage(at indexPath:IndexPath) -> String {
        return objects[indexPath.row].message ?? ""
    }
    
    func getTimeStamp(at indexPath:IndexPath) -> String {
        return objects[indexPath.row].timeStamp ?? ""
    }
    
    func getTotalMessagesNew(at indexPath:IndexPath) -> Int {
        return objects[indexPath.row].totalMessagesNew ?? 0
    }
    
    func isNewMessage(at indexPath: IndexPath) -> Bool {
        return objects[indexPath.row].isNewMessage ?? false
    }

}
