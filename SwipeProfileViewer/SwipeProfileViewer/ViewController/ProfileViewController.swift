//
//  ProfileContentViewController.swift
//  SwipeProfileViewer
//
//  Created by 송규섭 on 1/25/26.
//

import UIKit
import Combine

class ProfileViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: ProfileViewModel
    private let profileView = ProfileView()
    private var cancellables = Set<AnyCancellable>()
    private(set) lazy var id = {
        return viewModel.profile.id
    }()
    
    // MARK: - loadView
    override func loadView() {
        self.view = profileView
    }
    
    // MARK: - Initializer
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

private extension ProfileViewController {
    func configure() {
        setHierarchy()
        setStyles()
        setConstraints()
        setBindings()
    }
    
    func setHierarchy() {
        
    }
    
    func setStyles() {
        
    }
    
    func setConstraints() {
        
    }
    
    func setBindings() {
        
    }
}
