//
//  RightViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

class RightViewController : WithGenericTableView<LeftDrawerCell, MenuItem> {
    /*
    @IBOutlet weak var tableView: UITableView!
    var oldItems:[Category] = []
    var parentItem:Category?
    public var mainController:MainViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //headerTitle = "Mobily"
        headerTitle = Utils.app_name
        initTable(&tableView)
        perform(APIClient.getCategories()){ success, data in
            if let d = data {
                self.items = d
                self.oldItems = self.items!
            }
        }
        perform(APIClient.getPages()){ success, data in
            if let d = data {
                var itms = self.items ?? []
                for p in d {
                    itms.append(Category(id: p.getId(), name: p.title ?? "Page"))
                }
                self.items = itms
                self.oldItems = itms
                print("pages transformed to cats", self.items)
            }
        }
    }
    
    override func onInteract(_ indexPath: IndexPath, _ action: Action, _ model: Category?) {
        if model != nil {
            print(model?.name," -> ", action)
            if model!.isPage {
                page(id:model!.getId())
            } else {
                headerTitle = model!.name
                parentItem = model
                perform(APIClient.getCategory(id: (model!.getId()))){ success, data in
                    if let d = data {
                        if d.subCategories!.count > 0 {
                            self.items = d.subCategories ?? []
                            // or present a modal controlller with new table
                        }else {
                            //self.mainRouter.search()
                            //go to Filter
                            self.products(item: model!)
                        }
                        
                    }
                }
            }
        } else {
            if action == .back {
                headerTitle = Utils.app_name
                self.items = self.oldItems
            } else { // action == .header
                if let c = parentItem {
                    self.products(item: c)
                } else {
                    toggleRight()
                    print("no parent")
                }
            }
        }
    }
    
    
    func products(item:Category) {
        mainController?.routerMain.show(storyboard: .products, identifier: "ListProductsViewController") { (controller: ListProductsViewController) in
            controller.filter = FilterGroup()
            controller.filter?.addFilter(category: String(describing: item.getId()))
        }
        toggleRight()
    }
    func page(id:Int) {
        mainController?.routerMain.show(storyboard: .main, identifier: "BrowserViewController") { (controller: BrowserViewController) in
            controller.id = id
        }
        toggleRight()
    }
    
    */
}
