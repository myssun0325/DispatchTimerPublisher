//
//  ViewController.swift
//  DispatchTimerPublisher
//
//  Created by Mason on 2023/06/07.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var publisher: Publishers.DispatchTimer!
    private var subscriptions = Set<AnyCancellable>()
    private var logger = TimeLogger(sinceOrigin: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeTimer(interval: .seconds(1), times: .max(6))
    }

    private func subscribeTimer(interval: DispatchTimeInterval, times: Subscribers.Demand) {
        publisher = Publishers.timer(interval: interval, times: times)
        
        publisher
            .sink { [weak self] time in
                guard let self else { return }
                print("Timer emits: \(time)", to: &self.logger)
            }.store(in: &subscriptions)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) { [weak self] in
//            self?.subscriptions.forEach { $0.cancel() }
//        }
    }

}

