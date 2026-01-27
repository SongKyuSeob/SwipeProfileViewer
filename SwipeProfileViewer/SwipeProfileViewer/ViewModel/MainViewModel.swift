//
//  MainViewModel.swift
//  SwipeProfileViewer
//
//  Created by 송규섭 on 1/27/26.
//

import Foundation
import Combine

final class MainViewModel {
    // MARK: - Properties
    private(set) var profiles: [Profile]
    
    // MARK: - Initializer
    init(profiles: [Profile]) {
        self.profiles = profiles
    }
    
    // MARK: - Input, Output
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
    }
    
    struct Output {
        
    }
    
    // MARK: - transform
    func transform(input: Input) -> Output {
        
        return Output( )
    }
}
