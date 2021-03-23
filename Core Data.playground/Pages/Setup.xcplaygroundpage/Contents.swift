//: [Previous](@previous)
/*:
 ## Setting Up CoreData
 
 ![Add CoreData to Project](add_core_data.png "Add CoreData to Project")
 
 ## Exploring Files and Folders
 
 * The project includes a file that may be new to you, `*.xcdatamodeld`.
 * This is the data model which was talked about previously. We are going to explore this later on
 
 ## Exploring the Application Delegate
 
 * More interesting is the implementation of the `AppDelegate` class.
 * Open **AppDelegate.swift** and take a moment to see what Xcode has added for us when we checked the Use Core Data checkbox during the project setup.
 * The first detail worth noting is the import statement for the Core Data framework at the top.
 */
import UIKit
import CoreData
/*:
 
 The other interesting bits are the `lazy` stored property, `persistentContainer`, of type `NSPersistentContainer` and the `saveContext()` helper method.
 */
// MARK: - Core Data stack
class AppDelegate {
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Core_Data")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
/*:
 
 * The `NSPersistentContainer` instance is initialized by invoking a convenience initializer, init(name:), passing in the name of the data model, Core_Data.
 * Notice that there is no explicit instantiation of `NSManagedObjectModel`, `NSPersistentStoreCoordinator`, or `NSManagedObjectContext`.
 * This is abstracted away by the `NSPersistentContainer` class.
 ```
 let container = NSPersistentContainer(name: "Core_Data")
 ```
 * A Core Data stack without a persistent store isn't terribly useful. After initializing the persistent container, the persistent store is loaded by invoking the `loadPersistentStores(completionHandler:)` method.
 * It accepts one parameter, a closure, which is invoked when loading of the persistent store is completed, successfully or unsuccessfully. The closure accepts two parameters, an instance of the `NSPersistentStoreDescription` class and an optional `Error` object.
 ```
 container.loadPersistentStores(completionHandler: { (storeDescription, error) in
     if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
     }
 })
 ```
 * The `NSPersistentStoreDescription` class is another new addition to the Core Data framework. It encapsulates the information and configuration to add a persistent store to the persistent store coordinator.
 * As the name of the class implies, it describes a persistent store.
 
 ### What Is a Persistent Container?
 
 * As I already mentioned, the `NSPersistentContainer` class encapsulates the Core Data stack and it is available as of iOS 10, tvOS 10, macOS 10.12, and watchOS 3.
 * It makes setting up a Core Data stack easier than ever, providing developers with a simple setup with some flexibility.
 * After creating an instance of the `NSPersistentContainer` class, you can easily access the managed object model and the persistent store coordinator through the `managedObjectModel` and `persistentStoreCoordinator` properties.
 ```
 persistentContainer.managedObjectModel
 persistentContainer.persistentStoreCoordinator
 ```
 * The class also provides easy access to a `viewContext` property, an instance of the `NSManagedObjectContext` class that operates on the main queue.
 * As the name of the property implies, this managed object context is designed to be used in combination with the application's user interface.
 ```
 persistentContainer.viewContext
 ```
 ## Saving Changes
 
 * The application template also includes a helper method to save the changes of the managed object context.
 * In this method, we access the managed object context of the persistent container through the viewContext property.
 
 * We check if the managed object context has any changes by inspecting the value of the `hasChanges` property.
 * To save the changes of the managed object context, we invoke `save()` on the managed object context.
 * Because this method is throwing, we wrap it in a do-catch statement.
```
func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
```
 */
//: [Next](@next)
