/*:

 # Unit Tests Basics
 
 ## What to Test?
 
 Before writing any tests, it’s important to start with the basics: what do you need to test? If your goal is to extend an existing app, you should first write tests for any component you plan to change.
 More generally, tests should cover:
 * Core functionality: model classes and methods, and their interactions with the controller, custom algorithms
 * The most common UI workflows: General user usage, most common functionality
 * Boundary conditions: Empty text boxes, maximum text in labels, etc
 * Negative conditions: No network connectivity, negative numbers, nil objects, etc
 * Bug fixes
 
 ## First Things F.I.R.S.T​.

 The acronym *F.I.R.S.T*. describes a concise set of criteria for effective unit tests. Those criteria are:
 * **Fast**: Tests should run quickly, so people won’t mind running them.
 * **Independent/Isolated**: Tests should not do setup or teardown for one another.
 * **Repeatable**: You should obtain the same results every time you run a test. External data providers and concurrency issues could cause intermittent failures.
 * **Self-validating**: Tests should be fully automated; the output should be either “pass” or “fail”, rather than a programmer’s interpretation of a log file.
 * **Timely**: Ideally, tests should be written just before you write the production code they test.
 
 Following the *F.I.R.S.T*.  principles will keep your tests clear and helpful, instead of turning into roadblocks for your app.
 
 Xcode unit-testing environment is based on the open-source *XCTest framework*.
 Previous versions included *SenTestingKit* and *OCUnit*
 This framework provides a set of classes and command-line tools that let you design test suites and run them on your code.
 
 [Next](@next)
*/
