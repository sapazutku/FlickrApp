//
//  SceneDelegate.swift
//  FlickrApp
//
//  Created by utku on 11.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }

        setUpTabBar()
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
    
    // TODO: yeniden düzenle
// https://stackoverflow.com/questions/43961766/uinavigationcontroller-and-tabbarcontroller-programmatically-no-storyboards
    private func setUpTabBar() {
        let tabBarController = CustomTabBarController()
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    class CustomTabBarController: UITabBarController {
        override func viewDidLoad() {
            super.viewDidLoad()

            // Tab Bar Customisation
            tabBar.barTintColor = .gray
            tabBar.tintColor = .systemPink



            viewControllers = [
                createTabBarItem(tabBarTitle: "Home", tabBarImage: "house", viewController: HomeController()),
                createTabBarItem(tabBarTitle: "Search", tabBarImage: "magnifyingglass", viewController: SearchController()),
                createTabBarItem(tabBarTitle: "Profile", tabBarImage: "person", viewController: UserController())
            ]
        }

        func createTabBarItem(tabBarTitle: String, tabBarImage: String, viewController: UIViewController) -> UINavigationController {
            let navCont = UINavigationController(rootViewController: viewController)
            navCont.tabBarItem.title = tabBarTitle
            //system icon
            // if selected use "house.fill"

            navCont.tabBarItem.image = UIImage(systemName: tabBarImage)

            // Nav Bar Customisation
            
            navCont.navigationBar.isTranslucent = true
            
            // Nav Bar Title Customisation
            
            navCont.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20)!]
            
            
            

            return navCont
        }
    }


}

