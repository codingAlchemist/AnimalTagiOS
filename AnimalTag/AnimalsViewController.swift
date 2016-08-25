//
//  ViewController.swift
//  AnimalIDAppiOSNew
//
//  Created by jason debottis on 5/22/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit

class AnimalsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let AnimalTabs = AnimalTabGroup(frame: self.view.bounds)
        self.view.addSubview(AnimalTabs)
        
        self.navigationItem.title = "Animals"
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

