//: [Previous](@previous)
/*:
 ## Creating Models
 
 Much of Core Data’s functionality depends on the schema you create to describe your application’s entities, their properties, and the relationships between them.
 * Core Data uses a schema called a managed object model — an instance of `NSManagedObjectModel`.
 
 - NOTE: In general, the richer the model, the better Core Data is able to support your application.
 
 ### Creating an Entity and Its Properties
 
 When you start a new project in Xcode and open the template selection dialog, select the Use Core Data checkbox. A source file for the Core Data model is created as part of the template. That source file will have the extension `.xcdatamodeld`.
 
 To create an entity
 
 1. Click Add Entity.
    * A new untitled entity appears in the Entities list in the navigator area.
 2. Select the new untitled entity.
 3. In the Entity pane of the Data Model inspector, enter the name of the entity, and press Return.
 
 To create attributes and relationships for the entity
 
 1. With the new entity selected, click the Add button (+) at the bottom of the appropriate section.
    * A new untitled attribute or relationship (generically referred to as a property) is added in the Attributes or Relationships section of the editor area.
 2. Select the new untitled property.
    * The property settings are displayed in the Relationship pane or Attribute pane of the Data Model inspector.
 3. Give the property a name, and press Return.
    * The attribute or relationship information appears in the editor area.
 
 ![Model Editor](model_editor.png "Model Editor")
 
 * At this point you have created an entity in the model, but you have not created any data.
 * Data is created later, when you launch your application.
 * These entities will be used in your application as the basis for the creation of managed objects (`NSManagedObject` instances).
 
 ### Defining an Entity
 
 Now that you have named your entity, you define it further in the Entity pane of the Data Model inspector
 
 ![Entity Inspector](Entity_Inspector.png "Entity Inspector")
 
 Entity Name and Class Name
 
 Note that the entity name and the class name (a subclass of NSManagedObject) are not the same.
 * The entity structure in the data model does not need to match the class hierarchy.
 * An entity name and a class name are required.
 
 Abstract Entities
 
 * Specify that an entity is abstract if you will not create any instances of that entity.
 * You typically make an entity abstract if you have a number of entities that all represent specializations of (inherit from) a common entity that should not itself be instantiated.
 
 Entity Inheritance
 
 * Entity inheritance works in a similar way to class inheritance; and is useful for the same reasons.
 * If you have a number of entities that are similar, you can factor the common properties into a superentity, also known as a parent entity.
 
 - NOTE: Be careful with entity inheritance when working with SQLite persistent stores. All entities that inherit from another entity exist within the same table in SQLite. This factor in the design of the SQLite persistent store can create a performance issue.
 
![Entity Inheritence](Entity_Inheritence.png "Entity Inheritence")
 
 ### Defining Attributes and Relationships
 
 * An entity’s properties are its attributes and relationships, including its fetched properties (if it has any).
 * Among other features, each property has a name and a type.
 * A property name cannot be the same as any no-parameter method name of [NSObject](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSObject/Description.html#//apple_ref/occ/cl/NSObject) or `NSManagedObject` — for example, you cannot give a property the name “description” (see [NSPropertyDescription](https://developer.apple.com/documentation/coredata/nspropertydescription)).
 
 ![Attribute Inspector](Attribute_Inspector.png "Attribute Inspector")
 
 Attributes
 
 To define an attribute, select it in the Core Data model editor and specify values in the Attribute pane of the Core Data Model inspector
 * Core Data natively supports a variety of attribute types, such as string, date, and integer
 
 * You can specify that an attribute is optional—that is, it is not required to have a value.
 * In general, however, avoid doing so, especially for numeric values.
 * Typically, you can get better results using a mandatory attribute with a default value—defined in the attribute—of 0.
 
 Relationships and Fetched Properties
 
 To define a relationship, select it in the Core Data model editor, and specify values in the Relationship pane of the Data Model inspector
 
![Relationship Inspector](Relationship_Inspector.png "Relationship Inspector")
 
 */
//: [Next](@next)
