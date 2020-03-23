@propertyWrapper
public struct DecodableMapper<Provider: DecodableMapperProvider>: Decodable {

    public var wrappedValue: Provider.Value

    public init(_ wrappedValue: Provider.Value) {

        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {

        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(Provider.RawValue.self)
        wrappedValue = try Provider.map(rawValue: rawValue)
    }
}

public extension KeyedDecodingContainer {

    /// Decodes a key-value pair into a DecodableMapper wrapped value in case the DecodableMapper accepts optionals. This is done so that optionals using the DecodableMapper property wrapper may be decoded as `nil` in case their key does't exist in the decoded data.
    /// - Parameter type: the type to be decoded
    /// - Parameter key: the key of the key-value pair to be decoded
    func decode<Provider, Value>(_ type: DecodableMapper<Provider>.Type, forKey key: Key) throws -> DecodableMapper<Provider> where Provider.Value == Optional<Value> {

        if let rawValue = try decodeIfPresent(Provider.RawValue.self, forKey: key) {

            return DecodableMapper(try Provider.map(rawValue: rawValue))
        } else {

            return DecodableMapper(nil)
        }
    }
}
