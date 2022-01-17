//
//  QuestionsObject.swift
//  MySocialNetwork
//
//  Created by Roberto Antonio on 09/01/22.
//

import Foundation
import ObjectMapper

class SurveyObject: Mappable {
    var colors : [String]?
    var questions : [QuestionObject]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        colors <- map["colors"]
        questions <- map["questions"]
    }
}

class QuestionObject : Mappable {
    var total : Int?
    var text : String?
    var chartData : [ChartDataObject]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        total <- map["total"]
        text <- map["text"]
        chartData <- map["chartData"]
    }
}

class ChartDataObject: Mappable {
    var text : String?
    var percetnage : Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        text <- map["text"]
        percetnage <- map["percetnage"]
    }
}
