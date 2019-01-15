//
//  MainTabBarController.swift
//  BackgroundModes
//
//  Created by Timur Shafigullin on 14/01/2019.
//  Copyright © 2019 Timur Shafigullin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Nested Types
    
    enum Tabs: Int {
        
        // MARK: - Enumeration Cases
        
        case audio
        case location
        case fibonacci
        case fetch
    }
}
