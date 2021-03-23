//: [Previous](@previous)
/*:
 
 ## Creating NSManagedObject Subclasses
 
 * By default, Core Data returns `NSManagedObject` instances to your application.
 * It is useful to define subclasses of `NSManagedObject` for each of the entities in your model.
 * Speciflcally, when you create subclasses of `NSManagedObject`, you can define the properties that the entity can use for code completion, and you can add convenience methods to those subclasses.
 
 To create a subclass of NSManagedObject, in the Xcode Core Data model editor, select the entity, and in the Entity pane of the Data Model inspector, enter the name in the Class field. Then create the subclass in Xcode.
 
 ### Oldschool (pre xcode 8)
 
 * Xcode has long the ability to create subclass files for CoreData entities for you
    * Editor -> Create NSManagedObject Subclass..

 ![Create Subclasses](create_subclass.png "Create Subclasses")
 
 * Xcode adds asubclass named after the entity and a category/extension on the subclass for the properties
    * EntityName+CoreDataClass.swift
    * EntityName+CoreDataProperties.swift
 
 However the developer has recreate these files for each entity that was changed/edited

 ### Newschool (post xcode 8)
 
 * Starting with Xcode 8 you can go an extra step & have Xcode automatically create the subclass & property files for the CoreData model entities.
 * Xcode will automatically sync the files with the model
 * The settings is per entity & has 3 settings:
    * Manual/None – This is pre Xcode 8 behavior. If you open an older project then this option is automatically set
    * Class Definition – As the previously described by Xcode creates and maintains these files automatically in the Derived Data for the project. Files **DO NOT** appear in the project directory or project navigator
    * Category/Extension – Xcode assumes that you want to manage the `NSManagedObject` subclass yourself & only creates the properties category/extension code

![Code Gen](codegen.png "Code Gen")
 
[Further Reading WWDC 2016 Session 242 - What's New in CoreData](https://developer.apple.com/videos/play/wwdc2016/242/)

 
 */
//: [Next](@next)
