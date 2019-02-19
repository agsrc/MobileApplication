//
//  MenuViewController.swift
//  METRO EXPLORER
//
//  Created by Akshay Gupta on 12/13/18.
//  Copyright © 2018 Akshay Gupta. All rights reserved.
//

import UIKit


class MenuViewController:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // called after viewDidLoad
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    // doing for the root controller
    navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // notifies viewController that it's view was removed.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
