//: [Previous](@previous)
/*:
 ## User Preferences
 
 * Defaults class provides a programmatic interface for interacting with the defaults system database
 * The defaults database is actually a collection of property list files; every application has its own property list file where the defaults are stored
 * The defaults database allows an application to customize its behavior to match a user’s preference
 * You can use the `UserDefaults` class to gain access your app’s preference. Each app is provided with a single instance of this class For example, you can allow users to determine what units of units of measurement your application displays
 * You can find the plist file for your app in your simulator if you go to **users/<User Name>/Library/Application Support/iPhone Simulator/<SimVersion>/Applications/1BAB4C83-8E7E-4671-AC35-6043F8A9BFA7/Library/Preferences**

 With NSUserDefaults you can save the following class types;
 * `Data` - Not Advised
 * `String`
 * `Number`
 * `Date`
 * `Array`
 * `Dictionary`
 
 If you want to store any other type of object, such as an UIImage, you will need to archive it or wrap it in an instance of `Data`, `Number` or `String`.
 
 ### Writing Data
 */
import Foundation
import UIKit

struct keys {
    static let text = "SomeText"
    static let int = "SomeInt"
    static let bool = "SomeBool"
    static let image = "SomeImage"
}

let someText = "Hello"
let someInt = Int.max
let someBool = true
let someImageData = UIImage(named: "SomeImage")


let userPreferences = UserDefaults.standard

userPreferences.set(someText, forKey: keys.text)
userPreferences.set(someInt, forKey: keys.int)
userPreferences.set(someBool, forKey: keys.bool)
userPreferences.set(someImageData, forKey: keys.image)

print("Sync: " + (userPreferences.synchronize() ? "Success" : "Failure"))
//: ### Reading Data

let a = userPreferences.string(forKey: keys.text)
let b = userPreferences.integer(forKey: keys.int)
let c = userPreferences.bool(forKey: keys.bool)
let d = userPreferences.data(forKey: keys.image)


userPreferences.removeObject(forKey: keys.text)


//: [Next](@next)
