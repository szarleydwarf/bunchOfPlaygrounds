/*:
 [Previous](@previous)

## Asynchronous Operations
 
 `URLSession` methods are asynchronous: they return right away, but don’t really finish running until some time later.
 To test asynchronous methods, you use `XCTestExpectation` to make your test wait for the asynchronous operation to complete.
 Asynchronous tests are usually slow, so you should keep them separate from your faster unit test
 
 The following example test checks that that sending a valid query to iTunes returns a 200 status code. Most of the code is the same as what you’d write in the app, with the additional lines;
 
 1. `expectation(description:)` returns an `XCTestExpectation` object, which you store in promise. Other commonly used names for this object are *expectation* and *future*. The description parameter describes what you expect to happen
 2. To match the description, you call fulfill in the success condition block of the asynchronous method’s completion handler
 3. `waitForExpectations(timeout:, handler:)` keeps the test running until all the expectations are fulfilled, or the timeout intervals ends, whichever happens first
*/

import XCTest

class FOO: XCTestCase {
    
    var sessionUnderTest: URLSession?
    
    override func setUp() {
        sessionUnderTest = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        sessionUnderTest = nil
    }
    
    func testiTunesConnectionReturns200() {
        
        //Given
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=prince")!

        let prmoise = expectation(description: "Status Code 200")

        // When
        let dataTask = sessionUnderTest?.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            } else if let response = response as? HTTPURLResponse {
                
                if response.statusCode == 200 {
                    
                    // Then
                     prmoise.fulfill()
                } else {
                    XCTFail("Error Code: \(response.statusCode)")
                }
                
            } else {
                XCTFail("Unknown Failure")
            }
        })
        
        dataTask?.resume()
        
        // Then
        waitForExpectations(timeout: 60.0, handler: nil)
    }

/*:
 
 ### Fail Fast
 
 * Failing is never fun, unless you’re a sadist. However you should not be forced to to wait to know if you’ve failed
 * Assume the URL is malformed, the test will fail but it takes the full timeout interval. This is because the promise if only fulfilled in the success case
 * You can make the test fail faster by changing the expectation;
    * Instead of waiting for the request to success, wait only until the asynchronous method’s completion handler is invoked
    * This happens as soon as the app receives a response — either OK or error — from the server, which fulfills the expectation.
 
 * The key thing here is that simply entering the completion handler fulfills the expectation, and this takes about a second to happen. If the request fails, the then assertions fail.
*/
 func testiTunesConnectionFast() {
 
     // Given
     let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=prince")!
 
     // 1
     let prmoise = expectation(description: "Status Code 200")
 
     var statusCode: Int?
     var responseError: Error?
 
     // When
     let dataTask = sessionUnderTest?.dataTask(with: url, completionHandler: { (data, response, error) in
 
         statusCode = (response as? HTTPURLResponse)?.statusCode
         responseError = error
        
         // 2
         prmoise.fulfill()
     })
 
     dataTask?.resume()
     waitForExpectations(timeout: 15.0, handler: nil)
 
    // Then
     XCTAssertNil(responseError, "A Network Error")
     XCTAssertEqual(200, statusCode!, "The Code was not 200")
    
     }
 
 }
/*:
[Next](@next)
*/
