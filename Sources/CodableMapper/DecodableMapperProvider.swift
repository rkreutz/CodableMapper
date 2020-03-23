public protocol DecodableMapperProvider {

    associatedtype RawValue: Decodable
    associatedtype Value

    static func map(rawValue: RawValue) throws -> Value
}
