//
//  QuestionViewController.swift
//  SchoolApp
//
//  Created by X on 7/15/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

class QuestionViewController: WithGenericTableView<AnswerCell, Answer> {
    
    lazy var router:MainRoutable = MainRoutable(viewController: self)
    var urls:[String] = []
    
    var question:Question!
    
    var titleView:LabelBold!
    var descriptionView:UILabel!
    var attachementLabel:LabelBold!
    var answerBtn:UIButton!
    var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        
        supportAds = false
        
        answerBtn = BtnPrimary(frame: .zero)
        answerBtn.setTitle(.localized(.Answer), for: .normal)
        view.addSubview(answerBtn)
        //answerBtn.atBottom(of: view, marginBottom: 8)
        answerBtn.anchor(leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8))
        
        let scrollView = UIScrollView(frame: .zero)
        self.view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: answerBtn.topAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        
        
        isScrollable = true
        drawMainView(scroller: scrollView)
        
        titleView = LabelBold()
        titleView.text = .localized(.Title)
        main.addSubview(titleView)
        titleView.anchor(top: main.topAnchor, leading: main.leadingAnchor, trailing: main.trailingAnchor)
        
        descriptionView = LabelRegular()
        descriptionView.text = .localized(.Description)
        //descriptionView.numberOfLines = 0
        //descriptionView.backgroundColor = .orange
        main.addSubview(descriptionView)
        descriptionView.toBottom(of: titleView)
        descriptionView.makeDashedBorderLine()
        //descriptionView.anchor(top: titleView.bottomAnchor, leading: main.leadingAnchor, trailing: main.trailingAnchor)
        
        
        attachementLabel = LabelBold()
        attachementLabel.text = .localized(.Attachements)
        main.addSubview(attachementLabel)
        
        let attachementImgView = UIImageView(image: UIImage(named: "file-image-outline"))
        main.addSubview(attachementImgView)
        attachementImgView.anchor(size: CGSize(width: 24, height: 24))
        
        let attachementStack = UIStackView(arrangedSubviews: [attachementImgView, attachementLabel])
        attachementStack.axis = .horizontal
        attachementStack.spacing = 5
        main.addSubview(attachementStack)
        attachementStack.toBottom(of: descriptionView, marginTop:10)
        //attachementStack.anchor(top: descriptionView.bottomAnchor, leading: main.leadingAnchor, trailing: main.trailingAnchor)
        let tap = UITapGestureRecognizer(target: self, action: #selector(showAttachements))
        attachementStack.addGestureRecognizer(tap)
        
        
        
        let commentsLabel = LabelBold()
        commentsLabel.text = .localized(.Comments)
        main.addSubview(commentsLabel)
        commentsLabel.toBottom(of: attachementStack, marginTop:10)
        //commentsLabel.anchor(top: attachementStack.bottomAnchor, leading: main.leadingAnchor, trailing: main.trailingAnchor)
        
        tableView = SelfSizedTableView()
        main.addSubview(tableView)
        tableView.anchor(top: commentsLabel.bottomAnchor, leading: main.leadingAnchor, trailing: main.trailingAnchor)
        tableView.bottomAnchor.constraint(equalTo: main.bottomAnchor).isActive = true
        
        
    }
    
    
    @objc func showAttachements() {
        print("selectStockStaus")
        let homeViewController = GenericTableViewController(source: urls, title: .localized(.Attachements), dismissOnClick: true)
        homeViewController.didSelect = { item in
            self.router.present(safari: item)
        }
        self.router.show(destination: homeViewController) { (controller) in
            
        }
        //Navigator.show(target: homeViewController, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = .localized(.Questions)
        
        answerBtn.addTarget(self, action: #selector(addAnswer), for: .touchUpInside)
        
        initTable(&tableView, 80)
        refreshData()
        
        //fitScroller()
    }
    
    override func refreshData() {
        if question.postTitle == nil || question.postTitle!.elementsEqual("") {
            perform(APIClient.question(id: question.id!)){ success, data in
                if success, let d = data {
                    self.question = d
                    self.bind()
                }
            }
        }else{
            bind()
        }
        
        perform(APIClient.answers(id: question.id ?? 1)){ success, data in
            if success, let d = data {
                self.items = d
            }
        }
    }
    
    func bind(){
        titleView.text = question.postTitle
        descriptionView.text = question.postContent!.html().string
        
        print("el Title =>", question.postTitle)
        print("el Title =>", titleView.text)
        
        let input = question.postContent ?? ""
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
        
        for match in matches {
            guard let range = Range(match.range, in: input) else { continue }
            let url = input[range]
            print(url)
            urls.append("\(url)")
        }
        print("urls count", urls.count)
        let att:String = .localized(.Attachements)
        attachementLabel.text = "\(att) (\(urls.count))"
        dump(urls)
    }
    
    override func onInteract(_ indexPath: IndexPath, _ action: Action, _ model: Answer?) {
        print("on interact child called")
        print(model," -> ", action)
        // TODO
    }
    

    @objc func addAnswer(){
        Alerts.showAlertInput(vc: self, title: .localized(.Answer), contentType: .addressCity, placeholder: .localized(.EnterYourAnswer)) { (answer) in
            self.saveMe(answer: answer)
        }
    }
    func saveMe(answer:String){
        let me = UserDefaults.Account.auth()?.id ?? 0
        if let parent = question.id {
            perform(APIClient.answer(request: AnswerRequest(title: "", description: answer, parent: "\(parent)", uid: "\(me)"))){ success, data in
                if success, let d = data {
                    self.items?.append(d)
                    self.tableView.reloadData()
                    Alerts.ok(vc: self)
                }
            }
        }
    }
    
}
