//
//  PageViewController.swift
//  MyApp
//
//  Created by X on 4/29/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

class BrowserViewController0: BaseViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var id : Int = 0
    private var htmlCode:String?   = "<form action=\"https://www.kpaytest.com.kw/kpg/PaymentHTTP.htm?param=paymentInit&trandata=48b909f87e18e67b7a471628cc364b911c122a6daf8e839ee72398f664a2fb516da85fe125fa0d35b0b9a39102bfd79f89444eacd4df2648272d6ed7abfd1e5e15e502dc55d622c5d492e36861f3b99f436760273c23b3c54244b04b449e49bee7d7331e23c8c9143d3b50c46fe997173ce91e56478574bfa600a57cae4ca26d67e2a52db83e4fbacd7b9cc305d4084f3899bfdf77a39126edd3363c1b3406e3dddecfb256c4f78f6f3043a7fa18597e5d4d36ed753dde51bf0262586c40d3cd872b4491416a20e8df40e4a3c5ba94436fcafbc091d5ec768f0d61773bd651759e57e99fe6e47869c932a5b6439d0a9618a01c43c463e72507a666a548d1b436e2b5b1d379d3a29db6991d2c113ca147&tranportalId=110401&responseURL=https://www.mobily.store/catalog/controller/extension/payment/tt.php&errorURL=http://www.approcx.com\" method=\"post\">\r\n <!--<input type=\"hidden\" name=\"ap_merchant\" value=\"<b>Notice</b>: Undefined variable: ap_merchant in <b>/home/mobily/public_html/catalog/view/theme/default/template/extension/payment/payza.tpl</b> on line <b>2</b>\" />\r\n <input type=\"hidden\" name=\"ap_amount\" value=\"<b>Notice</b>: Undefined variable: ap_amount in <b>/home/mobily/public_html/catalog/view/theme/default/template/extension/payment/payza.tpl</b> on line <b>3</b>\" />\r\n <input type=\"hidden\" name=\"ap_currency\" value=\"<b>Notice</b>: Undefined variable: ap_currency in <b>/home/mobily/public_html/catalog/view/theme/default/template/extension/payment/payza.tpl</b> on line <b>4</b>\" />\r\n <input type=\"hidden\" name=\"ap_purchasetype\" value=\"<b>Notice</b>: Undefined variable: ap_purchasetype in <b>/home/mobily/public_html/catalog/view/theme/default/template/extension/payment/payza.tpl</b> on line <b>5</b>\" />\r\n <input type=\"hidden\" name=\"ap_itemname\" value=\"<b>Notice</b>: Undefined variable: ap_itemname in <b>/home/mobily/public_html/catalog/view/theme/default/template/extension/payment/payza.tpl</b> on line <b>6</b>\" />\r\n <input type=\"hidden\" name=\"ap_itemcode\" value=\"<b>Notice</b>: Undefined variable: ap_itemcode in <b>/home/mobily/public_html/catalog/view/theme/default/template/extension/payment/payza.tpl</b> on line <b>7</b>\" />\r\n <input type=\"hidden\" name=\"ap_returnurl\" value=\"<b>Notice</b>: Undefined variable: ap_returnurl in <b>/home/mobily/public_html/catalog/view/theme/default/template/extension/payment/payza.tpl</b> on line <b>8</b>\" />\r\n <input type=\"hidden\" name=\"ap_cancelurl\" value=\"<b>Notice</b>: Undefined variable: ap_cancelurl in <b>/home/mobily/public_html/catalog/view/theme/default/template/extension/payment/payza.tpl</b> on line <b>9</b>\" />-->\r\n <div class=\"buttons\">\r\n <div class=\"pull-right\">\r\n <input type=\"submit\" value=\"Confirm Order\" class=\"btn btn-primary\" />\r\n </div>\r\n </div>\r\n</form>\r\n"
    
    func setHtml(_ newValue:String){
        var html = newValue
        html.removeAll{ $0 == "\r" }
        html.removeAll{ $0 == "\n" }
        html.removeAll{ $0 == "\\" }
        print("webview will load =>",html)
        //
        //htmlCode = "<html><head><title>Wonderful web</title></head> <body>\(html)</body>"
        htmlCode = "<html> <head><link href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS\" crossorigin=\"anonymous\"></head> <body> <script src=\'https://code.jquery.com/jquery-3.3.1.js\'></script>  <center style=\"margin-top:100px\"> \(html) </center> </body> </html>"
        // test code <form action=\"https://www.google.com\" method=\"post\"> <input type=\"submit\" value=\"test\" class=\"btn btn-primary\" /> </form> 
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if htmlCode == nil {
            /*perform(APIClient.getPage(id: id)){ success, data in
                if success {
                    ///self.htmlCode = "<html><head><title>Wonderful web</title></head> <body>\(data!.descriptionField!.html().string)</body>"
                    self.setHtml(data!.descriptionField!.html().string)
                    self.run()
                }
            }*/
        } else {
            run()
        }
        
    }
    
    func run(){
        var url = URL(string: "https://www.mobily.store")
        self.webView.loadHTMLString(htmlCode!, baseURL: url)
    }

}
