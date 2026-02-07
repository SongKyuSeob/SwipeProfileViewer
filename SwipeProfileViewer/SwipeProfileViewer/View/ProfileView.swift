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
    
    private let gradientView: GradientOverlayView = {
        let view = GradientOverlayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryWhite
        label.font = .systemFont(ofSize: 28, weight: .bold)
        
        return label
    }()
    
    private let keywordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 6
        
        return stackView
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryWhite
        label.font = .systemFont(ofSize: 20, weight: .regular)
        
        return label
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
        
        nameLabel.text = profile.name
        setupKeywords(keywords: profile.keywords)
        bioLabel.text = "\"\(profile.bio)\""
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
    
    private func setupKeywords(keywords: [String]) {
        keywordStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        keywords.forEach {
            let keywordChip = ChipView(title: $0)
            keywordChip.translatesAutoresizingMaskIntoConstraints = false
            keywordStackView.addArrangedSubview(keywordChip)
        }
        
        layoutIfNeeded()
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
        [
            profileImageView,
            gradientView,
            nameLabel,
            keywordStackView,
            bioLabel,
            leftTapButton,
            rightTapButton
        ].forEach {
            containerView.addSubview($0)
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
            
            profileImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -76),
            profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            gradientView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            gradientView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.3),
            
            bioLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40),
            bioLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 28),
            bioLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -140),
            
            keywordStackView.bottomAnchor.constraint(equalTo: bioLabel.topAnchor, constant: -20),
            keywordStackView.leadingAnchor.constraint(equalTo: bioLabel.leadingAnchor),
            keywordStackView.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -40),
            
            nameLabel.bottomAnchor.constraint(equalTo: keywordStackView.topAnchor, constant: -20),
            nameLabel.leadingAnchor.constraint(equalTo: bioLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -40),
            
            leftTapButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            leftTapButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            leftTapButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            leftTapButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
            
            rightTapButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            rightTapButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            rightTapButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            rightTapButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
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
