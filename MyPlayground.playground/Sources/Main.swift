import Foundation
import Alamofire
//{"success":1,"error":[],"data":{"payment_methods":{"payza":{"code":"payza","title":"K-Net","terms":"","sort_order":""},"cod":{"code":"cod","title":"Cash On Delivery","terms":"","sort_order":"5"}}}}

public class TestApi {
    public static func run(id:Int) {
        
        var url = "https://mobily.store/api/rest/paymentmethods" //"https://mobily.store/api/rest/products/\(id)"//"https://mobily.store/api/rest/session"
        let headers: HTTPHeaders = [
            "X-Oc-Merchant-Id": "ywVSIexBhfKEWtEIkib8aCJsaSYhZMSC",
            "X-Oc-Session": "ce57b2sgfcfvdmdvdmko56bt43",/*
             "X-Oc-Merchant-Language": "en",
             "X-Oc-Image-Dimension": "400"
             //,"X-Oc-Store-Id": "1"*/
        ]
        
        AF.request(url, headers: headers).responseDecodable{ (response: DataResponse<BaseResponse<PaymentMethods>>) in
            //print("Request: \(response.request)")
            //print("Response: \(response.response)")
            //print("Error: \(response.error)")
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
            
            switch response.result {
            case .success(let item):
                print("\n\n\n\n")
                print("final product => ")
                print("-------------------")
                dump(item.data!.getData())
                /*let array:[PaymentMethod] = Array(item.data!.getData()!.paymentMethods!.values.map{ $0 })
                for m in array {
                    print("item ->", m)
                }*/

            case .failure(let error):
                print("errroror::::", error.localizedDescription)
            }
        }
    }
}
//---------- models ---------
class BaseResponse<T: Decodable> : Decodable {
    public var success:Int = 1
    public var error:[String]  = []
    ///public var data:T?
    public var data:DataUnion<T>?
}
enum DataUnion<T: Decodable>: Decodable {
    case dataClass(T)
    case stringArray([String])
    
    func getData() -> T? {
        switch self {
        case .dataClass(let d):
            return d
        case .stringArray(_ ):
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(T.self) {
            self = .dataClass(x)
            return
        }
        throw DecodingError.typeMismatch(DataUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DataUnion"))
    }
    
    
    /*func encode(to encoder: Encoder) throws {
     var container = encoder.singleValueContainer()
     switch self {
     case .dataClass(let x):
     try container.encode(x)
     case .stringArray(let x):
     try container.encode(x)
     }
     }*/
}


class Session : Codable{
    public var session:String = ""
}
//

struct PaymentMethods: Codable {
    let paymentMethods: [String:Cod]?
    
    enum CodingKeys: String, CodingKey {
        case paymentMethods = "payment_methods"
    }
}
struct PaymentMethod: Codable {
    let code, title, terms, sortOrder: String?
    
    enum CodingKeys: String, CodingKey {
        case code, title, terms
        case sortOrder = "sort_order"
    }
}

//
struct PaymentMethods2: Codable {
    let paymentMethods: PaymentMethodss?
    
    enum CodingKeys: String, CodingKey {
        case paymentMethods = "payment_methods"
    }
}

struct PaymentMethodss: Codable {
    let payza, cod: Cod?
}

struct Cod: Codable {
    let code, title, terms, sortOrder: String?
    
    enum CodingKeys: String, CodingKey {
        case code, title, terms
        case sortOrder = "sort_order"
    }
}
