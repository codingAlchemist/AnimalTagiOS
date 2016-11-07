//
//  Animal.swift
//  AnimalIDAppiOSNew
//
//  Created by jason debottis on 7/13/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit
@objc(Animal)
public class Animal: NSObject {
    var commonName = String()
    var scientificName = String()
    var image1 = String()
    var image2 = String()
    var image3 = String()
    
    var animalType = String()
    var naturalHistory = String()
    var shortDesc = String()
    
    override init() {
        super.init()
    }
    
    init(jasonDict: NSDictionary) {
        self.commonName = (jasonDict["common"]!) as! String
        self.scientificName = (jasonDict["latin"]!) as! String
        self.naturalHistory = (jasonDict["long"]!) as! String
        self.shortDesc = (jasonDict["short"]!) as! String
        self.animalType = (jasonDict["type"]!) as! String
        self.image1 = (jasonDict["image1"]!) as! String
        self.image2 = (jasonDict["image2"]!) as! String
        self.image3 = (jasonDict["image3"]!) as! String
    }
    
    init(common: String, latin:String) {
        self.commonName = common
        self.scientificName = latin
    }
    
    
}
