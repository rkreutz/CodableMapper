@propertyWrapper
public struct CodableMapper<Provider: CodableMapperProvider>: Codable {

    public var wrappedValue: Provider.Value

    public init(_ wrappedValue: Provider.Value) {

        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {

        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(Provider.RawValue.self)
        wrappedValue = try Provider.map(rawValue: rawValue)
    }

    public func encode(to encoder: Encoder) throws {

        var container = encoder.singleValueContainer()
        let rawValue = try Provider.map(value: wrappedValue)
        try container.encode(rawValue)
    }
}

public extension KeyedDecodingContainer {

    /// Decodes a key-value pair into a CodableMapper wrapped value in case the CodableMapper accepts optionals. This is done so that optionals using the CodableMapper property wrapper may be decoded as `nil` in case their key does't exist in the decoded data.
    /// - Parameter type: the type to be decoded
    /// - Parameter key: the key of the key-value pair to be decoded
    func decode<Provider, Value>(_ type: CodableMapper<Provider>.Type, forKey key: Key) throws -> CodableMapper<Provider>
        where Provider.Value == Value? {

        if let rawValue = try decodeIfPresent(Provider.RawValue.self, forKey: key) {

            return CodableMapper(try Provider.map(rawValue: rawValue))
        } else {

            return CodableMapper(nil)
        }
    }
}

public extension KeyedEncodingContainer {

    /// Encodes the CodableMapper wrapped value into the encoding container. In case it is a `nil` value it doesn't encode anything.
    /// - Parameter value: the value to be encoded
    /// - Parameter key: the key to where the value should be encoded
    mutating func encode<Provider, Value>(_ value: CodableMapper<Provider>, forKey key: Key) throws
        where Provider.Value == Value? {

        guard let value = value.wrappedValue else { return }
        try encode(try Provider.map(value: value), forKey: key)
    }
}
