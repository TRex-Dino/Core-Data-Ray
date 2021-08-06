//
//  SceneDelegate.swift
//  Chap3 DogWalk
//
//  Created by Dmitry on 05.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

//MARK: Key points
/*
 - The Core Data stack is made up of five classes:
 NSManagedObjectModel, NSPersistentStore,
 NSPersistentStoreCoordinator, NSManagedObjectContext and the
 NSPersistentContainer that holds everything together.
 - The managed object model represents each object type in
 your app's data model, the properties they can have, and the
 relationship between them.
 - A persistent store can be backed by a SQLite database (the
 default), XML, a binary file or in-memory store. You can also
 provide your own backing store with the incremental store
 API.
 - The persistent store coordinator hides the implementation
 details of how your persistent stores are configured and
 presents a simple interface for your managed object context.
 - The managed object context manages the lifecycles of the
 managed objects it creates or fetches. They are responsible
 for fetching, editing and deleting managed objects, as well as
 more powerful features such as validation, faulting and
 inverse relationship handling.
 */

