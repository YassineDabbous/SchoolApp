//
//  APIConfiguration.swift
//  MyApp
//
//  Created by X on 4/9/19.
//  Copyright © 2019 X. All rights reserved.
//

import Alamofire
protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var httpBody: Data? { get }
}


extension APIConfiguration {
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        // Store Headers
        urlRequest.setValue(AuthValues.server1.apiKey, forHTTPHeaderField: HTTPHeaderField.merchantID.rawValue)
        urlRequest.setValue(AuthValues.server1.sessionKey, forHTTPHeaderField: HTTPHeaderField.session.rawValue)
        urlRequest.setValue(StoreOptions.server1.language, forHTTPHeaderField: HTTPHeaderField.language.rawValue)
        
        /*let headers: HTTPHeaders = [
         "X-Oc-Merchant-Id": "ywVSIexBhfKEWtEIkib8aCJsaSYhZMSC"/*,
         "X-Oc-Session": "i50djcan9d2ms99vauskpfm695",
         "X-Oc-Merchant-Language": "en",
         "X-Oc-Image-Dimension": "400"
         //,"X-Oc-Store-Id": "1"*/
         ]*/
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // HTTP Method
        if let httpBody = httpBody {
            urlRequest.httpBody = httpBody
        }
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        //print("||| - request :", urlRequest.description)
        dump(urlRequest)
        
        if let data = urlRequest.httpBody, let utf8Text = String(data: data, encoding: .utf8) {
            dump("Request Form Data: \(utf8Text)")
        }
        //// CACHE
        /////// urlRequest.cachePolicy = .returnCacheDataElseLoad
        
        /*upload(image: httpBody!, to: UserEndpoint.profile, params: [:], progressClosure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        }, completionClosure: { data in
            //Do what ever you want to do with response
        })*/

        return urlRequest
    }
}


func upload(image: Data, to url: Alamofire.URLRequestConvertible, params: [String: Any], progressClosure:(@escaping (Progress) -> Void), completionClosure:(@escaping (DataResponse<Any>) -> Void)) {
    
    let mp:MultipartFormData = {
        let multiPart = MultipartFormData()
        for (key, value) in params {
            if let temp = value as? String {
                multiPart.append(temp.data(using: .utf8)!, withName: key)
            }
            if let temp = value as? Int {
                multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
            }
            if let temp = value as? NSArray {
                temp.forEach({ element in
                    let keyObj = key + "[]"
                    if let string = element as? String {
                        multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                    } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                    }
                })
            }
        }
        multiPart.append(image, withName: "file", fileName: "file.png", mimeType: "image/png")
        return multiPart
    }()
    AF.upload(multipartFormData: mp, with: url)
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
            progressClosure(progress)
        })
        .responseJSON(completionHandler: { data in
            //dump(data)
            let utf8Text = String(data: data.data!, encoding: .utf8)
            print("final responseJSON", utf8Text)
            completionClosure(data)
            //Do what ever you want to do with response
        })
}
