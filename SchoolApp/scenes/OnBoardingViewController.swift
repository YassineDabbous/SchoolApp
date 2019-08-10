//
//  OnBoardingViewController.swift
//  SchoolApp
//
//  Created by X on 8/10/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit
import SwiftyOnboard

class OnBoardingViewController: BaseViewController {
    var swiftyOnboard: SwiftyOnboard!
    
    
    override func loadView() {
        super.loadView()
        drawMainView()
        swiftyOnboard = SwiftyOnboard(frame: .zero)
        main.addSubview(swiftyOnboard)
        swiftyOnboard.fill(parent: main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swiftyOnboard.style = .light
        swiftyOnboard.delegate = self
        swiftyOnboard.dataSource = self
        swiftyOnboard.backgroundColor = UIColor(red: 46/256, green: 46/256, blue: 76/256, alpha: 1)
    }
    
    @objc func handleSkip() {
        swiftyOnboard?.goToPage(index: 2, animated: true)
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = sender.tag
        swiftyOnboard?.goToPage(index: index + 1, animated: true)
    }
    @objc func getStarted(sender: UIButton) {
        UserDefaults.Configs.onboarding(true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setDrawerMenu()
    }
}
extension OnBoardingViewController: SwiftyOnboardDelegate, SwiftyOnboardDataSource {
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        return 3
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let view = SwiftyOnboardPage()
        view.imageView.image = UIImage(named: "app-logo")
        if index == 0 {
            //On the first page, change the text in the labels to say the following:
            view.title.text = "Planet earth is extraordinary"
            view.subTitle.text = "Earth, otherwise known as the World, is the third planet from the Sun."
        } else if index == 1 {
            //On the second page, change the text in the labels to say the following:
            view.title.text = "The mystery of\n outer space"
            view.subTitle.text = "Outer space or just space, is the void that exists between celestial bodies, including Earth."
        } else {
            //On the thrid page, change the text in the labels to say the following:
            view.title.text = "Extraterrestrial\n life"
            view.subTitle.text = "Extraterrestrial life, also called alien life, is life that does not originate from Earth."
        }
        return view
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay() //CustomOverlay.instanceFromNib() as? CustomOverlay
        overlay.skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        return overlay
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        //let overlay = overlay as! CustomOverlay
        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        overlay.continueButton.tag = Int(position)
        if currentPage == 0.0 || currentPage == 1.0 {
            overlay.continueButton.setTitle("Continue", for: .normal)
            overlay.skipButton.setTitle("Skip", for: .normal)
            overlay.skipButton.isHidden = false
        } else {
            overlay.continueButton.setTitle("Get Started!", for: .normal)
            overlay.continueButton.addTarget(self, action: #selector(getStarted), for: .touchUpInside)
            overlay.skipButton.isHidden = true
        }
    }
    
    
}
