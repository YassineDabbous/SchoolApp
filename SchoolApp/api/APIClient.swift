//
//  APIClient.swift
//  MyApp
//
//  Created by X on 4/9/19.
//  Copyright © 2019 X. All rights reserved.
//

import Alamofire
import PromiseKit

class APIClient: BaseAPIClient {
    
    
    static func login(name: String, password: String) -> Promise<BaseResponse<AuthResponse>> {
        return performRequest(route: UserEndpoint.login(email: name, password: password))
    }
    static func logout() -> Promise<BaseResponse<[String]>> {
        return performRequest(route: UserEndpoint.logout)
    }
    static func forgotten(email: String) -> Promise<BaseResponse<[String]>> {
        return performRequest(route: UserEndpoint.forgotten(email: email))
    }
    static func register(request: RegisterRequest) -> Promise<BaseResponse<AuthResponse>> {
        return performRequest(route: UserEndpoint.register(request: request))
    }
    
    
    // -------------------- Posts --------------------
    static func search(word: String) -> Promise<BaseResponse<[Post]>> {
        return performRequest(route: PostsEndpoint.search(word: word))
    }
    static func getPosts(id: Int) -> Promise<BaseResponse<[Post]>> {
        return performRequest(route: PostsEndpoint.posts(id: id))
    }
    
    
    // ------------------ Categories ------------------
    static func getCategories() -> Promise<BaseResponse<[YCategory]>> {
        return performRequest(route: CategoriesEndpoint.parents)
    }
    static func getSubCategories(id:Int) -> Promise<BaseResponse<[YCategory]>> {
        return performRequest(route: CategoriesEndpoint.children(id: id))
    }
    
    
    // ------------------ Questions & Answers ------------------
    static func question(id:Int) -> Promise<BaseResponse<Question>> {
        return performRequest(route: QuestionsEndpoint.question(id: id))
    }
    static func questions() -> Promise<BaseResponse<[Question]>> {
        return performRequest(route: QuestionsEndpoint.questions)
    }
    static func myAnswers() -> Promise<BaseResponse<[Answer]>> {
        return performRequest(route: QuestionsEndpoint.answers(id: 0))
    }
    static func answers(id:Int) -> Promise<BaseResponse<[Answer]>> {
        return performRequest(route: QuestionsEndpoint.answers(id: id))
    }
    static func ask(request:QuestionRequest) -> Promise<BaseResponse<Question>> {
        return performRequest(route: QuestionsEndpoint.ask(request: request))
    }
    static func answer(request:AnswerRequest) -> Promise<BaseResponse<Answer>> {
        return performRequest(route: QuestionsEndpoint.answer(request: request))
    }
    
    
    // ------------------ General ------------------
    static func getAds() -> Promise<BaseResponse<Ad>> {
        return performRequest(route: GeneralEndpoint.ads)
    }
    static func getNotifications() -> Promise<BaseResponse<[YNotification]>> {
        return performRequest(route: GeneralEndpoint.notifications)
    }
    
    /*static func getArticles(completion:@escaping (Result<[Article]>)->Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
        performRequest(route: APIRouter.articles, decoder: jsonDecoder, completion: completion)
    }*/
    
}
