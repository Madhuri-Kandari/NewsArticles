//
//  ServiceRequest.swift
//  NewsAppAssignment
//
//  Created by M1066900 on 25/08/21.
//

import Foundation
import Alamofire

class ServiceRequest{
    
    typealias DataRequestComplete = (Bool)->Void
    fileprivate var baseURL = ""
    static public let shared = ServiceRequest()
    let cache = NSCache<NSString, UIImage>()
    private(set) var state:State = .loading
    
    enum State{
        case results(NewsAPI)
        case loading
    }
    
    init(baseURL:String) {
        self.baseURL = baseURL
    }

    init(){}
    
//MARK:-Getting the API from URL using Alamofire request
    func getDataFromAPI(completion:@escaping DataRequestComplete){
        state = .loading
        AF.request(self.baseURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            (responseData) in
            
            var isParsedData = false
                
            guard let data = responseData.data else {
                    return
                }
            isParsedData = self.parseData(data: data)
            completion(isParsedData)
        }
    }
//Parsing the data using JSONDecoder
    func parseData(data:Data)->Bool{
        var success = false
        var newState = State.loading
        do{
            let newsArticleResults = try JSONDecoder().decode(NewsAPI.self, from: data)
            if newsArticleResults.articles.isEmpty{
                print(noResults)
            }else{
                
                newState = State.results(newsArticleResults)
            }
            success = true
            self.state = newState
            //print(success)
        }
        catch{
            print("error \(error)")
        }
        return success
    }
}
