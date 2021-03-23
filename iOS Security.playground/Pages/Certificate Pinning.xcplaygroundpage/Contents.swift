/*:
 [Previous](@previous)

## Certificate Pinning
 
 ### At A Glace
 
SSL (Secure Socket Layer) ensures encrypted client-server communication over HTTP - specified by HTTPS (HTTP over SSL). The encryption is based on PKI (Public Key Infrastructure) and a session key. The session key was introduced because encrypting and decrypting a public/private key uses a lot of processing power and it would slow down the whole communication process.
 
 The security aspect of SSL is based on the certificate's "chain of trust". When the communication starts, the client examines the server's SSL certificate and checks if the received certificate is trusted by the Trusted Root CA store or other user-trusted certificates.
 
 Although SSL communication is considered pretty much secure and unbreakable in realistic time frames, the man-in-the-middle attack still poses an actual threat. It can be carried out using several methods, which include [ARP cache poisoning](https://www.thegeekstuff.com/2012/01/arp-cache-poisoning/) and [DNS spoofing](https://www.menandmice.com).
 
 ### SSL Pinning
 
 We use SSL pinning to ensure that the app communicates only with the designated server itself.
 One of the prerequisites for SSL pinning is saving the target's server SSL certificate within the app bundle.
 The saved certificate is used when defining the pinned certificate(s) upon session configuration.

 Things are a bit more tricky when it comes to NSURLSession SSL pinning. There is no way to set an array of pinned certificates and cancel all responses that don't match our local certificate automatically. We need to perform all checks manually to implement SSL pinning on NSURLSession. We'll happily use some of the Security's framework C API (like all other true hackers do).
 
 We can start by instantiating an `URLSession` object with the default session configuration.
 ```
 let session = URLSession(configuration: .default)
 ```

 URLSession sends requests using tasks (URLSessionTask). We will use the `session.dataTask(with:, completionHandler:)` method for the SSL pinning test. The request we send will look something like this:
 
 ```
 let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
 
 let url = URL(string: textField.text!)!
 
 let task = session.dataTask(with: url) { (data, response, error) in
    // response management code
 }
 
 task.resume()
 ```

 The magic of SSL pinning is implemented within the `urlSession(_ session:didReceive challenge:completionHandler:)` method. Note that, upon the creation of the `URLSession` object, we assigned self as the delegate so that this method is called on our object.
 
 ```
 func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
 
     if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
         if let serverTrust = challenge.protectionSpace.serverTrust {
             var secresult = SecTrustResultType.invalid
             let status = SecTrustEvaluate(serverTrust, &secresult)
             if(errSecSuccess == status) {
                 print(SecTrustGetCertificateCount(serverTrust))
                     if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
 // Certificate pinning, uncomment to use this instead of public key pinning
 //                        let serverCertificateData:NSData = SecCertificateCopyData(serverCertificate)
 //                        let certHash = sha256(data: serverCertificateData as Data)
 //                        if (certHash == pinnedCertificateHash) {
 //                            // Success! This is our server
 //                            completionHandler(.useCredential, URLCredential(trust:serverTrust))
 //                            return
 //                        }
 // Public key pinning
 //                        let serverPublicKey = SecCertificateCopyPublicKey(serverCertificate)
 //                        let serverPublicKeyData:NSData = SecKeyCopyExternalRepresentation(serverPublicKey!, nil )!
 //                        let keyHash = sha256(data: serverPublicKeyData as Data)
 //                        if (keyHash == pinnedPublicKeyHash) {
 //                            // Success! This is our server
 //                            completionHandler(.useCredential, URLCredential(trust:serverTrust))
 //                            return
 //                        }
                 }
             }
         }
     }
 // Pinning failed
 completionHandler(.cancelAuthenticationChallenge, nil)
 
 }
 ```
 
 - NOTE: This code assumes that we already have a hash of the public key or certificate, which can created using FireFox or using the [methods outlined here](https://dzone.com/articles/ssl-certificate-pinning-in-ios-applications)
 
 */
