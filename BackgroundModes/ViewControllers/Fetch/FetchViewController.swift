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
    
    // MARK: - Instance Methods
    
    @IBAction func onUpdateButttonTouchUpInside(_ sender: UIButton) {
        Log.i(sender.title(for: .normal) ?? "")
        
        self.applyFetch { [weak self] in
            self?.apply()
        }
    }
    
    // MARK: -
    
    func applyFetch(completion: () -> Void) {
        self.time = Date()
        
        completion()
    }
    
    func apply() {
        Log.i(self.time ?? "nil")
        guard self.displayLabel != nil else {
            return
        }
        
        if let time = self.time {
            self.displayLabel.text = FetchDateFormatter.shared.string(from: time)
        } else {
            self.displayLabel.text = "Not yet updated"
        }
    }
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.apply()
    }
}
