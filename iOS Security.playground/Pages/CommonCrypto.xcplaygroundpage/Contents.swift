/*:
 [Previous](@previous)

 ## CommonCrypto

The method shown previously should not be considered complete! Storing the user’s password directly isn’t the best practice. For example, if an attacker compromised Apple’s Keychain, he could read your user’s passwords in plain text. A better solution is to store a hash built from the user’s identity.
 
 - NOTE:
 Apple’s `CommonCrypto` framework provides many useful hashing functions for you, but it’s not easy to interact with it in Swift.
 
 [CryptoSwift](http://cryptoswift.io) is one of the most popular collections of many standard cryptographic algorithms written in Swift.
 
 Cryptography is difficult and needs to be done correctly to be useful. Using a popular library for security means you don’t have to be responsible for the implementation of standardized hashing functions. The best cryptography is open to the public for review.
 
 With access to CommonCrypto we can create a custom hashing algorithm with salt
 
 ![Salting](salting.jpg "Salting")
 
 
 ```
 class func passwordHash(from email: String, password: String) -> String {
     let salt = "x4vV8bGgqqmQwgCoyXFQj+(o.nUNQhVP7ND"
     return "\(salt).\(password).\(email)".sha256()
 }
 ```
 
 The salt is a unique string used to make common passwords, well, uncommon. `sha256()` is a *CryptoSwift* method that completes a type of *SHA-2* hash on your input string.
 
 The attacker might create a table of commonly used passwords and their hashes to compare against this hash. If you hashed just the user’s input without salting, and the password existed in the attackers hash table, the password would be compromised.
 
 Incorporating a salt increases the complexity of the attack. Furthermore, you combine the user’s email and password with the salt to create a hash that won’t be easily cracked.
 
 - NOTE:
 For authentication with a server backend, the app and server would share the same salt. This allows them to build hashes in the same way and compare the two hashes to verify identity.
 
 Putting this together we can get
 ```
 let finalHash = passwordHash(from: user.email, password: password)
 try KeychainPasswordItem(service: serviceName, account: user.email).savePassword(finalHash)
 ```
 
 [Next](@next)
 */
