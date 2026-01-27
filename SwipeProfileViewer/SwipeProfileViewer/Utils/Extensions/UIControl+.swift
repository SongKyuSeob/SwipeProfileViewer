//
//  UIControl+.swift
//  SwipeProfileViewer
//
//  Created by 송규섭 on 1/25/26.
//

import UIKit
import Combine

extension UIControl {
    func controlPublisher(for event: UIControl.Event) -> UIControl.EventPublisher {
        .init(control: self, event: event)
    }
    
    struct EventPublisher: Publisher {
        typealias Output = UIControl
        typealias Failure = Never
        
        let control: UIControl
        let event: UIControl.Event
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, UIControl == S.Input {
            let subscription = EventSubscription(control: control, event: event, subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }
        
        fileprivate class EventSubscription<EventSubscriber: Subscriber>: Subscription where EventSubscriber.Input == UIControl, EventSubscriber.Failure == Never {
            let control: UIControl
            let event: UIControl.Event
            var subscriber: EventSubscriber?
            
            init(control: UIControl, event: UIControl.Event, subscriber: EventSubscriber) {
                self.control = control
                self.event = event
                self.subscriber = subscriber
                
                control.addTarget(self, action: #selector(handleEvent), for: event)
            }
            
            func request(_ demand: Subscribers.Demand) {}
            
            func cancel() {
                subscriber = nil
                control.removeTarget(self, action: #selector(handleEvent), for: event)
            }
            
            @objc func handleEvent() {
                _ = subscriber?.receive(control)
            }
        }
    }
}
