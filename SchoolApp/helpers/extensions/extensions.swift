//
//  extensions.swift
//  machrou3kom
//
//  Created by yassine dabbous on 5/3/18.
//  Copyright © 2018 yassine dabbous. All rights reserved.
//

import UIKit



extension NSObject {
    var theClassName: String {
        return NSStringFromClass(type(of: self))
    }
}

extension Date {
    var timestamp:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())	
    }
    
    init(seconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(seconds / 1000))
    }
    
    func addHours(hours:Int) -> Date {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .hour, value: hours, to: self)
        return date! //self.addingTimeInterval(Double(hours) * 3600.0)
    }
}
