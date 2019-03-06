//
//  FetchViewController.swift
//  BackgroundModes
//
//  Created by Timur Shafigullin on 15/01/2019.
//  Copyright © 2019 Timur Shafigullin. All rights reserved.
//

import UIKit

class FetchViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    @IBOutlet fileprivate weak var displayLabel: UILabel!
    @IBOutlet fileprivate weak var updateButton: UIButton!
    
    // MARK: -

    fileprivate var time: Date?

    // MARK: - Initializers

    deinit {
        self.unsubscribeFromBackgroundFetchNotification()
    }
    
    // MARK: - Instance Methods
    
    @IBAction private func onUpdateButttonTouchUpInside(_ sender: UIButton) {
        Log.i(sender.title(for: .normal) ?? "")
        
        self.apply(time: Date())
    }

    @objc private func didBackgroundFetchPerformed(_ notification: NSNotification) {
        guard let time = notification.object as? Date else {
            return
        }

        self.apply(time: time)

        NotificationCenter.default.post(name: .backgroundFetchSuccess, object: self)
    }
    
    // MARK: -

    private func subscribeToBackgroundFecthNotification() {
        self.unsubscribeFromBackgroundFetchNotification()

        NotificationCenter.default.addObserver(self, selector: #selector(self.didBackgroundFetchPerformed(_:)), name: .backgroundFetch, object: nil)
    }

    private func unsubscribeFromBackgroundFetchNotification() {
        NotificationCenter.default.removeObserver(self, name: .backgroundFetch, object: nil)
    }

    // MARK: -
    
    func applyFetch(completion: () -> Void) {
        self.time = Date()
        
        completion()
    }
    
    func apply(time: Date?) {
        Log.i(time ?? "nil")

        guard self.displayLabel != nil else {
            return
        }

        self.time = time
        
        if let time = self.time {
            self.displayLabel.text = FetchDateFormatter.shared.string(from: time)
        } else {
            self.displayLabel.text = "Not yet updated"
        }
    }
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.apply(time: nil)

        self.subscribeToBackgroundFecthNotification()
    }
}
