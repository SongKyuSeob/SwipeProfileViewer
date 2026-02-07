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
    lazy var id = viewModel.profile.id
    
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
}

private extension ProfileViewController {
    func configure() {
        setBindings()
        setInitialValues()
    }
    
    func setInitialValues() {
        profileView.update(with: viewModel.profile)
    }
    
    func setBindings() {
        let input = ProfileViewModel.Input(
            viewWillAppear: viewWillAppearSubject.eraseToAnyPublisher(),
            leftTapped: profileView.leftTapped,
            rightTapped: profileView.rightTapped
        )
        let output = viewModel.transform(input)
        
        output.currentIndex
            .receive(on: DispatchQueue.main)
            .sink { [weak self] index in
                guard let self else { return }
                profileView.displayImage(at: index)
            }
            .store(in: &cancellables)
    }
}
