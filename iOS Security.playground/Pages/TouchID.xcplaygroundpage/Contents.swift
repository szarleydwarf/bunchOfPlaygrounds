/*:
[Previous](@previous)
 
 ## TouchID & FaceID
 
 Implementing biometric ID is as simple as importing the Local Authentication framework and calling a couple of simple yet powerful methods.
 
 Here’s what the Local Authentication documentation has to say:
 *“The Local Authentication framework provides facilities for requesting authentication from users with specified security policies.”*
 
 The specified security policy in this case will be your user’s biometrics — A.K.A their face or fingerprint! :]
 
 New in iOS 11 is support for Face ID. `LocalAuthentication` adds a couple of new things: a required *FaceIDUsageDescription* and a `LABiometryType` to determine whether the device supports Face ID or Touch ID.
 
 - NOTE:
 Face ID requires that you test on a physical device, such as an iPhone X, XS, XS Max & XR. Touch ID can now be emulated in Xcode 9 in the Simulator. You can test biometric ID on any device with a A7 chip or newer and Face ID/Touch ID hardware.
 
 If you want to work with TouchID, you’ll have to link your app with the [Local Authentication](https://developer.apple.com/documentation/localauthentication#classes) framework.
 
 Go to *Project Settings > General* and scroll down to the *Linked Frameworks and Libraries section*. Click on the + sign and add *LocalAuthentication.framework*.
 
 ![Link the LocalAuthentication.framework with your app](link_localAuthenticationFramework.png "Link the LocalAuthentication.framework with your app")
 
 To use the framework we first need to import the Local Authentication framework
 ```
 import LocalAuthentication
 ```
 
 - NOTE:
 The Local Authentication framework is quite small for Apple standards. It only has one class named [LAContext](https://developer.apple.com/documentation/localauthentication/lacontext#//apple_ref/c/tdef/LAPolicy).
 
 First we need to create an authentication context.  You do this by creating an instance of the LAContext class.
 
```
 let authenticationContext = LAContext()
```
 
 Because not every device has a TouchID sensor, we need to ask the context if there is a fingerprint sensor.
 
 You do this by calling the method `canEvaluatePolicy(:error:)`. This method will return a boolean which you can use to provide a fallback authentication method if there is no TouchID available.
 
 ```
 var error:NSError?
 guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
     print("This device does not have a TouchID sensor.")
     return
 }
 ```
 
 If the device does have a TouchID sensor, we want to present the user the typical TouchID form.
 
 ![TouchID Form](touch-id-form.jpg "TouchID Form")
 
 This popup is shown when you call the `evaluatePolicy(:localizedReason:reply:)` method on your authentication context.
 
 ```
 authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Only awesome people are allowed") { (success, error) in
 
     if success {
        // Fingerprint recognized
     } else {
        // Check if there is an error
         if let error = error {
            print(error.localizedDescription)
         }
     }
 }
 ```
 
 This method has 3 arguments:
 
 1. `policy`: the policy to evaluate
 2. `localizedReason:` a string message that will be shown to the user, explaining why they need to provide their fingerprint
 3. `reply:` a closure which is executed when the evaluation ends. This closure has 2 arguments
 success: true if fingerprint is recognized, false if not
 error: an Error object with an error code (check [LAError.Code](https://developer.apple.com/documentation/localauthentication/laerror.code) for all options)
 
 [Next](@next)
 */
