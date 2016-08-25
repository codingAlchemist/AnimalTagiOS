//
//  StartViewController.swift
//  AnimalIDAppiOSNew
//
//  Created by jason debottis on 7/23/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, FloatingActionMenuDelegtae {
    var FabMenu = FloatingActionMenu()
    var animalsController = AnimalsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(FabMenu)
        FabMenu.frame = CGRect(x: self.view.frame.maxX - 200, y: self.view.frame.maxY - 200, width: 200, height: 200)
        FabMenu.delegate = self
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: FAB Menu Delegate methods
    
    func didTapMenuItemOne() {
        print("Tapped menu item one")
        self.animalsController = self.storyboard?.instantiateViewController(withIdentifier: "AnimalsViewController") as! AnimalsViewController
        self.show(animalsController, sender: self)
    }
    
    func didTapMenuItemTwo() {
        print("Tapped menu item two")
    }
    
    func didTapMenuItemThree() {
        print("Tapped menu item three")
    }
}
