//: [Previous](@previous)
/*:
 ## Settings Bundle
 
 Defaults Settings is another way of storing preferences and managing it using the “settings app” on a device
 
 A settings bundle contains files that describe the structure and presentation style of your preferences.
 
 The settings app using this information to create an entry for your app and to display custom preferences

 ### Creation
 
 ![Creating Settings Bundle](creatingSettingsBundle.png "Creating Settings Bundle")
 
 You can expand the settings Bundle node and select `Root.plist` to see the default preference provided in the template

 ![Settings Bundle Example](settings_bundle_example.png "Settings Bundle Example")
 
 ### Configuration
 
 List of common types of controls supported by the Settings app and how you might use each type
 
 ![Settings Configuration](settings_config.png "Setting Options")
 
 ### Hierarchical Preferences

 * You can organize the preferences in a hierarchy by defining multiple .plist files.
 * Each .plist file contains the set of preferences displayed on that page.
 * The app’s main preferences page will always be stored in a file called Root.plist
 * To specify a link between a parent page and a child page, you include a child pane control in the parent page.
 * A child pane control creates a row that, when tapped, displays a new page of settings. The File key of the child pane control identifies the name of the .plist file with the contents of the child page.
 * The Title key identifies the title of the child page; this title is also used as the text of the control used to display the child page.

 ![Hierarchical Preferences](hierarchical_preferences.png "Hierarchical Preferences")
 
 - NOTE: The Settings app automatically provides navigation controls on the child page to allow the user to navigate back to the parent page

 ### Reading & Writing
 
 The pList which powers the Setting bundle actually saves to the `UserDefaults`, so reading and writing to it is the same
 
 All you need to remember are the keys and the value types
 
 - IMPORTANT: When the app is first launched, these the values are not persisted to the `UserDefault`, which means that the user has to visit the Settings Bundle at least once for the values to exist in the `UserDefaults`
 
 - NOTE: The extension to `UserDefaults` below fixes said problem, make sure to call it form the AppDelegate
 
 ```
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
 // Override point for customization after application launch.
 
     UserDefaults.standard.registerSettingsBundle()
 
     return true
 }
 ```
 
*/
import Foundation

extension UserDefaults {
    
    func registerSettingsBundle(_ named: String = "Root") {
        
        // Get the Settings.bundle from within the main bundle
        if let settingsURL = Bundle.main.url(forResource: named, withExtension: "plist", subdirectory: "Settings.bundle"),
            
            // Get the path to this file
            let plistXML = FileManager.default.contents(atPath: settingsURL.path) {
            
            // Create a ref for the format
            var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
            
            do {
                
                // Serialise the data
                let settingsPlist = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:Any]
                
                // Get the correct set arrays values
                if let preferences = settingsPlist["PreferenceSpecifiers"] as? [[String:Any]] {
                    
                    // Loop through each item
                    for prefSpecification in preferences {
                        
                        // If there is a key and a value
                        if let key = prefSpecification["Key"] as? String, let value = prefSpecification["DefaultValue"] {
                            
                            //If key doesn't exists in userDefaults then register it, else keep original value
                            if self.value(forKey: key) == nil {  self.set(value, forKey: key)  }
                        }
                    }
                    
                    self.synchronize()
                }
                
            } catch {
                print("PropertyListSerialization.Error \(error.localizedDescription)")
            }
        }
    }
}
//: [Next](@next)
