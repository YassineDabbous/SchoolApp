//
//  Routable.swift
//  Swift Clean Architecture
//
//  Taken from: https://github.com/ZamzamInc/ZamzamKit/blob/master/Sources/Protocols/iOS/Routable.swift
//
//  Created by Basem Emara on 2018-04-20.
//  Copyright © 2018 Basem Emara. All rights reserved.
//

import UIKit
import SafariServices

public protocol Routable {
    associatedtype StoryboardIdentifier: RawRepresentable
    
    func present<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: String?, animated: Bool, modalPresentationStyle: UIModalPresentationStyle?, modalTransitionStyle: UIModalTransitionStyle?, configure: ((T) -> Void)?, completion: ((T) -> Void)?)
    func show<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: String?, configure: ((T) -> Void)?)
    func showDetailViewController<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: String?, configure: ((T) -> Void)?)
}

public extension Routable where Self: UIViewController, StoryboardIdentifier.RawValue == String {
    
    /**
     Presents the intial view controller of the specified storyboard modally.
     
     - parameter storyboard: Storyboard name.
     - parameter identifier: View controller name.
     - parameter configure: Configure the view controller before it is loaded.
     - parameter completion: Completion the view controller after it is loaded.
     */
    func present<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: String? = nil, animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle? = nil, modalTransitionStyle: UIModalTransitionStyle? = nil, configure: ((T) -> Void)? = nil, completion: ((T) -> Void)? = nil) {
        RoutingLogic.present(delegate: self, storyboard: storyboard.rawValue, identifier: identifier, animated: animated, modalPresentationStyle: modalPresentationStyle, modalTransitionStyle: modalTransitionStyle, configure: configure, completion: completion)
    }
    
    /**
     Present the intial view controller of the specified storyboard in the primary context.
     Set the initial view controller in the target storyboard or specify the identifier.
     
     - parameter storyboard: Storyboard name.
     - parameter identifier: View controller name.
     - parameter configure: Configure the view controller before it is loaded.
     */
    func show<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: String? = nil, configure: ((T) -> Void)? = nil) {
        RoutingLogic.show(delegate: self, storyboard: storyboard.rawValue, identifier: identifier, configure: configure)
    }
    
    /**
     Present the intial view controller of the specified storyboard in the secondary (or detail) context.
     Set the initial view controller in the target storyboard or specify the identifier.
     
     - parameter storyboard: Storyboard name.
     - parameter identifier: View controller name.
     - parameter configure: Configure the view controller before it is loaded.
     */
    func showDetailViewController<T: UIViewController>(storyboard: StoryboardIdentifier, identifier: String? = nil, configure: ((T) -> Void)? = nil) {
        RoutingLogic.showDetailViewController(delegate: self, storyboard: storyboard.rawValue, identifier: identifier, configure: configure)
    }
}

public protocol Router {
    var viewController: UIViewController? { get set }
    
    func present<T: UIViewController>(storyboard: String, identifier: String?, animated: Bool, modalPresentationStyle: UIModalPresentationStyle?, modalTransitionStyle: UIModalTransitionStyle?, configure: ((T) -> Void)?, completion: ((T) -> Void)?)
    func show<T: UIViewController>(storyboard: String, identifier: String?, configure: ((T) -> Void)?)
    func showDetailViewController<T: UIViewController>(storyboard: String, identifier: String?, configure: ((T) -> Void)?)
    
    //NoStoryboard
    func show<T: UIViewController>(destination:T, configure: ((T) -> Void)?)
    func showDetailViewController<T: UIViewController>(destination:T, configure: ((T) -> Void)?)
}



// No Storyboard
public extension Router {
    /**
     Present a view controller without using a storyboard
     
     - parameter destination: UIViewController instance.
     - parameter configure: Configure the view controller before it is loaded.
     */
    func show<T: UIViewController>(destination:T, configure: ((T) -> Void)?){
        guard let viewController = viewController else { return }
        RoutingLogic.show(delegate: viewController, destination: destination, configure: configure)
    }
    func showDetailViewController<T: UIViewController>(destination:T, configure: ((T) -> Void)?){
        guard let viewController = viewController else { return }
        RoutingLogic.showDetailViewController(delegate: viewController, destination: destination, configure: configure)
    }
    func present<T: UIViewController>(destination: T, animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle? = nil, modalTransitionStyle: UIModalTransitionStyle? = nil, configure: ((T) -> Void)? = nil, completion: ((T) -> Void)? = nil) {
        guard let viewController = viewController else { return }
        RoutingLogic.present(delegate: viewController, destination: destination, animated: animated, modalPresentationStyle: modalPresentationStyle, modalTransitionStyle: modalTransitionStyle, configure: configure, completion: completion)
    }
}

// With Storyboard
public extension Router {
    
    
    /**
     Presents the intial view controller of the specified storyboard modally.
     
     - parameter storyboard: Storyboard name.
     - parameter identifier: View controller name.
     - parameter configure: Configure the view controller before it is loaded.
     - parameter completion: Completion the view controller after it is loaded.
     */
    func present<T: UIViewController>(storyboard: String, identifier: String? = nil, animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle? = nil, modalTransitionStyle: UIModalTransitionStyle? = nil, configure: ((T) -> Void)? = nil, completion: ((T) -> Void)? = nil) {
        guard let viewController = viewController else { return }
        RoutingLogic.present(delegate: viewController, storyboard: storyboard, identifier: identifier, animated: animated, modalPresentationStyle: modalPresentationStyle, modalTransitionStyle: modalTransitionStyle, configure: configure, completion: completion)
    }
    
    /**
     Present the intial view controller of the specified storyboard in the primary context.
     Set the initial view controller in the target storyboard or specify the identifier.
     
     - parameter storyboard: Storyboard name.
     - parameter identifier: View controller name.
     - parameter configure: Configure the view controller before it is loaded.
     */
    func show<T: UIViewController>(storyboard: String, identifier: String? = nil, configure: ((T) -> Void)? = nil) {
        guard let viewController = viewController else { return }
        RoutingLogic.show(delegate: viewController, storyboard: storyboard, identifier: identifier, configure: configure)
    }
    
    /**
     Present the intial view controller of the specified storyboard in the secondary (or detail) context.
     Set the initial view controller in the target storyboard or specify the identifier.
     
     - parameter storyboard: Storyboard name.
     - parameter identifier: View controller name.
     - parameter configure: Configure the view controller before it is loaded.
     */
    func showDetailViewController<T: UIViewController>(storyboard: String, identifier: String? = nil, configure: ((T) -> Void)? = nil) {
        guard let viewController = viewController else { return }
        RoutingLogic.showDetailViewController(delegate: viewController, storyboard: storyboard, identifier: identifier, configure: configure)
    }
}

public extension Router {
    
    /**
     Open Safari view controller overlay.
     
     - parameter url: URL to display in the browser.
     - parameter modalPresentationStyle: The presentation style of the model view controller.
     */
    func present(safari url: String, modalPresentationStyle: UIModalPresentationStyle = .overFullScreen, animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let viewController = viewController else { return }
        
        let safariController = SFSafariViewController(url: URL(string: url)!)
        safariController.modalPresentationStyle = modalPresentationStyle
        
        viewController.present(safariController, animated: animated, completion: completion)
    }
}

// MARK: - Private functions

fileprivate enum RoutingLogic {
    
    static func present<T: UIViewController>(delegate: UIViewController, storyboard: String, identifier: String? = nil, animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle? = nil, modalTransitionStyle: UIModalTransitionStyle? = nil, configure: ((T) -> Void)? = nil, completion: ((T) -> Void)? = nil) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        guard let controller = (identifier != nil
            ? storyboard.instantiateViewController(withIdentifier: identifier!)
            : storyboard.instantiateInitialViewController()) as? T
            else { return assertionFailure("Invalid controller for storyboard \(storyboard).") }
        
        present(delegate: delegate, destination: controller, animated: animated, modalPresentationStyle: modalPresentationStyle, modalTransitionStyle:modalTransitionStyle , configure: configure, completion: completion)
    }
    
    static func show<T: UIViewController>(delegate: UIViewController, storyboard: String, identifier: String? = nil, configure: ((T) -> Void)? = nil) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        guard let controller = (identifier != nil
            ? storyboard.instantiateViewController(withIdentifier: identifier!)
            : storyboard.instantiateInitialViewController()) as? T
            else { return assertionFailure("Invalid controller for storyboard \(storyboard).") }
        
        show(delegate: delegate, destination: controller, configure:configure)
    }
    
    static func showDetailViewController<T: UIViewController>(delegate: UIViewController, storyboard: String, identifier: String? = nil, configure: ((T) -> Void)? = nil) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        guard let controller = (identifier != nil
            ? storyboard.instantiateViewController(withIdentifier: identifier!)
            : storyboard.instantiateInitialViewController()) as? T
            else { return assertionFailure("Invalid controller for storyboard \(storyboard).") }
        
        showDetailViewController(delegate: delegate, destination: controller, configure:configure)
    }
    
    
    
    
    static func show<T: UIViewController>(delegate: UIViewController, destination: T, configure: ((T) -> Void)? = nil) {
        configure?(destination)
        delegate.show(destination, sender: delegate)
    }
    static func showDetailViewController<T: UIViewController>(delegate: UIViewController, destination: T, configure: ((T) -> Void)? = nil) {
        configure?(destination)
        delegate.showDetailViewController(destination, sender: delegate)
    }
    static func present<T: UIViewController>(delegate: UIViewController, destination: T, animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle? = nil, modalTransitionStyle: UIModalTransitionStyle? = nil, configure: ((T) -> Void)? = nil, completion: ((T) -> Void)? = nil) {
        
        if let modalPresentationStyle = modalPresentationStyle {
            destination.modalPresentationStyle = modalPresentationStyle
        }
        
        if let modalTransitionStyle = modalTransitionStyle {
            destination.modalTransitionStyle = modalTransitionStyle
        }
        
        configure?(destination)
        
        delegate.present(destination, animated: animated) {
            completion?(destination)
        }
    }
    
}
