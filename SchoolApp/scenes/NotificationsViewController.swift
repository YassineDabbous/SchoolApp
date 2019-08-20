//
//  NotificationsViewController.swift
//  KuwaitSchool
//
//  Created by yassine dabbous on 7/15/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit
import GoogleMobileAds

class NotificationsViewController: WithGenericTableView<NotificationCell, YNotification> {
    
    let fetcher:Fetcher = Fetcher()
    
    
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
        
        navigationItem.title = .localized(.Notifications)
        
        initTable(&tableView, 60)
        
        
        refreshData()
        
    }
    
    
    override func refreshData() {
        self.perform(APIClient.getNotifications()){ success, data in
            if let d = data {
                self.items = d
            }
        }
    }
    
}
/*
extension NotificationsViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let s = self.items.count
        return s + (s / Utils.ads_after)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= Utils.ads_after && (indexPath.row % Utils.ads_after) == 0 {
            return tableView.getAdmobCell(root: self)
        }else{
            var position = indexPath.row
            if position >= Utils.ads_after {
                position = position - (position/Utils.ads_after)
            }
            let cell:NotificationCell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
            let item = self.items[position]
            cell.backgroundColor = UIColor.clear
            cell.titleView.text = item.message
            cell.typeView.text = item.type
            cell.timeView.text = item.time
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = tableView.dequeueReusableCell(withIdentifier: "BannersViewForTable") as! BannersViewForTable
        if UserDefaults.standard.bool(forKey: "admob_activation") && CategororiesViewController.ads.count == 2 {
            let url = URL(string: CategororiesViewController.ads[0].image)
            v.image1.kf.setImage(with: url)
            let url2 = URL(string: CategororiesViewController.ads[1].image)
            v.image2.kf.setImage(with: url2)
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.TapFirstBanner))
            let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.TapSecondBanner))
            v.card1.addGestureRecognizer(tap)
            v.card1.isUserInteractionEnabled = true
            v.card2.addGestureRecognizer(tap2)
            v.card2.isUserInteractionEnabled = true
            v.bind()
        }else{
            v.isHidden = true
        }
        return v
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if UserDefaults.standard.bool(forKey: "admob_activation") && CategororiesViewController.ads.count == 2 {
            return 100
        }else{
            return 0
        }
    }
    
    
    @objc private func TapFirstBanner() {
        increase()
        UIApplication.shared.open(URL(string : CategororiesViewController.ads[0].url)!, options: [:], completionHandler: { (status) in
            print("opened in browser")
        })
    }
    @objc private func TapSecondBanner() {
        increase()
        UIApplication.shared.open(URL(string : CategororiesViewController.ads[1].url)!, options: [:], completionHandler: { (status) in
            print("opened in browser")
        })
    }
    
}

*/
