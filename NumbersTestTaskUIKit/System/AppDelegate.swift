//
//  AppDelegate.swift
//  NumbersTestTaskUIKit
//
//  Created by Anton Korchevskyi on 14.09.2025.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Private Variables
    private var appCoordinator: AppCoordinator?
    
    // MARK: - Public Variables
    var window: UIWindow?
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NumberInfoDataModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("CORE DATA ERROR - \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        prepareWindowAndAppCoordinator()
        
        return true
    }
    

}

// MARK: - CoreData
 extension AppDelegate {

    func applicationDidEnterBackground(_ application: UIApplication) {
        saveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveContext()
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - Coordinator
private extension AppDelegate {
    
    func prepareWindowAndAppCoordinator() {
        let window = UIWindow()
        let navigationController = UINavigationController()
        
        appCoordinator = CoordinatorFactory().makeAppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
        
        window.overrideUserInterfaceStyle = .light
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}
