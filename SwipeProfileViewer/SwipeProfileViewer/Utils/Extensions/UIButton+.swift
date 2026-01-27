//
//  UIButton+.swift
//  SwipeProfileViewer
//
//  Created by 송규섭 on 1/25/26.
//

import UIKit
import Combine

extension UIButton {
    var tapPublisher: AnyPublisher<Void, Never> {
        controlPublisher(for: .touchUpInside)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
