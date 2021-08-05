//
//  SceneDelegate.swift
//  Chap2 BowTies
//
//  Created by Dmitry on 04.08.2021.
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}


//MARK:  Key points
/*
 - Core Data supports different attribute data types, which determines
 the kind of data you can store in your entities and how much space
 they will occupy on disk. Some common attribute data types are
 String, Date, and Double.
 - The Binary Data attribute data type gives you the option of storing
 arbitrary amounts of binary data in your data model.
 - The Transformable attribute data type lets you store any object that
 conforms to NSSecureCoding in your data model.
 - Using an NSManagedObject subclass is a better way to work with a Core
 Data entity. You can either generate the subclass manually or let
 Xcode do it automatically.
 - You can refine the set entities fetched by NSFetchRequest using an
 NSPredicate.
 - You can set validation rules (e.g. maximum value and minimum
 value) to most attribute data types directly in the data model editor.
 The managed object context will throw an error if you try to save
 invalid data.

 */
