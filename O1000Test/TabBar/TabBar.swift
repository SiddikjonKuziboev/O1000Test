//
//  TabBar.swift
//  O1000Test
//
//  Created by Kuziboev Siddikjon on 07/10/23.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
        setUpViewController()
    }
    
    private func setUpViewController() {
        self.viewControllers = [getPostsVC(), getSavedPostsVC()]
    }
    
    

}

//MARK: Posts & Saved
extension TabBar {
    
    private func getPostsVC()-> UIViewController {
        
        let vc = PostsVC()
        vc.tabBarItem.image = UIImage(systemName: "applelogo")
        vc.tabBarItem.title = "Posts"
        return vc
        
    }
    
    private func getSavedPostsVC()-> UIViewController {
        
        let vc = SavedPostsVC()
        vc.tabBarItem.image = UIImage(systemName: "folder")
        vc.tabBarItem.title = "Favorites"
        return vc
        
    }
}

//MARK: Navigation Bar
extension TabBar {
    
    private func setUpTabBar() {
        let itemAppearence = UITabBarItemAppearance()
        itemAppearence.normal.iconColor = .gray
        itemAppearence.selected.iconColor = .red
        itemAppearence.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        itemAppearence.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        
        let appearence = UITabBarAppearance()
        appearence.backgroundEffect = UIBlurEffect(style: .light)
        appearence.backgroundColor = .white
        
        appearence.stackedLayoutAppearance = itemAppearence
        appearence.inlineLayoutAppearance = itemAppearence
        appearence.compactInlineLayoutAppearance = itemAppearence
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearence
        } else {
            // Fallback on earlier versions
        }
        tabBar.standardAppearance = appearence
        
    }
    
}
