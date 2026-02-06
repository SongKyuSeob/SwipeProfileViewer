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
    
    private let likeButtonBGView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 32
        
        return view
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(.heartFilled.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // 이미지 뷰가 버튼 크기에 맞춰지도록 설정
        button.imageView?.contentMode = .scaleAspectFit
        
        // 버튼 내부에 적절한 여백 주기 (40x40 내에서 이미지가 꽉 차지 않게)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
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
        [pageContainerView, likeButtonBGView].forEach {
            addSubview($0)
        }
        
        likeButtonBGView.addSubview(likeButton)
    }
    
    // MARK: - setStyles
    func setStyles() {
        backgroundColor = .primaryBackground
    }
    
    // MARK: - setConstraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            pageContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pageContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pageContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            pageContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -60),
            
            // TODO: - like button constraints
            likeButtonBGView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            likeButtonBGView.bottomAnchor.constraint(equalTo: pageContainerView.bottomAnchor, constant: 4),
            likeButtonBGView.widthAnchor.constraint(equalToConstant: 64),
            likeButtonBGView.heightAnchor.constraint(equalToConstant: 64),
            
            likeButton.centerXAnchor.constraint(equalTo: likeButtonBGView.centerXAnchor),
            likeButton.centerYAnchor.constraint(equalTo: likeButtonBGView.centerYAnchor, constant: 2),
            likeButton.widthAnchor.constraint(equalToConstant: 66),
            likeButton.heightAnchor.constraint(equalToConstant: 66),
        ])
    }
}

extension MainView {
    var likeButtonTapped: AnyPublisher<Void, Never> {
        likeButton.tapPublisher
    }
}
