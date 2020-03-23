import CodableMapper
import Foundation

struct ISODateProvider: CodableMapperProvider {

    typealias RawValue = String
    typealias Value = Date

    static let formatter: DateFormatter = {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    public enum Error: Swift.Error {

        case failed
    }

    static func map(value: Date) throws -> String { formatter.string(from: value) }

    static func map(rawValue: String) throws -> Date {

        guard let date = formatter.date(from: rawValue) else { throw Error.failed }
        return date
    }
}

struct OptionalISODateProvider: CodableMapperProvider {

    typealias RawValue = String
    typealias Value = Date?

    static let formatter: DateFormatter = {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    static func map(value: Date?) throws -> String { value.map(formatter.string(from:)) ?? "" }

    static func map(rawValue: String) throws -> Date? { formatter.date(from: rawValue) }
}
