//
//  CustomTabBarController.swift
//  FlickrApp
//
//  Created by utku on 15.10.2022.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tab Bar Customisation
        
        tabBar.tintColor = .systemPink
        tabBar.backgroundColor = .white
        
        
        // View Controllers
        viewControllers = [
            createTabBarItem(tabBarTitle: "Home", tabBarImage: "house", viewController: HomeController()),
            createTabBarItem(tabBarTitle: "Search", tabBarImage: "magnifyingglass", viewController: SearchController()),
            createTabBarItem(tabBarTitle: "Profile", tabBarImage: "person", viewController: UserController())
        ]
    }
    func createTabBarItem(tabBarTitle: String, tabBarImage: String, viewController: UIViewController) -> UINavigationController {
        let navCont = UINavigationController(rootViewController: viewController)
        navCont.tabBarItem.title = tabBarTitle
        
        navCont.tabBarItem.image = UIImage(systemName: tabBarImage)
        
        // Nav Bar Customisation
        
        navCont.navigationBar.isTranslucent = true
        
        // Nav Bar Title Customisation
        
        navCont.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        
        return navCont
    }
}
