import Foundation











public struct CleanProduct {
    public var rating: Int
    public var special: Int
    public let id: Int
    public let name: String
    public let description: String
    public let productOptions: [ProductOption]
    public let images: [String]
    public let image: String
    public let price: Int
    public static func fromDirty(item:Product) -> CleanProduct{
        
        let options:[Option] = item.options
        var cleanOptionsValues:[ProductOption] = []
        for option in options {
            var cleanValues: [ProductOptionValue] = []
            for ov in option.optionValue {
                var prc:String {
                    switch ov.priceFormated {
                    case .integer(let v):
                        return "\(v)"
                    case .string(let v):
                        return "\(v)"
                    }
                }
                cleanValues.append(ProductOptionValue(id: ov.productOptionValueID, name: ov.name,
                                                      image: ov.image,
                                                      price: prc))
            }
            
            cleanOptionsValues.append(ProductOption(
                type: option.productOptionID==251 ? .color : .comment,
                id: option.productOptionID,
                name: option.name,
                values: cleanValues,
                required: option.optionRequired=="1" ? true : false
            ))
        }
        var desc = ""
        for ag in item.attributeGroups {
            for at in ag.attribute {
                desc.append("\n \(at.name)")
                desc.append("\n \(at.text)")
            }
        }
        if !item.description.isEmpty {
            desc.append("\n \(item.description)")
        }
        if !item.model.isEmpty {
            desc.append("\n model: \(item.model)")
        }
        if !item.manufacturer.isEmpty {
            desc.append("\n manufacturer: \(item.manufacturer)")
        }
        if !item.specialStartDate.isEmpty {
            desc.append("\n special Start Date: \(item.specialStartDate)")
        }
        if !item.specialEndDate.isEmpty {
            desc.append("\n special End Date: \(item.specialEndDate)")
        }
        if !item.minimum.isEmpty {
            desc.append("\n minimum: \(item.minimum)")
        }
        if !item.stockStatus.isEmpty {
            desc.append("\n stock status: \(item.stockStatus)")
        }
        if item.quantity > 0{
            desc.append("\n quantity: \(item.quantity)")
        }
        let p = CleanProduct(
            rating: item.rating,
            special: item.special,
            id: item.id,
            name: item.name,
            description: desc,
            productOptions: cleanOptionsValues,
            images: item.images,
            image: item.image,
            price: item.price
        )
        return p
    }
}
enum OptionType{
    case color
    case comment
}
public struct ProductOption {
    let type: OptionType
    let id: Int
    let name: String
    let values: [ProductOptionValue]
    let required: Bool
}
public struct ProductOptionValue {
    let id: Int
    let name: String
    let image: String
    let price: String
}


//-------------------------------------------------------------------------------------
public struct Product: Codable {
    let id, productID: Int
    let name, manufacturer, sku, model: String
    let image: String
    let images: [String]
    let originalImage: String
    let originalImages: [String]
    let priceExcludingTax: Int
    let priceExcludingTaxFormated: String
    let price: Int
    let priceFormated: String
    let rating: Int
    let description: String
    let attributeGroups: [AttributeGroup]
    let special: Int
    let specialFormated: String
    let specialExcludingTax: Int
    let specialExcludingTaxFormated, specialStartDate, specialEndDate: String
    let discounts: [JSONAny]
    let options: [Option]
    let minimum, metaTitle, metaDescription, metaKeyword: String
    let tag, upc, ean, jan: String
    let isbn, mpn, location, stockStatus: String
    let stockStatusID, manufacturerID, taxClassID: Int
    let dateAvailable, weight: String
    let weightClassID: Int
    let length, width, height: String
    let lengthClassID: Int
    let subtract: String
    let sortOrder: Int
    let status, dateAdded, dateModified, viewed: String
    let weightClass, lengthClass, shipping: String
    let reward: JSONNull?
    let points: String
    let category: [Category]
    let quantity: Int
    let reviews: Reviews
    let recurrings: [JSONAny]
    
    public enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case name, manufacturer, sku, model, image, images
        case originalImage = "original_image"
        case originalImages = "original_images"
        case priceExcludingTax = "price_excluding_tax"
        case priceExcludingTaxFormated = "price_excluding_tax_formated"
        case price
        case priceFormated = "price_formated"
        case rating, description
        case attributeGroups = "attribute_groups"
        case special
        case specialFormated = "special_formated"
        case specialExcludingTax = "special_excluding_tax"
        case specialExcludingTaxFormated = "special_excluding_tax_formated"
        case specialStartDate = "special_start_date"
        case specialEndDate = "special_end_date"
        case discounts, options, minimum
        case metaTitle = "meta_title"
        case metaDescription = "meta_description"
        case metaKeyword = "meta_keyword"
        case tag, upc, ean, jan, isbn, mpn, location
        case stockStatus = "stock_status"
        case stockStatusID = "stock_status_id"
        case manufacturerID = "manufacturer_id"
        case taxClassID = "tax_class_id"
        case dateAvailable = "date_available"
        case weight
        case weightClassID = "weight_class_id"
        case length, width, height
        case lengthClassID = "length_class_id"
        case subtract
        case sortOrder = "sort_order"
        case status
        case dateAdded = "date_added"
        case dateModified = "date_modified"
        case viewed
        case weightClass = "weight_class"
        case lengthClass = "length_class"
        case shipping, reward, points, category, quantity, reviews, recurrings
    }
}

public struct AttributeGroup: Codable {
    let attributeGroupID, name: String
    let attribute: [Attribute]
    
    public enum CodingKeys: String, CodingKey {
        case attributeGroupID = "attribute_group_id"
        case name, attribute
    }
}

public struct Attribute: Codable {
    let attributeID, name, text: String
    
    public enum CodingKeys: String, CodingKey {
        case attributeID = "attribute_id"
        case name, text
    }
}

public struct Category: Codable {
    let name: String
    let id: Int
}

public struct Option: Codable {
    let productOptionID: Int
    let optionValue: [OptionValue]
    let optionID: Int
    let name, type, value, optionRequired: String
    
    public enum CodingKeys: String, CodingKey {
        case productOptionID = "product_option_id"
        case optionValue = "option_value"
        case optionID = "option_id"
        case name, type, value
        case optionRequired = "required"
    }
}

public struct OptionValue: Codable {
    let image: String
    let price: Double
    let priceFormated: PriceFormated
    let priceExcludingTax: Double
    let priceExcludingTaxFormated: PriceFormated
    let pricePrefix: String
    let productOptionValueID, optionValueID: Int
    let name, quantity: String
    
    public enum CodingKeys: String, CodingKey {
        case image, price
        case priceFormated = "price_formated"
        case priceExcludingTax = "price_excluding_tax"
        case priceExcludingTaxFormated = "price_excluding_tax_formated"
        case pricePrefix = "price_prefix"
        case productOptionValueID = "product_option_value_id"
        case optionValueID = "option_value_id"
        case name, quantity
    }
}

public enum PriceFormated: Codable {
    case integer(Int)
    case string(String)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(PriceFormated.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for PriceFormated"))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

public struct Reviews: Codable {
    let reviewTotal: String
    
    public enum CodingKeys: String, CodingKey {
        case reviewTotal = "review_total"
    }
}

// MARK: Encode/decode helpers

public class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

public class JSONCodingKey: CodingKey {
    let key: String
    
    public required init?(intValue: Int) {
        return nil
    }
    
    public required init?(stringValue: String) {
        key = stringValue
    }
    
    public var intValue: Int? {
        return nil
    }
    
    public var stringValue: String {
        return key
    }
}

public class JSONAny: Codable {
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
