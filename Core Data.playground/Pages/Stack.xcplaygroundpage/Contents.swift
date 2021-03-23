//: [Previous](@previous)
/*:
 ## CoreData Stack
 
 ![CoreData Stack](stack_overview.jpg "CoreData Stack")
 
 ### Managed Object Model
 
 The managed object model is an instance of the `NSManagedObjectModel` class.
 * A typical Core Data application has one instance of the `NSManagedObjectModel` class, but it's possible to have multiple.
 * The `NSManagedObjectModel` instance represents the data model of the Core Data application.
 * This diagram shows that the managed object model is connected to the data model.
 * The data model is represented by a file in the application bundle that contains the data schema of the application.
 
 ![Managed Object Model](managed_object_model.jpg "Managed Object Model")
 
 The data schema is nothing more than a collection of entities. An entity can have attributes and relationships, which make up the data model of the application.
 
 ### Managed Object Context
 
A managed object context is represented by an instance of the `NSManagedObjectContext` class.
* A Core Data application has one or more managed object contexts.
* Each managed object context manages a collection of model objects, instances of the `NSManagedObject` class.
* The managed object context receives the model objects through a persistent store coordinator as you can see in this diagram. A managed object context keeps a reference to the persistent store coordinator of the application.
 
 ![Managed Object Context](managed_object_context.jpg "Managed Object Context")
 
 The managed object context is the object you interact with most. It creates, reads, updates, and deletes model objects. From a developer's perspective, the NSManagedObjectContext class is the workhorse of the Core Data framework.
 
 ### Persistent Store Coordinator
 The persistent store coordinator is represented by an instance of the `NSPersistentStoreCoordinator` class and it plays a key role in every Core Data application.
 
 ![Persistent Store Coordinator](persistent_store_coordinator.jpg "Persistent Store Coordinator")
 
  * The persistent store coordinator keeps a reference to the managed object model and every parent managed object context keeps a reference to the persistent store coordinator.
 
* Core Data manages an object graph. The framework is only useful if the persistent store coordinator is connected to one or more persistent stores.
* Out of the box, Core Data supports three persistent store types:
    * a SQLite database
    * a binary store
    * and an in-memory store
 
 Each persistent store type has its pros and cons. Most applications use a SQLite database as their persistent store. It's ideal for mobile and desktop applications.
*/
//: [Next](@next)
