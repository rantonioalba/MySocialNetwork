//
//  SurveyService.swift
//  MySocialNetwork
//
//  Created by Roberto Antonio on 09/01/22.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

struct SurveyService {
    
    static func fetch<T:Mappable>(completion:@escaping(_ DataResponse:T) -> Void, completionError:@escaping(_ errorString:String) -> Void)  {
        
        let Almgr : Alamofire.SessionManager = {
            
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 120
            configuration.timeoutIntervalForResource = 120
            
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            let man = Alamofire.SessionManager(
                configuration: URLSessionConfiguration.default
            )
            return man
        }()
        
        let url = "https://us-central1-bibliotecadecontenido.cloudfunctions.net/helloWorld"
        
        let headers = [
                    "content-type": "application/json",
                ]
        
        Almgr.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseObject { (response: DataResponse<T>) in
            let _ = Almgr
            if response.result.isSuccess{
                let surveyService = response.result.value
                completion(surveyService!)
            } else {
                completionError((response.result.error?.localizedDescription)!)
            }
        }
    }
}
