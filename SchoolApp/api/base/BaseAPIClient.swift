//
//  BaseAPIClient.swift
//  MyApp
//
//  Created by X on 4/17/19.
//  Copyright © 2019 X. All rights reserved.
//


import Alamofire
import PromiseKit

class BaseAPIClient {
        
    @discardableResult
    static func performRequest<T:Decodable>(route:APIConfiguration, decoder: JSONDecoder = JSONDecoder()) -> Promise<BaseResponse<T>> {
        return Promise<BaseResponse<T>>{ seal -> Void in
            
            AF.request(route).responseDecodable(decoder: decoder){ (response: DataResponse<BaseResponse<T>>) in
                
                //print("Request: \(response.request)")
                //print("Response: \(response.response)")
                //print("Error: \(response.error)")
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Received Data: \(utf8Text)")
                }
                switch response.result {
                    case .success(let item):
                        print("sunccessss:::: ",item.data ?? "nil")
                        seal.fulfill(item)
                    case .failure(let error):
                        //seal.fulfill(route.offline) TODO
                        print("errroror::::", error.localizedDescription)
                        seal.reject(BackendError.network(error: error))
                }
            }
        }
    }
}

