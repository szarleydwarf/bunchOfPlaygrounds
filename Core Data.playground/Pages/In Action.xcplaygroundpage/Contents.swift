//: [Previous](@previous)
/*:
 ## How Does Core Data Work
 The heart of the Core Data stack is the **persistent store coordinator**. It is instantiated first when the Core Data stack is created.
 
 ![Fig 5](figure-5.jpg "")
 
 * But to create the persistent store coordinator, we need a managed object model. Why is that?
 * The persistent store coordinator needs to know what the data schema of the application looks like.
 
 ![Fig 6](figure-6.jpg "")
 
 * After setting up the persistent store coordinator and the managed object model, the workhorse of the Core Data stack is initialized, the managed object context.
 * Remember that a managed object context keeps a reference to the persistent store coordinator.
 
 ![Fig 7](figure-7.jpg "")
 
 * With the Core Data stack set up, the application is ready to use the framework to interact with the application's persistent store.
 * In most cases, your application interacts with the persistent store coordinator through the managed object context.
 
 ![Fig 8](figure-8.jpg "")
 
 * You will rarely, if ever, directly interact with the persistent store coordinator or the managed object model.
 * As I mentioned earlier, the `NSManagedObjectContext` class is the class you interact with most frequently.
 
 * The managed object context is used to create, read, update, and delete records.
 * When the changes made in the managed object context are saved, the managed object context pushes them to the persistent store coordinator, which sends the changes to the corresponding persistent store.
 
 ![Fig 9](figure-9.jpg "")
 
 * If your application has multiple persistent stores, the persistent store coordinator figures out which persistent store needs to store the changes of the managed object context.
 
 ##  NSPersistentContainer
 
 The `NSPersistentContainer` class is a wonderful addition to the framework.
 * It encapsulates the nitty-gritty details of setting up and managing a Core Data stack.
 * While that is nice, it doesn't mean you don't need to know how the Core Data stack does its work under the hood.
 
 By setting up a Core Data stack from scratch, which isn't rocket science, you learn everything you need to know about Core Data to correctly use the `NSPersistentContainer` class. It also prepares you for some of the problems you face down the road.
 
 In short, learn the ins and outs of the framework first and then decide if you want to use the `NSPersistentContainer` class in your projects.

 */
//: [Next](@next)
