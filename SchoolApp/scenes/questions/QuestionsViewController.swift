//
//  QuestionsViewController.swift
//  SchoolApp
//
//  Created by X on 7/17/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

class QuestionsViewController: WithGenericTableView<QuestionCell, Question> {
    
    lazy var router:MainRoutable = MainRoutable(viewController: self)
    
    
    var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        
        drawMainView()
        
        
        tableView = UITableView(frame: .zero)
        self.view.addSubview(tableView)
        tableView.fill(parent:main)
    }
    
    
    @objc func createQuestion(){
        router.questionCreator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        right0 = UIBarButtonItem(image: UIImage(named: "plus"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.createQuestion))
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = .localized(.Questions)
        
        initTable(&tableView, 70)
        refreshData()
    }
    
    override func refreshData() {
        perform(APIClient.questions()){ success, data in
            if success, let d = data {
                self.items = d
            }
        }
    }
    
    override func onInteract(_ indexPath: IndexPath, _ action: Action, _ model: Question?) {
        print("on interact child called")
        print(model," -> ", action)
        router.question(question: model!)
    }
    
}
