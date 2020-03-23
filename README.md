# CodableMapper
![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg)
[![Swift Package Manager](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager)
![MacOS](https://github.com/rkreutz/CodableMapper/workflows/MacOS/badge.svg?branch=master&event=push)
![Linux](https://github.com/rkreutz/CodableMapper/workflows/Linux/badge.svg?branch=master&event=push)

**CodableMapper** is a Swift µpackage that provides an interface (through Property Wrappers) to define custom mappers for individual properties in a `Codable` struct.

## Usage
There are three Property Wrappers provided in this package: `DecodableMapper`, `EncodableMapper` and `CodableMapper`; these are analogous to how `Decodable`, `Encodable` and `Codable` protocols work, where the last is the combination of the previous protocols.

To use `DecodableMapper` you must specify a `DecodableMapperProvider` conformant class/struct, which basically consists of a static method method to map from the value in the raw Data to the specialized value. Something like:
```swift
struct Person: Decodable {

    ...

    @DecodableMapper<CustomDateProvider>
    var dateOfBirth: Date

    ...
}
```
Notice that you still need to make the `Person` struct conform to `Decodable`, otherwise you won't be able to decode it (just in case it's not obvious 😅)

Similarly you may use `EncodableMapper`, where you must specialize it with a `EncodableMapperProvider` conformant class/struct, which does the opposite mapping (from specialized value to raw Data):
```swift
struct Person: Encodable {

    ...

    @EncodableMapper<CustomDateProvider>
    var dateOfBirth: Date

    ...
}
```
As well, the `Person` struct must conform to `Encodable`.

And finally we have `CodableMapper`, which is analougous to `Codable`, where the mapper provider must conform to both `DecodableMapperProvider` and `EncodableMapperProvider`. Usage is pretty similar to the previous ones:
```swift
struct Person: Codable {

    ...

    @CodableMapper<CustomDateProvider>
    var dateOfBirth: Date

    ...
}
```

**Notice that you must specify different providers for optional and non-optional values, even if the mapping used is the same, unfortunately I couldn't find a nice way to reuse them so feel free to open a PR if you have any ideas on it 😊**
```swift
struct Person: Codable {

    ...

    @CodableMapper<ISODateProvider>
    var dateAdded: Date

    @CodableMapper<OptionalISODateProvider>
    var lastUpdated: Date?
    
    ...
}
```

**You may check the Tests in this repo to see how the `CodableMapper` Property Wrapper works in practice and how to define your own mapper providers.**

## Installation
**Using the Swift Package Manager**

Add **CodableMapper** as a dependency to your `Package.swift` file. For more information, see the [Swift Package Manager documentation](https://github.com/apple/swift-package-manager/tree/master/Documentation).

```
.package(url: "https://github.com/rkreutz/CodableMapper", from: "1.0.0")
```

## Help & Feedback
- [Open an issue](https://github.com/rkreutz/CodableMapper/issues/new) if you need help, if you found a bug, or if you want to discuss a feature request.
- [Open a PR](https://github.com/rkreutz/CodableMapper/pull/new/master) if you want to make some change to `CodableMapper`.
