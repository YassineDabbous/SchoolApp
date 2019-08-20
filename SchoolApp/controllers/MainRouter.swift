//
//  MainRouter.swift
//  MyApp
//
//  Created by X on 5/1/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

extension AppRoutable{
    
    
    
    func auth() {
        show(destination: AuthViewController()){ controller in
        }
    }
    func register() {
        show(destination: RegisterViewController()){ controller in
        }
    }
    func recover() {
        show(destination: ResetViewController()){ controller in
        }
    }
    
    func search(word:String) {
        show(destination: FilesViewController()){ controller in
            controller.searchFor = word
            print("go to search for", controller.searchFor)
        }
    }
    
    
    /*func files(items:[Post]) {
        show(destination: FilesViewController()){ controller in
            controller.items = items
        }
    }*/
    func files(category:YCategory) {
        show(destination: FilesViewController()){ controller in
            controller.category = category
        }
    }
    
    func document(file:Post) {
        show(destination: DocumentViewController()){ controller in
            controller.file = file
        }
    }
    
    
    func categories(category:YCategory?) {
        show(destination: CategororiesViewController()){ controller in
            controller.category = category
        }
    }
    
    
    func notifications() {
        show(destination: NotificationsViewController()){ controller in
        }
    }
    func home() {
        show(destination: CategororiesViewController()){ controller in
        }
    }
    
    func answers() {
        if UserDefaults.Account.auth() != nil {
            show(destination: AnswersViewController()){ controller in
            }
        } else{
            auth()
        }
    }
    func questions() {
        if UserDefaults.Account.auth() != nil {
            show(destination: QuestionsViewController()){ controller in
            }
        } else{
            auth()
        }
    }
    func questionCreator() {
        if UserDefaults.Account.auth() != nil {
            show(destination: QuestionCreateVC()){ controller in
            }
        } else{
            auth()
        }
    }
    
    func question(question:Question) {
        if UserDefaults.Account.auth() != nil {
            show(destination: QuestionViewController()){ controller in
                controller.question = question
            }
        } else{
            auth()
        }
    }
    
    
    func browser(url:String) {
        show(destination: BrowserViewController()){ controller in
            controller.url = url
        }
    }
    
    
}
struct MainRoutable:AppRoutable{
    weak var viewController:UIViewController?
    init(viewController:UIViewController) {
        self.viewController = viewController
    }
}
