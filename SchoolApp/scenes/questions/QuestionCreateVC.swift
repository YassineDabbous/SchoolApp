//
//  QuestionCreateVC.swift
//  SchoolApp
//
//  Created by X on 7/15/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit
import Alamofire

class QuestionCreateVC: BaseViewController {

    lazy var router:MainRoutable = MainRoutable(viewController: self)
    
    var titleInput:UITextField!
    var descriptionInput:UITextView!
    var attachementLabel:LabelBold!
    var answerBtn:UIButton!
    var iv : UIImageView!
    var attachementStack : UIStackView!
    
    override func loadView() {
        super.loadView()
        
        supportAds = false
        
        drawMainView()
        
        let titleView = LabelBold()
        let descriptionView = LabelBold()
        attachementLabel = LabelBold()
        let attachementImgView = UIImageView(image: UIImage(named: "file-image-outline"))
        titleInput = Input()
        descriptionInput = TextArea()
        answerBtn = BtnPrimary(frame: .zero)
        iv = UIImageView(image: UIImage(named: "image-outline"))
        
        view.addSubview(titleView)
        view.addSubview(descriptionView)
        view.addSubview(titleInput)
        view.addSubview(descriptionInput)
        view.addSubview(attachementLabel)
        view.addSubview(attachementImgView)
        view.addSubview(answerBtn)
        view.addSubview(iv)
        
        
        titleInput.placeholder = .localized(.Title)
        titleView.text = .localized(.QuestionTitle)
        descriptionView.text = .localized(.QuestionDescription)
        attachementLabel.text = .localized(.AddAttachement)
        answerBtn.setTitle(.localized(.Save), for: .normal)
        
        
        titleView.anchor(top: main.topAnchor, leading: main.leadingAnchor, trailing: main.trailingAnchor)
        titleInput.toBottom(of: titleView, marginTop: 5)
        
        descriptionView.toBottom(of: titleInput, marginTop: 10)
        descriptionInput.toBottom(of: descriptionView, height: 150, marginTop: 5)
        
        
        attachementStack = UIStackView(arrangedSubviews: [attachementImgView, attachementLabel])
        attachementStack.axis = .horizontal
        attachementStack.spacing = 5
        attachementStack.backgroundColor = .white
        view.addSubview(attachementStack)
        
        attachementImgView.anchor(size: CGSize(width: 24, height: 24))
        attachementStack.toBottom(of: descriptionInput, height: 30, marginTop: 10)
        attachementStack.makeDashedBorderLine()
        
        answerBtn.anchor(leading: main.leadingAnchor, bottom:main.bottomAnchor, trailing: main.trailingAnchor)
        
        
        iv.anchor(top: attachementStack.bottomAnchor, leading: main.leadingAnchor, bottom:answerBtn.topAnchor, trailing: main.trailingAnchor)
        
        
        
    }
    
    var imagePicker: ImagePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = .localized(.AddQuestion)
        answerBtn.addTarget(self, action: #selector(saveMe), for: .touchUpInside)
        let tapAttachment = UITapGestureRecognizer(target: self, action: #selector(pick))
        attachementStack.addGestureRecognizer(tapAttachment)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    @objc func pick(){
        self.imagePicker.present(from: attachementStack)
    }
    @objc func saveMe(){
        let me = UserDefaults.Account.auth()?.id ?? 0
        let t = descriptionInput.text ?? ""
        var imgSrc = ""
        if let attachementURL = attachementURL {
            imgSrc = "<img src=\"\(attachementURL)\" />"
        }
        let d = "\(t) \(imgSrc)"
        perform(APIClient.ask(request: QuestionRequest(title: titleInput.text, description: d, parent: "", uid: "\(me)"))){ success, data in
            if success {
                if let d = data {
                    Alerts.showAlert(vc: self, title: .localized(.done), message: "") {
                        self.router.question(question: d)
                    }
                } else {
                    self.router.questions()
                }
            }
        }
    }
    
    
    var progressView:UIProgressView!
    var alertView : UIAlertController!
    var attachementURL:String?
}


extension QuestionCreateVC: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.iv.image = image
        showProgress()
        upload(image: image!.pngData()!, to: PostsEndpoint.uploadFiles,
               params: [:],
               progressClosure: { (progress) in
                    print("Upload image Progress: \(progress.fractionCompleted)")
                    if self.progressView != nil {
                        print("update progressview")
                        //self.progressView!.progress = Float(progress.fractionCompleted)
                        self.progressView!.setProgress(Float(progress.fractionCompleted), animated: true)
                    }
               },
               completionClosure: { (response) in
                    print("final response", response)
                    self.alertView.dismissMe()
                    switch response.result {
                        case .success(let JSON):
                            print("Success with JSON: \(JSON)")
                            
                            let response = JSON as! NSDictionary
                            
                            //example if there is an id
                            self.attachementURL = response.object(forKey: "url")! as! String
                            self.attachementLabel.text = "Attachement Added!"
                        
                        case .failure(let error):
                            print("Request failed with error: \(error)")
                            Alerts.showAlert(vc: self, title: .localized(.Error), message: "Request failed with error: \(error)") {
                                
                            }
                    }
               }
        )
    }
    func showProgress(){
        //  Just create your alert as usual:
        alertView = UIAlertController(title: .localized(.msgWait), message: .localized(.UploadingFile), preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: .localized(.Cancel), style: .cancel, handler: nil))
        
        //  Show it to your users
        present(alertView, animated: true, completion: {
            //  Add your progressbar after alert is shown (and measured)
            let margin:CGFloat = 8.0
            let rect = CGRect(x: margin, y: 72.0, width: self.alertView.view.frame.width - margin * 2.0 , height: 6.0)
            self.progressView = UIProgressView(frame: rect)
            self.progressView!.progress = 0.1
            self.progressView!.tintColor = self.view.tintColor
            self.progressView!.progressTintColor = Utils.appColor
            self.alertView.view.addSubview(self.progressView!)
        })
    }
}
