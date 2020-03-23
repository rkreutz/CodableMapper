import Foundation
import XCTest
@testable import CodableMapper

final class CodableMapperTests: XCTestCase {

    func testFullDecode() {

        let json = """
        {
            "name": "John Doe",
            "dateOfBirth": "01/01/1990",
            "dateAdded": "2020-01-10T12:30:00Z",
            "lastUpdated": "2020-03-23T16:45:32Z"
        }
        """.data(using: .utf8) ?? Data()

        let decoder = JSONDecoder()

        XCTAssertNoThrow(try decoder.decode(Person.self, from: json))

        XCTAssertEqual(
            try decoder.decode(Person.self, from: json).name,
            "John Doe"
        )
        XCTAssertEqual(
            try decoder.decode(Person.self, from: json).dateOfBirth,
            Date(timeIntervalSince1970: 631_152_000.0)
        )
        XCTAssertEqual(
            try decoder.decode(Person.self, from: json).dateAdded,
            Date(timeIntervalSince1970: 1_578_659_400.0)
        )
        XCTAssertEqual(
            try decoder.decode(Person.self, from: json).lastUpdated,
            Date(timeIntervalSince1970: 1_584_981_932.0)
        )
    }

    func testDecodeWithNilOptionals() {

        let json = """
        {
            "name": "John Doe",
            "dateOfBirth": "01/01/1990",
            "dateAdded": "2020-01-10T12:30:00Z"
        }
        """.data(using: .utf8) ?? Data()

        let decoder = JSONDecoder()

        XCTAssertNoThrow(try decoder.decode(Person.self, from: json))

        XCTAssertEqual(
            try decoder.decode(Person.self, from: json).name,
            "John Doe"
        )
        XCTAssertEqual(
            try decoder.decode(Person.self, from: json).dateOfBirth,
            Date(timeIntervalSince1970: 631_152_000.0)
        )
        XCTAssertEqual(
            try decoder.decode(Person.self, from: json).dateAdded,
            Date(timeIntervalSince1970: 1_578_659_400.0)
        )
        XCTAssertNil(try decoder.decode(Person.self, from: json).lastUpdated)
    }

    func testDecodeMissingFields() {

        let json = """
        {
            "name": "John Doe",
            "dateAdded": "2020-01-10T12:30:00Z"
        }
        """.data(using: .utf8) ?? Data()

        let json2 = """
        {
            "name": "John Doe",
            "dateOfBirth": "01/01/1990"
        }
        """.data(using: .utf8) ?? Data()

        let decoder = JSONDecoder()

        XCTAssertThrowsError(try decoder.decode(Person.self, from: json))
        XCTAssertThrowsError(try decoder.decode(Person.self, from: json2))
    }

    func testDecodeInvalidFormats() {

        let json = """
        {
            "name": "John Doe",
            "dateOfBirth": "01/01/1990",
            "dateAdded": "notValid"
        }
        """.data(using: .utf8) ?? Data()

        let json2 = """
        {
            "name": "John Doe",
            "dateOfBirth": "notValid",
            "dateAdded": "2020-01-10T12:30:00Z"
        }
        """.data(using: .utf8) ?? Data()

        let decoder = JSONDecoder()

        XCTAssertThrowsError(try decoder.decode(Person.self, from: json))
        XCTAssertThrowsError(try decoder.decode(Person.self, from: json2))
    }

    func testDecodeInvalidTypes() {

        let json = """
        {
            "name": "John Doe",
            "dateOfBirth": "01/01/1990",
            "dateAdded": 1578659400
        }
        """.data(using: .utf8) ?? Data()

        let json2 = """
        {
            "name": "John Doe",
            "dateOfBirth": 631152000,
            "dateAdded": "2020-01-10T12:30:00Z"
        }
        """.data(using: .utf8) ?? Data()

        let decoder = JSONDecoder()

        XCTAssertThrowsError(try decoder.decode(Person.self, from: json))
        XCTAssertThrowsError(try decoder.decode(Person.self, from: json2))
    }

    static var allTests = [
        ("testFullDecode", testFullDecode),
        ("testDecodeWithNilOptionals", testDecodeWithNilOptionals),
        ("testDecodeMissingFields", testDecodeMissingFields),
        ("testDecodeInvalidFormats", testDecodeInvalidFormats),
        ("testDecodeInvalidTypes", testDecodeInvalidTypes)
    ]
}
