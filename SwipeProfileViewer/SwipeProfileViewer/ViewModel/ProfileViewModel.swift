//
//  ProfileViewModel.swift
//  SwipeProfileViewer
//
//  Created by 송규섭 on 1/25/26.
//

import Foundation
import Combine

final class ProfileViewModel {
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    let profile: Profile
    private let currentIndex = CurrentValueSubject<Int, Never>(0)
    
    // MARK: - Initializer
    init(profile: Profile) {
        self.profile = profile
    }
    
    // MARK: - Input, Output
    struct Input {
        let viewWillAppear: AnyPublisher<Void, Never>
        let leftTapped: AnyPublisher<Void, Never>
        let rightTapped: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let currentIndex: AnyPublisher<Int, Never>
    }
    
    // MARK: - transform
    func transform(_ input: Input) -> Output {
        input.leftTapped
            .sink { [weak self] in
                guard let self else { return }
                let newIndex = currentIndex.value - 1
                guard newIndex >= 0 else { return }
                currentIndex.send(newIndex)
            }
            .store(in: &cancellables)
        
        input.rightTapped
            .sink { [weak self] in
                guard let self else { return }
                let newIndex = currentIndex.value + 1
                guard newIndex < profile.images.count else { return }
                currentIndex.send(newIndex)
            }
            .store(in: &cancellables)
        
        input.viewWillAppear
            .sink { [weak self] in
                guard let self else { return }
                currentIndex.send(0)
            }
            .store(in: &cancellables)
        
        return Output(
            currentIndex: currentIndex.eraseToAnyPublisher()
        )
    }
}
