//
//  FloatingActionMenu.swift
//  AnimalTagiOS
//
//  Created by jason debottis on 7/29/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit
@objc protocol FloatingActionMenuDelegtae{
    func didTapMenuItemOne()
    func didTapMenuItemTwo()
    func didTapMenuItemThree()
}

class FloatingActionMenu: UIView {

    var controller = FloatingActionMenuItem()
    var menuItemOne = FloatingActionMenuItem()
    var menuItemTwo = FloatingActionMenuItem()
    var menuItemThree = FloatingActionMenuItem()
    
    var delegate:FloatingActionMenuDelegtae? = nil
    var tap = UITapGestureRecognizer()
    var menuOpen = Bool()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        controller = FloatingActionMenuItem(icon: "Main",
                                            buttonSize: .Large,
                                            buttonColor: UIColor.blue)
        
        menuItemOne = FloatingActionMenuItem(icon: "Animals",
                                             buttonSize: .Small,
                                             buttonColor: UIColor.blue)
        
        menuItemTwo = FloatingActionMenuItem(icon: "star.png",
                                             buttonSize: .Small,
                                             buttonColor: UIColor.blue)
        menuItemThree = FloatingActionMenuItem(icon: "tag",
                                               buttonSize: .Small,
                                               buttonColor: UIColor.blue)
        
        controller.center = CGPoint(x: 150, y: 150)
        menuItemOne.center = controller.center
        menuItemTwo.center = controller.center
        menuItemThree.center = controller.center
        
        tap = UITapGestureRecognizer(target: self, action: #selector(menuItemTapped))
        menuOpen = false
        
        self.addSubview(menuItemOne)
        self.addSubview(menuItemTwo)
        self.addSubview(menuItemThree)
        self.addSubview(controller)
        self.addGestureRecognizer(self.tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showTapped(button: FloatingActionMenuItem) -> Void {
        UIView.animate(withDuration: 0.1, animations: {
            button.changeButtonColor(color: UIColor.white)
        }){(finished) in
            button.changeButtonColor(color: UIColor.blue)
        }
    }
    
    func menuItemTapped() -> Void {
        let touchLocation = self.tap.location(in: self)
        
        if self.controller.frame.contains(touchLocation){
            FABControllerTapped()
        }else if self.menuOpen{
            if self.menuItemOne.frame.contains(touchLocation){
                self.showTapped(button: self.menuItemOne)
                delegate?.didTapMenuItemOne()
            }else if self.menuItemTwo.frame.contains(touchLocation){
                self.showTapped(button: self.menuItemTwo)
                delegate?.didTapMenuItemTwo()
            }else if self.menuItemThree.frame.contains(touchLocation){
                self.showTapped(button: self.menuItemThree)
                delegate?.didTapMenuItemThree()
            }
        }
    }
    
    func FABControllerTapped() -> Void {
        if menuOpen {
            
            UIView.animate(withDuration: 0.1, animations: {
                self.controller.transform = CGAffineTransform(rotationAngle: 0)
                self.animateMenuItemOne()
                self.animateMenuItemTwo()
                self.animateMenuItemThree()
            }) { (finished) in
                
            }
            menuOpen = false
        }else{
            UIView.animate(withDuration: 0.1, animations: {
                self.controller.transform = CGAffineTransform(rotationAngle: CGFloat(Float(-M_PI_4)))
                self.animateMenuItemOne()
                self.animateMenuItemTwo()
                self.animateMenuItemThree()
            }) { (finished) in
            }
            menuOpen = true

        }
    }
    
    func animateMenuItemOne() -> Void {
        if menuOpen {
            UIView.animate(withDuration: 0.1, animations: { 
                self.menuItemOne.center = CGPoint(x: self.menuItemOne.center.x, y: self.menuItemOne.center.y + 100)
                }, completion: { (finished) in
            })
        }else{
            UIView.animate(withDuration: 0.1, animations: {
                
                self.menuItemOne.center = CGPoint(x: self.menuItemOne.center.x, y: self.menuItemOne.center.y - 100)
                }, completion: { (finished) in
                    
            })
        }
    }
    
    func animateMenuItemTwo() -> Void {
        if menuOpen {
            UIView.animate(withDuration: 0.1, animations: {
                self.menuItemTwo.center = CGPoint(x: self.menuItemTwo.center.x + 80, y: self.menuItemTwo.center.y + 80)
                }, completion: { (finished) in
                    
            })
        }else{
            UIView.animate(withDuration: 0.1, animations: {
                self.menuItemTwo.center = CGPoint(x: self.menuItemTwo.center.x - 80, y: self.menuItemTwo.center.y - 80)
                }, completion: { (finished) in
                    
            })
        }
    }
    
    
    func animateMenuItemThree() -> Void {
        if menuOpen {
            UIView.animate(withDuration: 0.1, animations: {
                self.menuItemThree.center = CGPoint(x: self.menuItemThree.center.x + 100, y: self.menuItemThree.center.y)
                }, completion: { (finished) in
                    
            })
        }else{
            UIView.animate(withDuration: 0.1, animations: {
                self.menuItemThree.center = CGPoint(x: self.menuItemThree.center.x - 100, y: self.menuItemThree.center.y)
                }, completion: { (finished) in
                    
            })
        }
    }
    
}
