//: [Previous](@previous)
/*:
 
 ## Multithreaded
 
 Concurrency is the ability to work with the data on more than one queue at the same time.
 * If you choose to use concurrency with Core Data, you also need to consider the application environment.
 * For the most part, AppKit and UIKit are not thread-safe.
 
 ### Core Data, Multithreading, and the Main Thread
 
 In Core Data, the managed object context can be used with two concurrency patterns, defined by `NSMainQueueConcurrencyType` and `NSPrivateQueueConcurrencyType`.
 
 * `NSMainQueueConcurrencyType` is specifically for use with your application interface and can only be used on the main queue of an application.
 
 * The `NSPrivateQueueConcurrencyType` configuration creates its own queue upon initialization and can be used only on that queue.
    * Because the queue is private and internal to the `NSManagedObjectContext` instance, it can only be accessed through the `performBlock:` and the `performBlockAndWait:` methods.
 
 In both cases, the initialization of the `NSManagedObjectContext` instance is the same:
 
 ```
 // Part 1 - Creating the BGContext
 let managedObjectContext = NSManagedObjectContext(concurrencyType: privateQueueConcurrencyType)
 
 // Part 2 - Assigning it as a child of MOC
 managedObjectContext.parent = viewContext
 ```

 - NOTE: When you are using an `NSPersistentContainer`, the `viewContex`t property is configured as a `NSMainQueueConcurrencyType` context and the contexts associated with `performBackgroundTask:` and `newBackgroundContext` are configured as `NSPrivateQueueConcurrencyType`.
 
 ### Using a Private Queue to Support Concurrency
 
 In general, avoid doing data processing on the main queue that is not user-related.
 * Data processing can be CPU-intensive, and if it is performed on the main queue, it can result in unresponsiveness in the user interface.
 * If your application will be processing data, such as importing data into Core Data from JSON, create a private queue context and perform the import on the private context.

```
let jsonArray = … //JSON data to be imported into Core Data
let moc = … //Our primary context on the main queue

let privateMOC = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
privateMOC.parentContext = moc

privateMOC.performBlock {
    for jsonObject in jsonArray {
        let mo = … //Managed object that matches the incoming JSON structure
        //update MO with data from the dictionary
    }
    do {
        try privateMOC.save()
        moc.performBlockAndWait {
            do {
                try moc.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    } catch {
        fatalError("Failure to save context: \(error)")
    }
}
```
 
 This example can be further simplified when using an `NSPersistentContainer`:
```
let jsonArray = …
let container = self.persistentContainer
container.performBackgroundTask() { (context) in
    for jsonObject in jsonArray {
        let mo = EmployeeMO(context: context)
        mo.populateFromJSON(jsonObject)
    }
    do {
        try context.save()
    } catch {
        fatalError("Failure to save context: \(error)")
    }
}
```
 
 */

//: [Next](@next)
