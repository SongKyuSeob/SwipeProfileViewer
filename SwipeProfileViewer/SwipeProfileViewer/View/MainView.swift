//
//  MainView.swift
//  SwipeProfileViewer
//
//  Created by 송규섭 on 1/25/26.
//

import UIKit
import Combine

final class MainView: UIView {
    // MARK: - Properties
    
    // MARK: - UI Components
    let pageContainerView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "heart")
        config.baseForegroundColor = .white
        
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    // MARK: - Public Methods
}

private extension MainView {
    // MARK: - configure
    func configure() {
        setHierarchy()
        setStyles()
        setConstraints()
    }
    
    // MARK: - setHierarchy
    func setHierarchy() {
        [pageContainerView, likeButton].forEach {
            addSubview($0)
        }
    }
    
    // MARK: - setStyles
    func setStyles() {
        backgroundColor = .white
    }
    
    // MARK: - setConstraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            pageContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pageContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pageContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            pageContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60),
            
            // TODO: - like button constraints
        ])
    }
}

extension MainView {
    var likeButtonTapped: AnyPublisher<Void, Never> {
        likeButton.tapPublisher
    }
}
