//
//  DurationFormatter.swift
//  BackgroundModes
//
//  Created by Timur Shafigullin on 14/01/2019.
//  Copyright © 2019 Timur Shafigullin. All rights reserved.
//

import Foundation

class DurationFormatter {
    
    // MARK: - Instance Properites
    
    static let shared = DurationFormatter()
    
    // MARK: - Instance Methods
    
    func string(from duration: TimeInterval) -> String {
        let time = NSInteger(duration)
        
        let seconds = time % 60
        let minutes = (time / 60) % 60
        
        return String(format: "%0.2d:%0.2d", minutes, seconds)
    }
}
