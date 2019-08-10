//
//  ReusableView.swift
//  MyApp
//
//  Created by X on 4/18/19.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit
protocol Reusable {
}
protocol ReusableView{
    associatedtype T
    var item:T? { get set }
    var onAction:((T?, Action) -> ())? { get set }
    func loadMe(_ wrapper:UIView)
    func bind()
}
extension ReusableView where Self:UIView {
}
/// MARK: - UITableView

extension Reusable { // for UITableViewCell, UICollectionViewCell ...
    static var nibName: String {
        print("%%% self -------------------------------------------> ", self )
        print("%%% String(describing: self) -----------> ", String(describing: self))
        print("%%% String(describing: type(of: self)) -----------> ",String(describing: type(of: self)))
        return String(describing: self)
    }
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIView: Reusable {}
extension UITableView {
    
    func register<T: UITableViewCell>(_ :T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not deque cell with identifier")
        }
        return cell
    }
}
