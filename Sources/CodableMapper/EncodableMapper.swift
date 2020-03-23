@propertyWrapper
public struct EncodableMapper<Provider: EncodableMapperProvider>: Encodable {

    public var wrappedValue: Provider.Value

    public init(defaultValue: Provider.Value) {

        self.wrappedValue = defaultValue
    }

    public func encode(to encoder: Encoder) throws {

        var container = encoder.singleValueContainer()
        let rawValue = try Provider.map(value: wrappedValue)
        try container.encode(rawValue)
    }
}

public extension KeyedEncodingContainer {

    /// Encodes the EncodableMapper wrapped value into the encoding container. In case it is a `nil` value it doesn't encode anything.
    /// - Parameter value: the value to be encoded
    /// - Parameter key: the key to where the value should be encoded
    mutating func encode<Provider, Value>(_ value: EncodableMapper<Provider>, forKey key: Key) throws where Provider.Value == Optional<Value> {

        guard let value = value.wrappedValue else { return }
        try encode(try Provider.map(value: value), forKey: key)
    }
}
