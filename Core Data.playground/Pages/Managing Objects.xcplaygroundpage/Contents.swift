//: [Previous](@previous)
/*:
 
 ## Creating Managed Objects
 
 An NSManagedObject instance implements the basic behavior required of a Core Data model object.
 * The NSManagedObject instance requires two elements: an entity description (an NSEntityDescription instance) and a managed object context (an NSManagedObjectContext instance).
 * The entity description includes the name of the entity that the object represents and its attributes and relationships.
 * The managed object context represents a scratch pad where you create the managed objects.
 * The context tracks changes to and relationships between objects.
 
 ```
 let employee = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as! EmployeeMO
 ```
 
 However if you are using the PersistentCordinator (iOS 10+) you only need to do this
 ```
 let employee = EmployeeMO(context: managedObjectContext)
 ```
 
 ## Editing NSManagedObject
 
 Having created subclasses of `NSManagedObject`, we can edit the subclass as if it were a normal object
 ```
let employee = EmployeeMO(context: managedObjectContext)
employee.firstName = "John"
 ```
 
 ## Saving NSManagedObject Instances
 
 * The creation of NSManagedObject instances does not guarantee their persistence.
 * After you create an NSManagedObject instance in your managed object context, explicitly save that context to persist those changes to your persistent store.
 
```
 do {
    try managedObjectContext.save()
 } catch {
    fatalError("Failure to save context: \(error)")
 }
 ```
 
 * The call to save on the NSManagedObjectContext accepts a reference to an NSError variable and always returns either a success or a fail.
 * If the save fails, it is important to display the error condition so that it can be corrected.
 * The display of that error condition can be as simple as outputting the error to the console or as complicated as offering the error message to the user.
 * If the save method returns a success, the error variable does not need to be consulted.
 
 ## Fetching Objects
 
 Now that data is stored in the Core Data persistent store, you will use an `NSFetchRequest` to access that existing data. The fetching of objects from Core Data is one of the most powerful features of this framework.
 ```
 let employeesFetch = NSFetchRequest(entityName: "Employee")
 ```
 However this looks slighly different in form iOS 10 onwards
 ```
let employeesFetch = Employee.fetchRequest()
 ```
 * The executeFetchRequest:error: method has two possible results.
    * It either returns an Array object with zero or more objects, or it returns nil.
    * If nil is returned, you have received an error from Core Data and need to respond to it.
 * If the array exists, you receive possible results for the request even though the aArray may be empty.
 * An empty Array indicates that there were no records found.
 
 ```
 do {
    let fetchedItems = try managedObjectContext.fetch(employeesFetch)
 } catch let fetchError {
    print(fetchError)
 }
 ```
 
 ## Filtering Results
 
 The real flexibility in fetching objects comes in the complexity of the fetch request.
 * To begin with, you can add an NSPredicate object to the fetch request to narrow the number of objects being returned.
 * For example, if you only want Employee objects that have a `firstName` of Trevor, you add the predicate directly to `NSFetchRequest`:
 ```
 let firstName = "Trevor"
 fetchRequest.predicate = NSPredicate(format: "firstName == \(firstName)")
 ```
 - NOTE: A nice breakdown of how flexible `NsPredicate` is can be found on [NSHipster](https://nshipster.com/nspredicate/)
 */
//: [Next](@next)
