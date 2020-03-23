import CodableMapper
import Foundation

struct CustomDateProvider: CodableMapperProvider {

    typealias RawValue = String
    typealias Value = Date

    static let formatter: DateFormatter = {

        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    public enum Error: Swift.Error {

        case failed
    }

    static func map(rawValue: String) throws -> Date {

        guard let date = formatter.date(from: rawValue) else { throw Error.failed }
        return date
    }

    static func map(value: Date) throws -> String {

        formatter.string(from: value)
    }
}
