//
//  ProfilePageViewController.swift
//  SwipeProfileViewer
//
//  Created by 송규섭 on 1/25/26.
//

import UIKit

class ProfilePageViewController: UIPageViewController {
    // MARK: - Properties
    private let profiles: [Profile]
    
    // MARK: - Initializer
    init(profiles: [Profile]) {
        self.profiles = profiles
        super.init(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
}

private extension ProfilePageViewController {
    func configure() {
        setInitialPage()
    }
    
    func setDataSource() {
        self.dataSource = self
    }
    
    func setInitialPage() {
        guard let initialVC = self.createProfileVC(0) else {
            return
        }
        self.setViewControllers(
            [initialVC],
            direction: .forward,
            animated: true
        )
    }
    
    func createProfileVC(_ index: Int) -> ProfileViewController? {
        guard (0 <= index) && (index < profiles.count) else { return nil }
        
        let vm = ProfileViewModel(profile: profiles[index])
        let vc = ProfileViewController(viewModel: vm)
        return vc
    }
}

extension ProfilePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? ProfileViewController else { return nil }
        guard let currentIndex = profiles.firstIndex(where: { $0.id == vc.id }) else { return nil }
        return createProfileVC(currentIndex - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? ProfileViewController else { return nil }
        guard let currentIndex = profiles.firstIndex(where: { $0.id == vc.id }) else { return nil }
        return createProfileVC(currentIndex + 1)
    }
}
