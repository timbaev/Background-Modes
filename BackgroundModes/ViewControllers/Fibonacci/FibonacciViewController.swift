//
//  FibonacciViewController.swift
//  BackgroundModes
//
//  Created by Timur Shafigullin on 14/01/2019.
//  Copyright © 2019 Timur Shafigullin. All rights reserved.
//

import UIKit

class FibonacciViewController: UIViewController {
    
    // MARK: - Nested Types
    
    fileprivate enum Constants {
        
        // MARK: - Type Properties
        
        static let playTitle = "PLAY"
        static let pauseTitle = "STOP"
    }
    
    // MARK: - Instance Properties
    
    @IBOutlet fileprivate weak var positionLabel: UILabel!
    @IBOutlet fileprivate weak var controlButton: UIButton!
    
    // MARK: -
    
    fileprivate var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    fileprivate var timer = Timer()
    fileprivate var position = 0
    
    // MARK: - Instance Methods
    
    @IBAction func onControlButtonTouchUpInside(_ sender: UIButton) {
        Log.i(sender.title(for: .normal) ?? "")
        
        if backgroundTask == .invalid {
            self.startCalculation()
            self.controlButton.setTitle(Constants.pauseTitle, for: .normal)
        } else {
            self.stopCalculation()
            self.controlButton.setTitle(Constants.playTitle, for: .normal)
        }
    }
    
    // MARK: -
    
    fileprivate func startCalculation() {
        self.startBackgroundTask()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] (timer) in
            guard let viewController = self else {
                return
            }
            
            let result = viewController.fib(viewController.position)
            
            switch UIApplication.shared.applicationState {
            case .active:
                viewController.positionLabel.text = "Position \(viewController.position) = \(result)"
                
            case .background:
                Log.i("Position \(viewController.position) = \(result)")
                
            case .inactive:
                break
            }
            
            viewController.position += 1
        })
    }
    
    fileprivate func stopCalculation() {
        self.position = 0
        
        self.timer.invalidate()
        
        self.endBackgroundTask()
    }
    
    fileprivate func startBackgroundTask() {
        self.backgroundTask = UIApplication.shared.beginBackgroundTask(expirationHandler: { [weak self] in
            self?.endBackgroundTask()
        })
    }
    
    fileprivate func endBackgroundTask() {
        Log.i("End Background Task")
        
        UIApplication.shared.endBackgroundTask(self.backgroundTask)
        
        self.backgroundTask = .invalid
    }
    
    // MARK: -
    
    fileprivate func fib(_ num: Int) -> Int {
        switch num {
        case Int.min...1: return max(0, num)
        default: return fib(num - 2) + fib(num - 1)
        }
    }
}
