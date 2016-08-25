//
//  AnimalTableCell.swift
//  AnimalIDAppiOSNew
//
//  Created by jason debottis on 6/5/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit

class AnimalTableCell: UITableViewCell {
    var commonNameLabel = UILabel()
    var scientificNameLabel = UILabel()
    var animalImage = UIImageView()
    
    let textFrame = CGRect(x: 0, y: 0, width: 200, height: 20)
    let imageFragme = CGRect(x: 0, y: 0, width: 50, height: 50)
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareCell()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAnimal(_ animal: Animal) -> Void {
        self.commonNameLabel.text = "Common Name: \(animal.commonName)"
        self.scientificNameLabel.text = "Scientific Name: \(animal.scientificName)"
        let url = URL(string:Constants.baseUrl.appending(animal.image1) )
        do{
            let data = try Data(contentsOf: url!)
            self.animalImage.image = UIImage(data: data)
        }catch let error as NSError{
            print("Error getting image: \(error.description)")
        }
        
        
    }
    
    func prepareCell() -> Void {
        self.commonNameLabel.frame = textFrame
        self.scientificNameLabel.frame = textFrame
        self.animalImage.frame = imageFragme
        self.commonNameLabel.textAlignment = .left
        self.scientificNameLabel.textAlignment = .left
        self.animalImage.backgroundColor = UIColor.blue
        
        self.contentView.addSubview(self.commonNameLabel)
        self.contentView.addSubview(self.scientificNameLabel)
        self.contentView.addSubview(self.animalImage)
        prepareContraints()
        
    }
    
    func prepareContraints() -> Void {
        self.commonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.scientificNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.animalImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        let children = ["image":self.animalImage,
                        "common":self.commonNameLabel,
                        "latin":self.scientificNameLabel] as [String : Any]
        
        
        VisualConstraintHelper.makeConstraintWith(self.contentView,
                                                  children: children as! Dictionary<String, UIView>,
                                                  constraint: "H:|-10-[image(50)]-10-|")
        
        
        VisualConstraintHelper.makeConstraintWith(self.contentView,
                                                  children:children as! Dictionary<String, UIView>,
                                                  constraint: "V:|-10-[image(50)]-20-[common(20)]-[latin(20)]|")
        
        VisualConstraintHelper.makeConstraintWith(self.contentView,
                                                  children:children as! Dictionary<String, UIView>,
                                                  constraint: "H:|-10-[common]|")
        
        VisualConstraintHelper.makeConstraintWith(self.contentView,
                                                  children:children as! Dictionary<String, UIView>,
                                                  constraint: "H:|-10-[latin]|")

        
    }
}
