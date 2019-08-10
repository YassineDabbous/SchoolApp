//
//  AppLocalizable.swift
//  MyApp
//
//  Created by X on 5/22/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation
// MARK: - Main Scene
extension Localizable {
    static let app_name = Localizable(NSLocalizedString("app_name", comment: ""))
}
// for LeftDrawer
extension Localizable {
    static let editProfile = Localizable(NSLocalizedString("Edit Profile", comment: ""))
    static let changePassword = Localizable(NSLocalizedString("Change Password", comment: ""))
    static let myOrders = Localizable(NSLocalizedString("My Orders", comment: ""))
    static let myAddresses = Localizable(NSLocalizedString("My Addresses", comment: ""))
    static let wishlist = Localizable(NSLocalizedString("Wishlist", comment: ""))
}

// for order
extension Localizable {
    
    static let Newest = Localizable(NSLocalizedString("Newest", comment: ""))
    static let Recommended = Localizable(NSLocalizedString("Recommended", comment: ""))
    static let HighestPrice = Localizable(NSLocalizedString("Highest price", comment: ""))
    static let LowestPrice = Localizable(NSLocalizedString("Lowest price", comment: ""))
}

// MARK: - Tutorial
extension Localizable {
    static let Edit = Localizable(NSLocalizedString("Edit", comment: ""))
    
    static let Quantity = Localizable(NSLocalizedString("Quantity", comment: ""))
    static let available = Localizable(NSLocalizedString("available", comment: ""))
    
    static let Alert = Localizable(NSLocalizedString("Alert", comment: ""))
    static let Error = Localizable(NSLocalizedString("Error", comment: ""))
    static let msgConfirmation = Localizable(NSLocalizedString("Are you sure?", comment: ""))
    static let msgWait = Localizable(NSLocalizedString("Please wait...", comment: ""))
    
    static let FetchingNewData = Localizable(NSLocalizedString("Fetching New Data ...", comment: "Fetching New Data ..."))
    static let EmptyData = Localizable(NSLocalizedString("No Data, pull down to refresh or try again later", comment: "No Data, pull down to refresh or try again later"))
    
    static let payAlertMsg = Localizable(NSLocalizedString("pay now or later", comment: ""))
    static let payNow = Localizable(NSLocalizedString("Pay Now", comment: ""))
    static let onDelivery = Localizable(NSLocalizedString("On Delivery", comment: ""))
    
    // for lists
    static let selectCategory = Localizable(NSLocalizedString("Select a category", comment: ""))
    static let selectManufacturer = Localizable(NSLocalizedString("Select a manufacturer", comment: ""))
    static let selectStockStatus = Localizable(NSLocalizedString("Select stock status", comment: ""))
    static let selectOrder = Localizable(NSLocalizedString("Select Order", comment: ""))
    static let selectShipping = Localizable(NSLocalizedString("Select Shipping Method", comment: ""))
    static let selectPayment = Localizable(NSLocalizedString("Select Payment Method", comment: ""))
    static let selectAddress = Localizable(NSLocalizedString("Select Payment Address", comment: ""))
    
    
    // others
    static let products = Localizable(NSLocalizedString("products", comment: ""))
    static let pcs = Localizable(NSLocalizedString("pcs", comment: ""))
    
    static let ok = Localizable(NSLocalizedString("ok", comment: ""))
    static let none = Localizable(NSLocalizedString("none", comment: ""))
    static let done = Localizable(NSLocalizedString("done", comment: ""))
    
    
    static let goToCart = Localizable(NSLocalizedString("goToCart", comment: ""))
    
}
