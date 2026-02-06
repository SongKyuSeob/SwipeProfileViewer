//
//  ViewController.swift
//  SwipeProfileViewer
//
//  Created by 송규섭 on 1/25/26.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: MainViewModel
    private let mainView = MainView()
    private lazy var pageViewController = ProfilePageViewController(profiles: viewModel.profiles)
    
    // MARK: - loadView
    override func loadView() {
        self.view = mainView
    }
    
    // MARK: - Initializer
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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

private extension MainViewController {
    func configure() {
        setupChildViewController()
        setBindings()
    }
    
    func setupChildViewController() {
        addChild(pageViewController)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        mainView.pageContainerView.addSubview(pageViewController.view)
        
        NSLayoutConstraint.activate([
            pageViewController.view.leadingAnchor.constraint(equalTo: mainView.pageContainerView.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: mainView.pageContainerView.trailingAnchor),
            pageViewController.view.topAnchor.constraint(equalTo: mainView.pageContainerView.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: mainView.pageContainerView.bottomAnchor),
        ])
        
        pageViewController.didMove(toParent: self)
    }
    
    func setBindings() {
        
    }
}
