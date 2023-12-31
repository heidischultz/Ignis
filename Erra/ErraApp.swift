
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import CoreData


class AppDelegate: NSObject, UIApplicationDelegate {
    

    
    
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        let db = Database.database(url: "https://erra-swift-default-rtdb.firebaseio.com/")
        return true
    }
}

@main
struct ErraApp: App {
   
    let persistenceController = PersistenceController.shared
    
   
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
  
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                 .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
            
        }
    }
}
