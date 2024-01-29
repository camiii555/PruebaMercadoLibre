//
//  ProductListModel.swift
//  PruebaMercadoLibre
//
//  Created by Juan Camilo Mejia  on 28/01/24.
//

import Foundation

// MARK: - ProductListModel
struct ProductListModel: Codable {
    let siteID: String?
    let countryDefaultTimeZone, query: String?
    let paging: Paging?
    let results: [Result]?
    let sort: Sort?
    let availableSorts: [Sort]?
    let filters: [Filter]?
    let availableFilters: [AvailableFilter]?
    let pdpTracking: PDPTracking?

    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case countryDefaultTimeZone = "country_default_time_zone"
        case query, paging, results, sort
        case availableSorts = "available_sorts"
        case filters
        case availableFilters = "available_filters"
        case pdpTracking = "pdp_tracking"
    }
}

// MARK: - AvailableFilter
struct AvailableFilter: Codable {
    let id, name: String?
    let type: TypeEnum?
    let values: [AvailableFilterValue]?
}

enum TypeEnum: String, Codable {
    case boolean = "boolean"
    case list = "list"
    case number = "number"
    case range = "range"
    case string = "STRING"
    case text = "text"
}

// MARK: - AvailableFilterValue
struct AvailableFilterValue: Codable {
    let id, name: String?
    let results: Int?
}

// MARK: - Sort
struct Sort: Codable {
    let id, name: String?
}

// MARK: - Filter
struct Filter: Codable {
    let id, name: String?
    let type: TypeEnum?
    let values: [FilterValue]?
}

// MARK: - FilterValue
struct FilterValue: Codable {
    let id, name: String?
    let pathFromRoot: [Sort]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case pathFromRoot = "path_from_root"
    }
}

// MARK: - Paging
struct Paging: Codable {
    let total, primaryResults, offset, limit: Int?

    enum CodingKeys: String, CodingKey {
        case total
        case primaryResults = "primary_results"
        case offset, limit
    }
}

// MARK: - PDPTracking
struct PDPTracking: Codable {
    let group: Bool?
    let productInfo: [ProductInfo]?

    enum CodingKeys: String, CodingKey {
        case group
        case productInfo = "product_info"
    }
}

// MARK: - ProductInfo
struct ProductInfo: Codable {
    let id: String?
    let score: Int?
    let status: Status?
}

enum Status: String, Codable {
    case shown = "shown"
}

// MARK: - Result
struct Result: Codable {
    let id, title: String?
    let condition: String?
    let thumbnailID: String?
    let catalogProductID: String?
    let listingTypeID: String?
    let permalink: String?
    let buyingMode: String?
    let siteID: String?
    let categoryID: String?
    let domainID: String?
    let thumbnail: String?
    let currencyID: String?
    let orderBackend: Int?
    let price: Double?
    let originalPrice: Int?
    let salePrice: JSONNull?
    let availableQuantity: Int?
    let officialStoreID: Int?
    let officialStoreName: String?
    let useThumbnailID, acceptsMercadopago: Bool?
    let stopTime: String?
    let seller: Seller?
    let attributes: [Attribute]?
    let installments: Installments?
    let winnerItemID: JSONNull?
    let catalogListing: Bool?
    let discounts: JSONNull?
    let promotions: [JSONAny]?
    let differentialPricing: DifferentialPricing?
    let inventoryID: String?
    let variationID: String?
    let variationFilters: [String]?
    let variationsData: [String: VariationsDatum]?

    enum CodingKeys: String, CodingKey {
        case id, title, condition
        case thumbnailID = "thumbnail_id"
        case catalogProductID = "catalog_product_id"
        case listingTypeID = "listing_type_id"
        case permalink
        case buyingMode = "buying_mode"
        case siteID = "site_id"
        case categoryID = "category_id"
        case domainID = "domain_id"
        case thumbnail
        case currencyID = "currency_id"
        case orderBackend = "order_backend"
        case price
        case originalPrice = "original_price"
        case salePrice = "sale_price"
        case availableQuantity = "available_quantity"
        case officialStoreID = "official_store_id"
        case officialStoreName = "official_store_name"
        case useThumbnailID = "use_thumbnail_id"
        case acceptsMercadopago = "accepts_mercadopago"
        case stopTime = "stop_time"
        case seller, attributes, installments
        case winnerItemID = "winner_item_id"
        case catalogListing = "catalog_listing"
        case discounts, promotions
        case differentialPricing = "differential_pricing"
        case inventoryID = "inventory_id"
        case variationID = "variation_id"
        case variationFilters = "variation_filters"
        case variationsData = "variations_data"
    }
}

// MARK: - Attribute
struct Attribute: Codable {
    let id: String?
    let name: String?
    let valueID, valueName: String?
    let attributeGroupID: String?
    let attributeGroupName: String?
    let valueStruct: Struct?
    let values: [AttributeValue]?
    let source: Int?
    let valueType: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueID = "value_id"
        case valueName = "value_name"
        case attributeGroupID = "attribute_group_id"
        case attributeGroupName = "attribute_group_name"
        case valueStruct = "value_struct"
        case values, source
        case valueType = "value_type"
    }
}

// MARK: - Struct
struct Struct: Codable {
    let number: Double?
    let unit: String?
}

// MARK: - AttributeValue
struct AttributeValue: Codable {
    let id, name: String?
    let valueStruct: Struct?
    let source: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueStruct = "struct"
        case source
    }
}

// MARK: - DifferentialPricing
struct DifferentialPricing: Codable {
    let id: Int?
}

// MARK: - Installments
struct Installments: Codable {
    let quantity: Int?
    let amount, rate: Double?
    let currencyID: String?

    enum CodingKeys: String, CodingKey {
        case quantity, amount, rate
        case currencyID = "currency_id"
    }
}

// MARK: - Seller
struct Seller: Codable {
    let id: Int?
    let nickname: String?
}

enum LogisticType: String, Codable {
    case crossDocking = "cross_docking"
    case dropOff = "drop_off"
    case fulfillment = "fulfillment"
    case xdDropOff = "xd_drop_off"
}


// MARK: - VariationsDatum
struct VariationsDatum: Codable {
    let thumbnail: String?
    let ratio, name: String?
    let picturesQty: Int?
    let userProductID: String?

    enum CodingKeys: String, CodingKey {
        case thumbnail, ratio, name
        case picturesQty = "pictures_qty"
        case userProductID = "user_product_id"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
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

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

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
