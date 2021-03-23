/*:
[Previous](@previous)
 
 # UI Testing

 Xcode 7 introduced UI testing, which lets you create a UI test by recording interactions with the UI.
 UI testing works by finding an app’s UI objects with queries, synthesizing events, then sending them to those objects.
 The API enables you to examine a UI object’s properties and state in order to compare them against the expected state.
 
 
 Adding a new UI Tests to a project is very similar to adding unit tests.
 * To add a UI Test Target either;
    * Select the ‘Include UI Tests’ option when creating the project
    * Navigate to the test navigator (Press Command + 6), click the + button at the lower left corner, select *New UI Test Target…* from the menu, for an existing project

![UI Test Added](ui_tests.png "UI Tests Added")
 
 To inspect and insight UI elements and their hierarchy in app.
 * The developer of an application typically knows what UI elements have been built into app, but for testers and users of record-and-playback tools this is not always clear.
 * The whole point of using record-and-playback tools is that it makes creation of test script/UI-specific component interactions fast but also provides the higher level of abstraction of the whole UI.
 * This way testers or other members of team do not need specific information about native UI components but all this is accessible and available through tool.
 
 All UI details quickly traceable.
 * The record-and-playback tools provide quickly all details about the application’s UI layers, components and element-specific details.
 * These details include name, description, value and even code-specific attributes. Take xpath locators as an example.
 
 To record all manual interactions for the app.
 * Record-playback tools allow accurate (as user means those) interactions to be recorded and the right test script generated out of those actions.
 * Code itself in Xcode is quick to edit and user can do tweaks on recorded piece of code before running those on simulator, or preferably, on multiple devices simultaneously.

 ## UI Testing Class
 
* Implementing UI tests for iOS apps with XCUITest goes the same way as unit tests are done with XCTest. There are basically no differences in the programming model and the methodology used is pretty much the same as with XCTestCase.
 * The XCUIApplication is basically a proxy for an app that can be launched and terminated. User can tell the application to run in testing mode by defining app as a “Target Application” in Xcode target settings.
 * The XCUIElement is the actual UI element in an iOS application. With iOS applications, XCUIElement provides all the basics symbols and functions for UI element interactions. For example, gestures with XCTest include clicking UI elements (normal, double, pressing), interacting with the screen (swipe, pinch, zoom, rotate etc.).

 ## Xcode UI Test Recorder Usage
 
 * First, make sure you highlight a method that you want to record your test on. The record button can be found on bottom of the main editor screen and it will turn red (= test is recordable):
 * After you click the recording button the application will be compiled and started (on simulator or physical devices, based upon your preferences). Now, interact with the application’s UI will get all steps recorded and generated as Swift test snippet.
 * Note that if you haven’t highlighted the test method you want to record, the record button stays gray.
 * To run your recorded UI test simply hit the Test (Product -> Test) and your test will be executed against the application. After the run, you are provided with some of useful information about the run and some details of potential failures.

 ## 3rd Party UI Tools
 
 [Appium](https://appium.io)
 * Flexible and useable on both Android and iOS, and it works on native, hybrid and web applications
 * Uses JSONWireProtocol to engage with iOS applications using Selenium WebDriver
 
 [Calabash](https://github.com/calabash/calabash-ios)
 * Another X-platform framework that’s works well with Android & iOS
 * Tests are written in Cucumber which is very simple & easy to read for non tech people
 
 [Earlgrey](https://github.com/google/EarlGrey)
 * Open source framework form Google, and is used to test many native Google iOS apps
 * To some degree, it is the Espresso for iOS
 
 ## Continuous Integration

 * Continuous Integration (CI) is a development practice where developers integrate code into a shared repository frequently, preferably several times a day.
 * Each integration can then be verified by an automated build and automated tests. While automated testing is not strictly part of CI it is typically implied.
 * One of the key benefits of integrating regularly is that you can detect errors quickly and locate them more easily. As each change introduced is typically small, pinpointing the specific change that introduced a defect can be done quickly.
 
 * Continuous Integration Tools can be split into 2 types;
    * Self hosted servers like; [Xcode Server](https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/xcode_guide-continuous_integration/index.html), [Jenkins](https://jenkins.io) & [TeamCity](https://www.jetbrains.com/teamcity/)
    * Cloud based solutions like; [Travis CI](https://travis-ci.org), [Circle CI](https://circleci.com), [BuddyBuild](https://www.buddybuild.com) & [Bitrise](https://www.bitrise.io)
 
 There are multiple tools so challenge is which one to choose and evaluate why one one is better than other.

 [Next](@next)
 
 */
