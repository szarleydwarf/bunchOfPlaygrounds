//: [Previous](@previous)
/*:
 # Test Driven Development (TDD)
 
 Test Driven Development (TDD) is a popular way to write software. The methodology dictates that you write tests before writing supporting code. While this may seem backward, it has some nice benefits:

 1. Tests provide documentation about how a developer expects the app to behave. This documentation stays current because test cases are updated alongside the code, which is great for developers who aren’t great at creating or maintaining documentation.
 1. Apps developed using TDD result in better code coverage. Tests and code go hand-in-hand, making extraneous, untested code unlikely.
 
 ## Red, Green & Refactor (RGR)
 The typical TDD flow can be described in the red-green-refactor cycle:

 ![Red Green Refactor Cycle](red_green_refactor.png "Red Green Refactor Cycle")
 
 It consists of:

 * `Red`: Writing a failing test.
 * `Green`: Writing just enough code to make the test pass.
 * `Refactor`: Cleaning up and optimizing your code.
 * Repeating the previous steps until you’re satisfied that you’ve covered all the use cases.
 
 ## TDD vs Traditional Testing
 
 TDD approach is primarily a specification technique. It ensures that your source code is thoroughly tested at confirmatory level.

 * With traditional testing, a successful test finds one or more defects. It is same as TDD. When a test fails, you have made progress because you know that you need to resolve the problem.
 * TDD ensures that your system actually meets requirements defined for it. It helps to build your confidence about your system.
 * In TDD more focus is on production code that verifies whether testing will work properly. In traditional testing, more focus is on test case design. Whether the test will show the proper/improper execution of the application in order to fulfill requirements.
 * In TDD, you achieve 100% coverage test. Every single line of code is tested, unlike traditional testing.
 * The combination of both traditional testing and TDD leads to the importance of testing the system rather than perfection of the system.
 * In Agile Modeling (AM), you should "test with a purpose". You should know why you are testing something and what level its need to be tested.
 
 ## Acceptance TDD and Developer TDD

 There are two levels of TDD

 1. `Acceptance TDD (ATDD)`: With ATDD you write a single acceptance test. This test fulfills the requirement of the specification or satisfies the behavior of the system. After that write just enough production/functionality code to fulfill that acceptance test. Acceptance test focuses on the overall behavior of the system. ATDD also was known as Behavioral Driven Development (BDD).
 2. `Developer TDD`: With Developer TDD you write single developer test i.e. unit test and then just enough production code to fulfill that test. The unit test focuses on every small functionality of the system. Developer TDD is simply called as TDD.
 The main goal of ATDD and TDD is to specify detailed, executable requirements for your solution on a just in time (JIT) basis. JIT means taking only those requirements in consideration that are needed in the system. So increase efficiency.
 
 ![Test Driven Development](TestDrivenD3.png "Test Driven Development")
 
*/
//: [Next](@next)
