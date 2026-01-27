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
    private(set) let profile: Profile
    
    // MARK: - Initializer
    init(profile: Profile) {
        self.profile = profile
    }
    
    // MARK: - Input, Output
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    // MARK: - transform
    func transform(_ input: Input) -> Output {
        return Output()
    }
}
