
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Ignis")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // creating onboarding instance 
    func createOnboarding(isOnboardingCompleted: Bool, isAddressCompleted: Bool, uniqueIdentifier: String) {
        let viewContext = container.viewContext
        let newOnboarding = Onboarding(context: viewContext)
        newOnboarding.isOnboardingCompleted = isOnboardingCompleted
        newOnboarding.isAddressCompleted = isAddressCompleted
        newOnboarding.uniqueIdentifier = uniqueIdentifier
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}
