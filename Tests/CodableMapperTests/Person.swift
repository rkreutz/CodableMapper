import CodableMapper
import Foundation

struct Person: Codable {

    var name: String

    @CodableMapper<CustomDateProvider>
    var dateOfBirth: Date

    @CodableMapper<ISODateProvider>
    var dateAdded: Date

    @CodableMapper<OptionalISODateProvider>
    var lastUpdated: Date?
}
