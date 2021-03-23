//: [Previous](@previous)
/*:
 # Property Lists

 ## Definition
 
 * It is a representation of a hierarchy of objects that can be stored in the file systems & reconstituted later
 * The file itself is typically encoded using the Unicode UTF-8 encoding & the contents are structured using XML
 * The root XML node is a dictionary, whose contents are a set of keys and values
 
 ![Create Property List](propertyList.png "Create Property List")
 
 You can also create/edit the property list in a text editor such TextEdit, BBEdit or built in Xcode source code editor. When you are finished, the XML should like so

 ![Open Property List](openPropertyList.png "Open Property List")
 
 * For situations where you need to store small amounts of persistent data – say less than a few hundred kilo bytes.
 * Should be used to store data that primarily consists of strings & numbers.
 * Are inefficent when used with large blocks of binary data.
 
 # Codable For Property Lists
 
 Most solutions found onlne use Objective-C class like `NSDictionary` and `NSArray`, these solutions should be **avoided** at all costs
 - NOTE: Apple will deprecate the old `NSDictionary` and `NSArray` methods in a future release.
 
 
 The Codable protocol is new to Swift in iOS 11 and handles converting a type to and from an external format such as JSON or PropertyList.
 
 
## Encodable, Decodable & Codable Protocols
 
 * `Encodable` - A type that can `encode` itself to an external representation. It is used by the types that can be encoded.
 * `Decodable` - A type that can `decode` itself from an external representation. It is used by the types that can be decoded.
 * `Codable` - A type that can convert itself `into and out of` an external representation. It is used by the type can be both encoded as well as decoded.
 It includes the methods declared in both Encodable as well as Decodable.
 
 ```
 typealias Codable = Decodable & Encodable
 ```
 
 To encode and decode a custom type, we need to make it `Codable`.

 The simplest way to make a type codable is to declare its properties using types that are already Codable.
 * Foundation types  are all `Codable`— `String`, `Int`, `Double`, `Data`, `URL`
 * Collection types `Array`, `Dictionary`, `Optional` are `Codable` if they contain `Codable` types
 
 For example, a property list which is a dictionary containing a boolean, string and integer:
 
 ![pList Example](plistExample.png "pList Example")
 
 Define a structure that matches this format and adopt the Codable protocol:
 */

import Foundation

 struct MySettings: Codable {
     var someFlag: Bool
     var someString: String
     var someInt: Int
 }
/*:
 - NOTE: The property names match the key names of the items in the property list.

## Encoding to a Property List
  
Writing or encoding a property list is easy.
 
 1. Create an instance of `PropertyListEncoder`
 2. Set the output format
 3. Use the encoder to encode the data
 
*/

func encodeObject(_ setting: MySettings) -> Data? {
 
    // 1.
    let encoder = PropertyListEncoder()
    
    // 2.
    encoder.outputFormat = PropertyListSerialization.PropertyListFormat.xml
    
    // 3.
    do {
        return try encoder.encode(setting)
    } catch {
        print("Encoder Error: \(error)")
        return nil
    }
        
}

/*:
  - Note: The outputFormat can be .binary, .openStep or .xml.
 
 ## Decoding to a Property List

 Reading or decoding a property list is even easier.
 
 1. Create an instance of `PropertyListDecoder`
 2. Use the decoder to decode the binary data into an instance of a `Codable` type
 
 */

func decodeObject(_ data: Data) -> MySettings? {
 
    let decoder = PropertyListDecoder()
    var settings: MySettings? = nil
    
    do {
        settings = try decoder.decode(MySettings.self, from: data)
     } catch {
     // Handle error
        print(error)
     }
    
    return settings

}
 
/*:
 
 ## Array as the root
 
 If the root of the pList was an `Array` instead of a `Dictionary`, here's how the code will differ
 
For encoding, the logic, stays exactly the same. The only difference is that the arguement is now an array instead of a single instance
 */

func encodeObjects(_ settings: [MySettings]) -> Data? {
    
    // 1.
    let encoder = PropertyListEncoder()
    
    // 2.
    encoder.outputFormat = PropertyListSerialization.PropertyListFormat.xml
    
    // 3.
    do {
        return try encoder.encode(settings)
    } catch {
        print("Encoder Error: \(error)")
        return nil
    }
    
}

/*:

 For decoding, rather than specifing `MySetting.self` as the type to decode into, we specify `[MySetting].self`
 
*/

func decodeObject(_ data: Data) -> [MySettings]? {
 
    let decoder = PropertyListDecoder()
    var settings: [MySettings]? = nil
    
    do {
        settings = try decoder.decode([MySettings].self, from: data)
     } catch {
     // Handle error
        print(error)
     }
    
    return settings

}

//: [Next](@next)
