//
//  FetchDateFormatter.swift
//  BackgroundModes
//
//  Created by Timur Shafigullin on 15/01/2019.
//  Copyright © 2019 Timur Shafigullin. All rights reserved.
//

import Foundation

class FetchDateFormatter {
    
    // MARK: - Instance Properties
    
    static let shared = FetchDateFormatter()
    
    fileprivate var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .long
        
        return dateFormatter
    }
    
    // MARK: - Instance Methods
    
    func string(from date: Date) -> String {
        return self.dateFormatter.string(from: date)
    }
}
