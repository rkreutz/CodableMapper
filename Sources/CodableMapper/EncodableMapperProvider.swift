public protocol EncodableMapperProvider {

    associatedtype RawValue: Encodable
    associatedtype Value

    static func map(value: Value) throws -> RawValue
}
