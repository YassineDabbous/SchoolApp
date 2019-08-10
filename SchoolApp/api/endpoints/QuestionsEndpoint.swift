//
//  QuestionsEndpoint.swift
//  SchoolApp
//
//  Created by X on 7/15/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation
import Alamofire
enum QuestionsEndpoint: APIConfiguration {
    
    case questions
    case question(id: Int)
    case answers(id: Int)
    case answer(request: AnswerRequest)
    case ask(request: QuestionRequest)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .questions:
            return .get
        case .answers( _):
            return .get
        case .answer( _):
            return .post
        case .ask( _):
            return .post
        case .question:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .question(let id):
            return "/questions/\(id)"
        case .questions:
            return "/questions"
        case .answers(let id):
            return "/questions/\(id)/answers"
        case .answer:
            return "/answers"
        case .ask:
            return "/questions"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .question:
            return nil
        case .questions:
            return nil
        case .answers( _):
                return nil
        case .answer( _):
                return nil
        case .ask( _):
                return nil
        }
    }
    
    
    var httpBody: Data?{
        let encoder = JSONEncoder()
        switch self {
        case .question:
            return nil
        case .questions:
            return nil
        case .answers:
            return nil
        case .answer(let request):
            return try! encoder.encode(request)
        case .ask(let request):
            return try! encoder.encode(request)
        }
    }
    
}




