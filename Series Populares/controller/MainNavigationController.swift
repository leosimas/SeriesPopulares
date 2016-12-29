//
//  MainNavigationController.swift
//  Series Populares
//
//  Created by SoSucesso on 12/29/16.
//  Copyright © 2016 Leonardo Simas. All rights reserved.
//

import UIKit

class MainNavigationController : UINavigationController {
    
    override func viewDidLoad() {
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor.hexStringToUIColor(hex: Colors.primary)
        UINavigationBar.appearance().tintColor = UIColor.white
        
        self.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white
        ]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
