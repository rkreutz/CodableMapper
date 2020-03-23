import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    [
        testCase(CodableMapperTests.allTests)
    ]
}
#endif
