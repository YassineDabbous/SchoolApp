//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import MessageUI
import PromiseKit

struct MenuItem {
    let title, icon:String
    let type:DrawerItem
}
enum DrawerItem:String {
    case solutions = "Solutions"
    case training = "Training"
    case myQuestions = "My Questions"
    case myAnswers = "My Answers"
    case notifications = "Notifications"
    case rateApp = "Rate App"
    case contactUs = "Contact us"
    case shareApp = "Share App"
    case privacy = "Privacy"
    case logout = "Logout"
}

class LeftViewController : WithGenericTableView<LeftDrawerCell, MenuItem> {
    
    var mainController:MainViewController!
    lazy var router:MainRoutable = MainRoutable(viewController: mainController) // navigation in mainController and not in side drawer
    
    
    var headerView:UIView!
    var imgView:UIImageView!
    var nameView:UILabel!
    var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        supportAds = false
        drawMainView()
        
        headerView = UIView(frame: .zero)
        self.view.addSubview(headerView)
        headerView.atTop(of: main, height: 150)
        
        imgView = UIImageView(image: UIImage(named: "app-logo"))
        headerView.addSubview(imgView)
        imgView.anchor(top: headerView.topAnchor, leading: headerView.leadingAnchor, trailing: headerView.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 40, bottom: 0, right: 40), size: CGSize(width: 0, height: 80))
        
        nameView = LabelBold()
        nameView.textAlignment = .center
        nameView.text = Utils.app_name
        headerView.addSubview(nameView)
        nameView.toBottom(of: imgView, marginTop:4)
        
        tableView = UITableView(frame: .zero)
        self.view.addSubview(tableView)
        tableView.anchor(top: headerView.bottomAnchor, leading: main.leadingAnchor, bottom: main.bottomAnchor, trailing: main.trailingAnchor)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.backgroundColor = .white
        
        initTable(&tableView)
        self.items = [
            MenuItem(title: "", icon: "lightbulb-on-outline", type: .solutions),
            MenuItem(title: "", icon: "android-studio", type: .training),
            MenuItem(title: "", icon: "comment-question-outline", type: .myQuestions),
            MenuItem(title: "", icon: "file-document-edit-outline", type: .myAnswers),
            MenuItem(title: "", icon: "bell-outline", type: .notifications),
            MenuItem(title: "", icon: "star-outline", type: .rateApp),
            MenuItem(title: "", icon: "phone", type: .contactUs),
            MenuItem(title: "", icon: "share-variant", type: .shareApp),
            MenuItem(title: "", icon: "shield-lock", type: .privacy),
            MenuItem(title: "", icon: "logout", type: .logout)
        ]
        
        //nameView.text = UserDefaults.Account.auth()?.displayName ?? Utils.app_name
    }
    
    static var name:String?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let displayName = LeftViewController.name ?? Utils.app_name
        print("left drawer witll appear", displayName)
        nameView.text = displayName
    }
    
    
    override func onInteract(_ indexPath: IndexPath, _ action: Action, _ model: MenuItem?) {
        print("on interact child called")
        print(model as Any," -> ", action)
        switch model!.type {
            case .solutions:
                router.categories(category: YCategory(id: 89, name: "", termOrder: 0, childNumber: 0, postsNumber: "0"))
                toggleLeft()
            case .training:
                router.categories(category: YCategory(id: 90, name: "", termOrder: 0, childNumber: 0, postsNumber: "0"))
                toggleLeft()
            case .myQuestions:
                router.questions()
                toggleLeft()
            case .myAnswers:
                router.answers()
                toggleLeft()
            case .notifications:
                router.notifications()
                toggleLeft()
            case .rateApp:
                AppHelper.rateApp { (done) in
                }
            case .contactUs:
                router.browser(url: Utils.url_contact)
                toggleLeft()
                //AppHelper.sendEmail(vc: self, message: "")
            case .shareApp:
                AppHelper.shareApp(vc: self)
            case .privacy:
                router.browser(url: Utils.url_privacy)
                toggleLeft()
            case .logout:
                router.auth()
                toggleLeft()
        }
    }
    
    
    @IBAction func logMe(_ sender: Any) {
        self.showIndicator()
        
    }
    
}

extension LeftViewController: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
