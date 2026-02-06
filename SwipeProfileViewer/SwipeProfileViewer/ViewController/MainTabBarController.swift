//
//  MainTabBarController.swift
//  SwipeProfileViewer
//
//  Created by 송규섭 on 2/7/26.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
        setupViewControllers()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .primaryWhite
        tabBar.unselectedItemTintColor = .primaryWhite
        
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .clear
        
        // 선택된 아이템 스타일
        let itemAppearance = UITabBarItemAppearance()
        
        // 선택된 상태 - 흰색 아이콘 + 회색 배경
        itemAppearance.selected.iconColor = .white
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // 선택 안된 상태 - 흰색 아이콘
        itemAppearance.normal.iconColor = .white
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    private func setupViewControllers() {
        let mainVM = MainViewModel(profiles: MockProfiles.profiles)
        let swipeVC = MainViewController(viewModel: mainVM)
        swipeVC.tabBarItem = UITabBarItem(
            title: "SWIPE",
            image: UIImage(systemName: "hand.point.up"),
            tag: 0
        )
        
        let browseVC = UIViewController()
        browseVC.tabBarItem = UITabBarItem(
            title: "BROWSE",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 1
        )
        
        let likeVC = UIViewController()
        likeVC.tabBarItem = UITabBarItem(
            title: "LIKE",
            image: UIImage(systemName: "heart"),
            tag: 2
        )
        likeVC.tabBarItem.badgeValue = "99+" // 배지
        likeVC.tabBarItem.badgeColor = .primaryYellow
        
        let messageVC = UIViewController()
        messageVC.tabBarItem = UITabBarItem(
            title: "MESSAGE",
            image: UIImage(systemName: "paperplane"),
            tag: 3
        )
        
        let profileVC = UIViewController()
        profileVC.tabBarItem = UITabBarItem(
            title: "PROFILE",
            image: UIImage(systemName: "person"),
            tag: 4
        )
        
        viewControllers = [swipeVC, browseVC, likeVC, messageVC, profileVC]
        selectedIndex = 0
    }

}
