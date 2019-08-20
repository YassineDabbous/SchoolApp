//
//  MyViewController.swift
//  SchoolApp
//
//  Created by X on 7/13/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

class AnswersViewController: WithGenericTableView<AnswerCell, Answer> {
    
    lazy var router:MainRoutable = MainRoutable(viewController: self)
    
    
    var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        
        drawMainView()
        
        
        tableView = UITableView(frame: .zero)
        self.view.addSubview(tableView)
        tableView.fill(parent:main)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = .localized(.Answers)
        
        initTable(&tableView, 100)
        refreshData()
        
    }
    
    override func refreshData() {
        perform(APIClient.myAnswers()){ success, data in
            if success, let d = data {
                self.items = d
            }
        }
    }
    
    
    override func onInteract(_ indexPath: IndexPath, _ action: Action, _ model: Answer?) {
        print("on interact child called")
        print(model," -> ", action)
        router.question(question: Question(id:model!.postParent!))
    }

}
