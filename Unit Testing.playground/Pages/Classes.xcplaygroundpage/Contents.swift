
/*:
 [Previous](@previous)

 # Anatomy of a Test Class
 
 ## The End and the Beginning
 
 When Xcode runs unit tests, it invokes each test case method independently.
* Each method must prepare and clean up any auxiliary variables, structures, and objects it needs.
* The *setUp* and *tearDown* methods are called before and after each test case method is invoked
* Here is where you are meant to create SUT (System Under Test) objects so that all of the test classes can be invoked with a clean slate

*/

import XCTest
import UIKit.UITextField

class ExampleTextClass:XCTestCase {

    var textField: UITextField!
    var session: URLSession!
    
 override func setUp() {
     super.setUp()
     // Put setup code here. This method is called before the invocation of each test method in the class.
    textField = UITextField()
    session = URLSession(configuration: .default)
 }
 
 override func tearDown() {
     // Put teardown code here. This method is called after the invocation of each test method in the class.
    textField = nil
    session = nil
    
     super.tearDown()
 }
/*:
     
 ## The Stuff Inbetween
     
 There two main types of test available, those that test for correctness (functional test case) & those that test the performance (performance test case)
 * Two examples of this are shown in the boiler plate code
 * `testExample` and `testPerformanceExample`
*/
    
 func testExample() {
     // This is an example of a functional test case.
     // Use XCTAssert and related functions to verify your tests produce the correct results.
 }
 
 func testPerformanceExample() {
         // This is an example of a performance test case.
     self.measure {
         // Put the code you want to measure the time of here.
     }
 }
/*:
 - IMPORTANT: A test method’s name always begins with test, followed by a description of what it tests. For example; testURLEncoding, testTemperatureConversion
 
 ## Test Format/Flow
     
 It’s good practice to format the test into **given**, **when** and **then** sections:
 * The **given** section sets up the environment for the test by creating model objects or bringing the system under test to a certain state.
 * The **when** section contains the code we want to test. In most cases, this is only one method call.
 * In the **then** section, we check the result of our action: Did we get the desired output? Was the object changed? This section consists mainly of assertions
*/

 func testDecimalAddition() {
 
     // Given
     let five = Decimal(floatLiteral: 5.0)
     let seven = Decimal(floatLiteral: 7.0)
 
     // When
     let result = five + seven
 
     // Then
     XCTAssertEqual(Decimal(floatLiteral: 12.0), result)
     //XCTAssertEqual(result, Decimal(floatLiteral: 12.0))
 
 }

/*:
 
 # Test/Assertion Macros
 
 - IMPORTANT:
 All test macros have a final parameter which is a string that gets printed out if the assertion fails
 
 - NOTE:
 All the examples shown are set to fail on purpose so that you can have an idea if failing/negative conditions
 
 ## Boolean Assertions
 Test a condition that generates a true or false result.

 Asserts that an expression is `true`.
*/
func testSwitchIsOn() {
    let isOn = false
    
    //XCTAssert(isOn, "The Switch is Off")
    XCTAssertTrue(isOn, "The Switch is Off")

}
/*:
 Asserts that an expression is `false`.
*/
    
func testEmptyTestField() {
    let textField = UITextField()
    
    let isEmpty = textField.text!.isEmpty
    
    XCTAssertFalse(isEmpty, "The textfield contains no characters")
}
 
/*:
 ## Nil and Non-nil Assertions
 Check whether a test condition is nil or non-nil.
 
 Asserts that an expression is `nil`.
*/
func testURLCreation() {
    let str = "https://www.google.co.uk"
    let url = URL(string: str)
    
    XCTAssertNil(url, "Created a valid URL using \(str)")
}
/*:
 Asserts that an expression is not `nil`.
 */
func testFalseURLCreation() {
    let str = "ABS!@#"
    let url = URL(string: str)
    
    XCTAssertNotNil(url, "Unable to create a valid URL from \(str)")
}
/*:
 
 ## Equality and Inequality Assertions
 Check whether two values are equal or unequal.
 
 Asserts that two expressions have the same value.
 */
func testCannotAdd() {
    let five = 5
    let seven = 7
    XCTAssertEqual(five, seven, "The values are different")
}
/*:
 Asserts that two expressions do not have the same value.
*/
func testQuickMaths () {
    let FIVE = 5
    let five = 5
    
    XCTAssertNotEqual(FIVE, five, "The values are equal")
}
/*:
 Asserts that two expressions have the same value within a certain accuracy.
*/
func testRoughlyTheSame() {
    let NOT_PI = 6.142
    let delta = 0.01
    // onevalue = 1.000000000000000001
    // anotherVale = 1.00000000000000000
    
    // If Double.pi (3.14) is plus or minus 0.01 to 6.142
    XCTAssertEqual(Double.pi, NOT_PI, accuracy: delta, "The values given are not with \(delta) of each other")
}
/*:
 Asserts that two expressions do not have the same value within a certain accuracy.
*/
func testRoughlyNotTheSame() {
    let PI = 3.142
    let epsilon = 0.01
    XCTAssertNotEqual(Double.pi, PI, accuracy: epsilon, "The values given are within \(epsilon) of each other")
}
/*:
 ## Comparable Value Assertions
 Compare two values to determine whether one is larger or smaller than the other
 
 Asserts that one value is greater than another.
 */
func testGreaterThan() {
    let five = 5
    let zero = 0
    XCTAssertGreaterThan(zero, five, "Exp A is not greater than Exp B")
}
/*:
 Asserts that one value is greater than or equal to another.
*/
func testGreatherThanOrEqual() {
    let five = 5
    let zero = 0
    XCTAssertGreaterThanOrEqual(zero, five, "Exp A is not greater than (or equal to) Exp B")
}
/*:
 Asserts that one value is less than or equal to another.
*/
func testLessThanOrEqual() {
    let five = 5
    let zero = 0
    XCTAssertLessThanOrEqual(five, zero, "Exp A is not less than (or equal to) Exp B")
}
/*:
 Asserts that one value is less than another.
*/
func testLessThan() {
    let five = 5
    let zero = 0
    XCTAssertLessThan(five, zero, "Exp A is not less than Exp B")

}
/*:
 ## Error Assertions
 Check whether a function call throws (or does not throw) an error
 
 Asserts that an expression throws an error.
*/
func testThrowsError() {
    let data = "{ \"Sample\" : \"Text\" }".data(using: .utf8)!
    XCTAssertThrowsError(try JSONSerialization.jsonObject(with: data, options: []), "No Error Thrown")
}
/*:
 Asserts that an expression throws does not throw an error.
*/
func testDoesNotThrowError() {
    let fakeData = "Not a JSON Object".data(using: .utf8)!
    XCTAssertNoThrow(try JSONSerialization.jsonObject(with: fakeData, options: []), "Error Thrown")
}
/*:
 
 ## Failing Unconditionally
     
 Generates a failure immediately and unconditionally.
*/
func testYouShallNotPass() {
    XCTFail("Crashing our app 100% of the time, all the time")
}

}
/*:
 [Next](@next)
*/
