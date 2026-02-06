//
//  ProfileView.swift
//  SwipeProfileViewer
//
//  Created by 송규섭 on 1/25/26.
//

import UIKit
import Combine

final class ProfileView: UIView {
    // MARK: - Properties
    private var images: [UIImage] = []
    private var imageViewHeightConstraint: NSLayoutConstraint?
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.clipsToBounds = true
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let leftTapButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let rightTapButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let topIndicator: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        
        return stackView
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
    func update(with profile: Profile) {
        let loadedImages = profile.images.compactMap { imageName in
            return UIImage(named: imageName)
        }
        self.images = loadedImages
        
        applyCountToIndicator(count: profile.images.count)
        
        if let firstImage = images.first {
            displayImage(at: 0)
        }
        
        
    }
    
    func displayImage(at index: Int) {
        guard index >= 0 && index < images.count else { return }
        
        let targetImage = images[index]
        profileImageView.image = targetImage
        
        updateHeight(for: targetImage)
        updateIndicator(currentIndex: index)
    }
    
    private func updateHeight(for image: UIImage) {
        let aspectRatio = image.size.height / image.size.width
        
        imageViewHeightConstraint?.isActive = false
        imageViewHeightConstraint = profileImageView.heightAnchor.constraint(
            equalTo: profileImageView.widthAnchor,
            multiplier: aspectRatio
        )
        imageViewHeightConstraint?.isActive = true
    }
    
    private func applyCountToIndicator(count: Int) {
        topIndicator.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for _ in 0..<count {
            let barView = UIView()
            barView.backgroundColor = .clear
            barView.layer.cornerRadius = 2
            barView.layer.borderWidth = 1
            barView.layer.borderColor = UIColor.indicatorBorder.cgColor
            
            topIndicator.addArrangedSubview(barView)
            
            barView.widthAnchor.constraint(equalTo: barView.widthAnchor).isActive = true
        }
    }
    
    private func updateIndicator(currentIndex: Int) {
        for (index, view) in topIndicator.arrangedSubviews.enumerated() {
            view.backgroundColor = (index > currentIndex)
            ? .clear
            : .white
        }
    }
}

private extension ProfileView {
    // MARK: - configure
    func configure() {
        setHierarchy()
        setStyles()
        setConstraints()
    }
    
    // MARK: - setHierarchy
    func setHierarchy() {
        [containerView, topIndicator].forEach { addSubview($0) }
        [profileImageView, leftTapButton, rightTapButton].forEach { containerView.addSubview($0)
        }
    }
    
    // MARK: - setStyles
    func setStyles() {
        backgroundColor = .clear
    }
    
    // MARK: - setConstraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            topIndicator.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            topIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            topIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            topIndicator.heightAnchor.constraint(equalToConstant: 6),
            
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            leftTapButton.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            leftTapButton.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            leftTapButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            leftTapButton.widthAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 0.5),
            
            rightTapButton.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            rightTapButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
            rightTapButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            rightTapButton.widthAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 0.5),
        ])
    }
}

extension ProfileView {
    var leftTapped: AnyPublisher<Void, Never> {
        leftTapButton.tapPublisher
    }
    
    var rightTapped: AnyPublisher<Void, Never> {
        rightTapButton.tapPublisher
    }
}
