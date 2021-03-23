//: [Previous](@previous)
/*:
 ## FetchedResultsController
 
 Building an application like this works but is very messy
* The fetch request pulls all the data available, which can get bogged with large data sets
* The data needs to get synced constantly with the UI (adding, removing & editing)
 
 
 Introducing the `NSFectchedResultsController`
 
 Whenever a record is inserted, updated, or deleted in a managed object context, the managed object context posts a notification through notification center. A managed object context can post three types of notifications
 * `NSManagedObjectContextObjectsDidChangeNotification`: This notification is posted every time a record in the managed object context is inserted, updated, or deleted.
 * `NSManagedObjectContextWillSaveNotification`: This notification is posted by the managed object context before pending changes are committed to the backing store.
 * `NSManagedObjectContextDidSaveNotification`: This notification is posted by the managed object context immediately after pending changes have been committed to the backing store.
 
 ### Setting Up the FetchedResultsController
 
 When you initialize the fetch results controller, you provide four parameters:
 * A fetch request. This must contain at least one sort descriptor to order the results.
 * A managed object context. The controller uses this context to execute the fetch request.
 * Optionally, a key path on result objects that returns the section name. The controller uses the key path to split the results into sections (passing nil indicates that the controller should generate a single section).
 * Optionally, the name of the cache file the controller should use (passing nil prevents caching). Using a cache can avoid the overhead of computing the section and index information.

 ```
lazy var fetchedResultsController: NSFetchedResultsController = { () -> NSFetchedResultsController<Artist> in
    
    // Create a request to fetch ALL Artists
    let fetchRequest = Artist.fetchRequest() as NSFetchRequest<Artist>
    
    // Create sort decriptors to sort via age and firstName
    let ageSort = NSSortDescriptor(key: "age", ascending: true)
    let nameSort = NSSortDescriptor(key: "firstName", ascending: true)
    
    // Add the sort descriptors to the fetch request
    fetchRequest.sortDescriptors = [ageSort, nameSort]
 
     // Set the batch size
     fetchRequest.fetchBatchSize = 10
    
    let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                managedObjectContext: coreDataController.mainContext,
                                sectionNameKeyPath: nil,
                                cacheName: nil)
    
    frc.delegate = self
    
    return frc
}()
 ```
 * Notice how similar this code is to the initial data fetch
 * By setting a batch size we can optimize the fetch
 * Also we have the `NSFetchedResultsControllerDelegate`
 
 In the new `viewDidLoad()` we simply fetch the data using the fetch results controller
```
func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    do {
        try fetchedResultsController.performFetch()
    } catch {
        print(error.localizedDescription)
    }
}
 ```
 
 ### Integrating the Fetched Results Controller with the Table View Data Source
 
 After you integrate the initialized fetched results controller and have data ready to be displayed in the table view, you integrate the fetched results controller with the table view data source.
 
 The slight changes to our TableView configuration changes
 * `numberOfSections(in:)` now uses the sections returned by the FetchedResultsController
 ```
 func numberOfSections(in tableView: UITableView) -> Int {
 
     guard let sections = fetchedResultsController.sections else {
        fatalError("No sections in fetchedResultsController")
     }
 
     return sections.count
 }
 ```
 * `tableView(_:, numberOfRowsInSection:)` changes to query the fetchedResultsController
 ```
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
     guard let sections = fetchedResultsController.sections else {
        fatalError("No sections in fetchedResultsController")
     }
     let sectionInfo = sections[section]
     return sectionInfo.numberOfObjects
 }
 ```
 * `tableView(_:, cellForRowAt:)` has convenience method to help populate the cell, this will be helpful later on & it uses the `fetchedResultsController` to get the correct object
```
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
    
    let artist = fetchedResultsController.object(at: indexPath)
    
    update(cell, with: artist)
    
    return cell
}
```
 
 ### Handling Updates
 
As shown in each `UITableViewDataSource` method above, the integration with the fetched results controller is reduced to a single method call that is specifically designed to integrate with the table view data source.
 
 With the fetched results controller set up and ready to use, we need to implement the `NSFetchedResultsControllerDelegate` protocol.
 
 The protocol defines five methods, four of which are of interest to us:
 * controllerWillChangeContent(_:)
 * controllerDidChangeContent(_:)
 * controller(_:didChange:at:for:newIndexPath:)
 * controller(_:didChange:atSectionIndex:for:)
 
 The first and second methods tell us when the data the fetched results controller is managing will and did change. This is important to batch update the user interface. For example, it's perfectly possible that multiple changes occur at the same time. Instead of updating the user interface for every change, we batch update the user interface once every change has been made.

 ```
 func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
 }
 
 func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
 }
 ```

 * `beginUpdates` - Call this method if you want subsequent insertions, deletion, and selection operations (for example, cellForRowAtIndexPath: and indexPathsForVisibleRows) to be animated simultaneously.
 * `endUpdates` - You call this method to bracket a series of method calls that begins with `beginUpdates` and that consists of operations to insert, delete, select, and reload rows and sections of the table view.
 
 - NOTE: When you call `endUpdates`, UITableView animates the operations simultaneously.
 If you do not make the insertion, deletion, and selection calls inside this block, table attributes such as row count can become invalid
 
 ```
 func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
     switch type {
         case .insert:
             if let newIndexPath = newIndexPath {
                 tableView.insertRows(at: [newIndexPath], with: .fade)
         }
         case .delete:
             if let indexPath = indexPath {
                 tableView.deleteRows(at: [indexPath], with: .fade)
         }
         case .update:
             if let indexPath = indexPath {
                 tableView.reloadRows(at: [indexPath], with: .fade)
         }
         case .move:
             if let indexPath = indexPath, let newIndexPath = newIndexPath {
                 tableView.moveRow(at: indexPath, to: newIndexPath)
         }
         @unknown default:
             fatalError("@unknown default")
     }
 }
 ```
 
 There are four possible `NSFetchedResultsChange` values:
 * `.insert`
 * `.delete`
 * `.update`
 * `.move`
 
 The names are pretty self-explanatory. If the type is `.insert`, we tell the table view to insert a row at `newIndexPath`.
 
 Similarly, if the type is `.delete`, we remove the row at `indexPath` from the table view.
 
 If a record is updated, we update the corresponding row in the table view by invoking `tableView.reloadRow(at:with:)`
 
 If the change type is equal to `.move`, we remove the row at `indexPath` and insert a row at `newIndexPath` to reflect the record's updated position in the fetched results controller's internal data structure.
 
 In the fourth and final method, the fetched results controller reports changes to its section before changes to the fetched result objects.
 
 - NOTE: the type of change can ever be `NSFetchedResultsChange.insert` and `NSFetchedResultsChange.delete`.
```
 func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
 switch type {
     case .insert:
        tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
     case .delete:
        tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
     case .move:
        break
     case .update:
        break
     }
 }
 ```

 ## Deleting Objects
 
 Removing an object form CoreData is extremely simple
 
 ```
 let artist = fetchedResultsController.object(at: indexPath)
 
 fetchedResultsController.managedObjectContext.delete(artist)
 
 do {
     try fetchedResultsController.managedObjectContext.save()
 } catch {
    print(error)
 }
 ```
 
 - IMPORTANT: The context where you get the managedObject from must be the same context you remove it from and save or else it can cause issues
 
 ```
 let artist = fetchedResultsController.object(at: indexPath)
 
 let context = artist.managedObjectContext
 context.delete(artist)
 
 do {
    try context.save()
 } catch {
    print(error)
 }
 ```
 
 */
//: [Next](@next)
