//
//  DescriptiveProtocol.swift
//  MyApp
//
//  Created by X on 4/20/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation

protocol DescriptiveProtocol {
    var descriptor: CellDescriptor { get }
}

extension String : DescriptiveProtocol {
    var descriptor: CellDescriptor {
        let cellDescriptor = CellDescriptor { (cell: DropDownCell) in
            cell.item = self
        }
        return cellDescriptor
    }
}
/*
extension Address : DescriptiveProtocol {
    var descriptor: CellDescriptor {
        let cellDescriptor = CellDescriptor { (cell: DropDownCell) in
            cell.item = self.address1
        }
        return cellDescriptor
    }
}
extension PaymentMethod : DescriptiveProtocol {
    var descriptor: CellDescriptor {
        let cellDescriptor = CellDescriptor { (cell: DropDownCell) in
            cell.item = self.title ?? ""
        }
        return cellDescriptor
    }
}
extension ShippingMethod : DescriptiveProtocol {
    var descriptor: CellDescriptor {
        let cellDescriptor = CellDescriptor { (cell: DropDownCell) in
            let c = self.quote!.first!.value.cost!.getData() // ?? IntString.string("")
            cell.item = "\(self.title ?? "") ( \(c) )"
        }
        return cellDescriptor
    }
}
extension OrderBy : DescriptiveProtocol {
    var descriptor: CellDescriptor {
        let cellDescriptor = CellDescriptor { (cell: DropDownCell) in
            cell.item = self.title
        }
        return cellDescriptor
    }
}
extension Category : DescriptiveProtocol {
    var descriptor: CellDescriptor {
        let cellDescriptor = CellDescriptor { (cell: DropDownCell) in
            cell.item = self.name
        }
        return cellDescriptor
    }
}
extension Manufacturer : DescriptiveProtocol {
    var descriptor: CellDescriptor {
        let cellDescriptor = CellDescriptor { (cell: DropDownCell) in
            cell.item = self.name
        }
        return cellDescriptor
    }
}
extension StockStatus : DescriptiveProtocol {
    var descriptor: CellDescriptor {
        let cellDescriptor = CellDescriptor { (cell: DropDownCell) in
            cell.item = self.name
        }
        return cellDescriptor
    }
}
*/
