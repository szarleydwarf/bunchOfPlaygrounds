/*:
 ## File Manager
 
 ### Sandbox
 
 Every iOS application has its own application sandbox.
 
 An application sandbox is a directory on the filesystem that is barricaded from the rest of the filesystem.
 
 Your application must stay in its sandbox, and no other application can access its sandbox.
 
 ![Sandbox](sandbox.png "Application Sandbox")
 
 *  your.app – The contents of your main bundle will all go here. This includes app icons, app binary, fonts, sounds, etc
 *  Documents/  - This folder is the destination for all user-created content
 *  Library/ - You use this directory to store cached files, user preferences, and so on.
 *  Library/Caches/ - The folder where you store data that your app can later re-create, if need be. The contents of this folder are not backed by iOS
 *  Library/Preferences/ - This folder contains the preferences that your app wants to remember.
 *  tmp/ - These temporary files that your app may create, download, and so on. For instance, you may download a few photos from a web service and store them in this folder in order to increase the performance of the application, so you wont have to re-download the images

 ### File Manager
 
 * FileManager – Offers a lot of file & folder related operations that you can do with iOS, right insider your apps
    * urls(for:_, in:_) instance method of `FileManager` class allows you to search for specific directories on the iOS file system
*/
import Foundation
import UIKit

let fileManager = FileManager.default //FileManager()

let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)

for url in urls {
    print("Found: \(url)")
}

// Found: file:///var/folders/jn/z3w56wrx0rqg0qsc930sgzdm0000gp/T/com.apple.dt.Xcode.pg/containers/com.apple.dt.playground.stub.iOS_Simulator.Data-Persistence-2F5B99E8-B560-486B-AF60-81546F18CF8B/Documents/

// Found: file:///Users/briantae/Library/Developer/CoreSimulator/Devices/6B734776-9D62-456E-AF14-2315F38FFF28/data/Containers/Data/Application/D2E61203-7501-4002-BA98-60F1474E1592/Documents/

// G.U.I.D
/*:
 
 ### File I/O
 
 Sometime we may need to create directories insde the given directories.
 
 For example one directory for images and another for videos
 
 */
func createDirectory(_ named: String) {
    
    let fileManager = FileManager.default
    
    let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
    
    if var documentDirectory = paths.first {
        
        documentDirectory.appendPathComponent(named)
        
        do {
            try fileManager.createDirectory(at: documentDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
}

/*:
 With the ability to create directories, we then need to read and write to directories
 */

func save(_ image: UIImage, fileName: String) {
    
    // 1. Set up the file manager
    let fileManager = FileManager.default
    let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
    
    // 2. Get the URL
    if var location = paths.first {
        
        // 3. Go to the right location/path
        location.appendPathComponent(fileName)
        
        // 4. Convert your object into binary data
        if let imageData = image.pngData() {
            
            // 5. Save the binary data
            fileManager.createFile(atPath: location.path, contents: imageData, attributes: nil)
        }
    }
}

func get(_ imageNamed: String) -> UIImage? {
    
    // 1. Setup the file manager
    let fileManager = FileManager.default
    let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
    
    // 2. Get the URL
    if var location = paths.first {
        
        // 3. Go to the correct file
        location.appendPathComponent(imageNamed)
        
        // 4. Check if the file exists
        if fileManager.fileExists(atPath: location.path) {
            
            do {
                // 5. Attempt to get the binary data
                let someData = try Data(contentsOf: location)
                
                // 6. Convert to the correct data type
                let image = UIImage(data: someData)
                return image
            } catch {
                print(error)
                return nil
            }
            
            //return UIImage(contentsOfFile: location.path)
        }
    }
    return nil
}
/*:
 Finally we need to remove files and folders
 */
func remove(_ file: String) {
    
    // 1. Setup the file manager
    let fileManager = FileManager.default
    let paths = fileManager.urls(for: .trashDirectory, in: .userDomainMask)
    
    // 2. Get the URL
    if var location = paths.first {
        
        // 3. Get the correct file
        location.appendPathComponent(file)
        
        do {
            // 3. Remove the file/folder
            try fileManager.removeItem(at: location)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
}

//: [Next](@next)
