//
//  AnimalTabGroupContainer.swift
//  AnimalIDAppiOSNew
//
//  Created by jason debottis on 5/22/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit

class AnimalTabGroup: UIView {
    let kBASE_YVAL:CGFloat = 150
    let kTOUCHWIDTH = 50
    let kTOUCHHEIGHT = 110
    
    var tap = UITapGestureRecognizer()
    var activityIndicator = UIActivityIndicatorView()
    
    var bTab = CGRect()
    var rTab = CGRect()
    var iTab = CGRect()
    
    var birdTab:BaseTab?
    var reptileTab:BaseTab?
    var insectTab:BaseTab?
    
    var Tabs = [BaseTab]()
    var Animals = [Animal]()
    
    var Folder = UIImageView()
    var parentViewController = UIViewController()
    enum tabTags: Int {
        case kBirdTab = 1
        case kReptileTab = 2
        case kIsectTab = 3
    }
    
    var overlayView = UIView()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        
        let tabFrame = CGRect(x: 0, y: 450, width: self.frame.width, height: self.frame.height)
        
        Folder = UIImageView(frame: CGRect(x: 0, y: 50, width: self.frame.width, height: self.frame.height))
        Folder.image = UIImage(named: "animalManillaCover")
        
        birdTab = BaseTab(frame: tabFrame,
                          tag: tabTags.kBirdTab.rawValue,
                          background: "birdTabBackground")
        
        reptileTab = BaseTab(frame: tabFrame,
                             tag: tabTags.kReptileTab.rawValue,
                             background: "reptileTabBackground")
        
        insectTab = BaseTab(frame: tabFrame,
                            tag: tabTags.kIsectTab.rawValue,
                            background: "insectTabBackground")
        
        birdTab!.isBeingShown = false
        reptileTab!.isBeingShown = false
        insectTab!.isBeingShown = false
        
        Folder.layer.zPosition = 2
        
        birdTab?.layer.zPosition = 1
        reptileTab?.layer.zPosition = 1
        insectTab?.layer.zPosition = 1
        
        birdTab!.center = CGPoint(x:birdTab!.center.x, y: 0)
        reptileTab!.center = CGPoint(x: birdTab!.center.x, y: birdTab!.center.y)
        insectTab!.center = CGPoint(x: birdTab!.center.x, y: birdTab!.center.y)
        
        bTab = CGRect(x: 0, y: 160, width: kTOUCHWIDTH, height: kTOUCHHEIGHT)
        rTab = CGRect(x: 0, y: 270, width: kTOUCHWIDTH, height: kTOUCHHEIGHT)
        iTab = CGRect(x: 0, y: 380, width: kTOUCHWIDTH, height: kTOUCHHEIGHT)
        
        self.overlayView.frame = self.frame
        self.overlayView.backgroundColor = UIColor.black
        self.overlayView.alpha = 0.5
        self.overlayView.layer.zPosition = 3
        
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.activityIndicator.center = self.overlayView.center
        self.activityIndicator.startAnimating()
        self.activityIndicator.layer.zPosition = 4
        
        self.addSubview(birdTab!)
        self.addSubview(reptileTab!)
        self.addSubview(insectTab!)

        self.addSubview(Folder)
        
        self.addSubview(self.overlayView)
        self.addSubview(self.activityIndicator)

        Tabs = [birdTab!, reptileTab!, insectTab!]
        
        self.tap = UITapGestureRecognizer(target: self, action: #selector(tabTapped))
        self.addGestureRecognizer(self.tap)
        
        self.getAnimals()
        //showTouchAreas()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, controller: UIViewController) {
        super.init(frame: frame)
    }
    
    func getAnimals() -> Void {
        let service = AnimalService()
        var birds = [Animal]()
        var reptiles = [Animal]()
        var insects = [Animal]()
        service.getAnimals("/animals", complete: { (jsonResult) in
            for i in 0..<jsonResult.count{
                
                let animalDict = jsonResult[i]
                let animal = Animal(jasonDict: animalDict as! NSDictionary)
                if animal.animalType.contains("Bird"){
                    birds.append(animal)
                }else if animal.animalType.contains("Reptile"){
                    reptiles.append(animal)
                }else if animal.animalType.contains("Insect"){
                    insects.append(animal)
                }
            }
        
            self.birdTab?.setAnimalData(birds)
            self.reptileTab?.setAnimalData(reptiles)
            self.insectTab?.setAnimalData(insects)
            
            self.overlayView.removeFromSuperview()
            self.activityIndicator.stopAnimating()
        }) { (error) in
            print("Error:\(error)")
        }
    }
    
    func showError(_ error: NSError) -> Void {
        let alertController = UIAlertController(title: "Error", message: "Failed to get animals:\(error.description)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            
        }
        alertController.addAction(okAction)
        self.parentViewController.show(alertController, sender: self)
    }
    
    func showTouchAreas() -> Void {
        var view = UIView()
        for i in 0..<4{
            switch i {
            case 0:
                view = UIView(frame: bTab)
                view.backgroundColor = UIColor.red
                
                break
            case 1:
                view = UIView(frame: rTab)
                view.backgroundColor = UIColor.blue
                break
            case 2:
                view = UIView(frame: iTab)
                view.backgroundColor = UIColor.purple
                break
            default:
                break
            }
            view.alpha = 0.8
            view.layer.zPosition = 5
            self.addSubview(view)
        }
    }
    
    func tabTapped() -> Void {
        
        let touchLocation = tap.location(in: self)
        if (bTab.contains(touchLocation) && !birdTab!.isBeingShown) {
            self.toggleTab(birdTab!)
        }
        else if(rTab.contains(touchLocation ) && !reptileTab!.isBeingShown){
            self.toggleTab(reptileTab!)
        }
        else if(iTab.contains(touchLocation ) && !insectTab!.isBeingShown){
            self.toggleTab(insectTab!)
        }
    }
    
    func setShown(_ tab: BaseTab) -> Void {
        
        switch tab.tag {
        case tabTags.kBirdTab.rawValue:
            birdTab!.isBeingShown = true
            break
        case tabTags.kReptileTab.rawValue:
            reptileTab!.isBeingShown = true
            break
        case tabTags.kIsectTab.rawValue:
            insectTab!.isBeingShown = true
            break
            
        default:
            break
        }
    }
    
    func setNotShown(_ tab: BaseTab) -> Void {
        
        switch tab.tag {
        case tabTags.kBirdTab.rawValue:
            birdTab!.isBeingShown = false
            break
        case tabTags.kReptileTab.rawValue:
            reptileTab!.isBeingShown = false
            break
        case tabTags.kIsectTab.rawValue:
            insectTab!.isBeingShown = false
            break
            
        default:
            break
        }
    }
    
    func showTab(_ tab: BaseTab) -> Void {
        
        UIView.animate(withDuration: 0.5, animations: {
            tab.center = CGPoint(x: tab.center.x - tab.frame.width, y: tab.center.y)
        }) { (finished) in
            tab.layer.zPosition = 3
            UIView.animate(withDuration: 0.5, animations: {
                tab.center = CGPoint(x: tab.center.x + tab.frame.width, y: tab.center.y)
            }) { (finished) in
                self.setShown(tab)
            }
        }
    }
    
    func hideTab(_ tab: BaseTab, completion:@escaping (_ finished: Bool) -> Void) -> Void {
        UIView.animate(withDuration: 0.5, animations: {
            tab.center = CGPoint(x: tab.center.x - tab.frame.width, y: tab.center.y)
        }) { (finished) in
            tab.layer.zPosition = 1
            UIView.animate(withDuration: 0.5, animations: {
                tab.center = CGPoint(x: tab.center.x + tab.frame.width, y: tab.center.y)
            }) { (finished) in
                completion(finished)
                self.setNotShown(tab)
            }
        }
    }
    
    func toggleTab(_ touchedTab: BaseTab) -> Void {
        if (birdTab?.isBeingShown == true) {
            hideTab(self.birdTab!, completion: { (finished) in
                if finished {
                    self.showTab(touchedTab)
                }
                
            })
        }else if (reptileTab?.isBeingShown == true) {
            hideTab(self.reptileTab!, completion: { (finished) in
                if finished {
                    self.showTab(touchedTab)
                }
            })
        }else if (insectTab?.isBeingShown == true) {
            hideTab(self.insectTab!, completion: { (finished) in
                if finished {
                    self.showTab(touchedTab)
                }
            })
        }else{
            self.showTab(touchedTab)
        }
    }
}









