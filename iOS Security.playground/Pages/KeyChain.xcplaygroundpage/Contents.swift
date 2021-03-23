/*:
 
 [Previous](@previous)
 
 ## Apple's KeyChain
 
 One of the most important security elements for Apple developers is the iOS *Keychain*, which is a specialized database for storing metadata and sensitive information. Using *Keychain* is the best practice for storing small pieces of data that are critical to your app such as secrets and passwords.
 
 Why use the *Keychain* over simpler solutions? Wouldn’t storing the base-64 encoding the user’s password in `UserDefaults` be enough?
 Definitely not! It’s trivial for an attacker to recover a password stored that way. Security is difficult, and attempting your own custom solution is not a good idea. Even if your app is not for a financial institution, storing private user input should not be taken lightly.
 
 Interacting with the *Keychain* directly is complicated, especially in Swift. You have to use the Security framework that is mostly written in C.
 
 - NOTE:
 Fortunately, you can avoid using these low level APIs by borrowing a Swift wrapper from Apple’s sample code [GenericKeychain](https://developer.apple.com/library/content/samplecode/GenericKeychain/Introduction/Intro.html#//apple_ref/doc/uid/DTS40007797-Intro-DontLinkElementID_2). *KeychainPasswordItem* provides an easy-to-use Swift interface to the *Keychain* and is already included in the starter project.
 
 The overacrhing idea behind the KeyChain is to store a value againast a given key, how the Apple wrapper works is that they required to to a `KeychainPasswordItem` using a `service` name, which you can define, a unique ID/account/key and an optional `accessGroup`
 
 ```
static let serviceName = "FooBarService"
let item = KeychainPasswordItem(service: serviceName, account: user.email)
 ```
 
 - NOTE:
 Given the fact that the KeychainPasswordItem depends on the service name, it's best that you keep this constant somewhere safe. In the example project provided by Apple this store in the `KeychainConfiguration`
 ```
 struct KeychainConfiguration {
     static let serviceName = "MyAppService"

     // static let accessGroup = "[YOUR APP ID PREFIX].com.example.apple-samplecode.GenericKeychainShared"
 
     static let accessGroup: String? = nil
 
    private init(){}
 }
 ```
 
 - NOTE:
 Specifying an access group to use with `KeychainPasswordItem` instances will create items shared accross both apps.
 \
Not specifying an access group to use with `KeychainPasswordItem` instances will create items specific to each app.
 
 To save a password under this key/account we can call `savePassword(_:)`
 
 ```
 do {
    try item.savePassword(user.password)
 } catch {
    fatalError("Error updating keychain - \(error)")
 }
 ```
 
 To read the password back we can call `readPassword`
 ```
 do {
    let password = try item.readPassword()
 } catch {
     fatalError("Error reading password from keychain - \(error)")
 }
 ```
 
 To remove an item we can call `deleteItem()`
 
 ```
 do {
    try passwordItem.deleteItem()
 } catch {
    fatalError("Error deleting keychain item - \(error)")
 }
 ```
 
 - IMPORTANT:
 This is a case specific KeyChain wrapper, you can choose to interact with the KeyChain directly (but it's not a good idea) or choose one of the other 3rd party KeyChain wrappers in Swift
 
 [Next](@next)
*/
