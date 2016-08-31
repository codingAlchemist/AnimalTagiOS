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
    var shortDescLabel = UILabel()
    
    var nameStackView = UIStackView()
    
    let textFrame = CGRect(x: 0, y: 0, width: 200, height: 20)
    let imageFragme = CGRect(x: 0, y: 0, width: 20, height: 20)
    let shortTextFrame = CGRect(x: 0, y: 0, width: 200, height: 50)
    
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
        self.shortDescLabel.text = animal.shortDesc;
        let urlString = "\(Constants.baseUrl)app/public/\(animal.image1)"
        let url = URL(string:urlString)
        do{
            let data = try Data(contentsOf: url!)
            self.animalImage.image = UIImage(data: data)
        }catch let error as NSError{
            print("Error getting image: \(error.description)")
        }
        
        
    }
    
    func prepareCell() -> Void {
        self.nameStackView.backgroundColor = UIColor.red
        self.nameStackView.alignment = .leading
        self.nameStackView.axis = .vertical
        self.nameStackView.spacing = 0;
    
        self.commonNameLabel.frame = textFrame
        self.commonNameLabel.font = UIFont.systemFont(ofSize: 12)
        
        self.scientificNameLabel.frame = textFrame
        self.scientificNameLabel.font = UIFont.systemFont(ofSize: 12)
        
        self.animalImage.frame = imageFragme
        
        self.shortDescLabel.frame = shortTextFrame
        self.shortDescLabel.font = UIFont.systemFont(ofSize: 12)
        
        self.commonNameLabel.textAlignment = .left
        self.scientificNameLabel.textAlignment = .left
        self.shortDescLabel.textAlignment = .left
        
        self.animalImage.backgroundColor = UIColor.blue
        
        self.nameStackView.addArrangedSubview(self.commonNameLabel)
        self.nameStackView.addArrangedSubview(self.scientificNameLabel)
        

        self.contentView.addSubview(self.nameStackView)
        self.contentView.addSubview(self.animalImage)
        self.contentView.addSubview(self.shortDescLabel)
        prepareContraints()
        
    }
    
    func prepareContraints() -> Void {
        
        self.commonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.scientificNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.animalImage.translatesAutoresizingMaskIntoConstraints = false
        self.shortDescLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.commonNameLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        self.commonNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.scientificNameLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        self.scientificNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        VisualConstraintHelper.makeConstraintWith(self.contentView,
                                                  children: ["image":self.animalImage, "labels":self.nameStackView],
                                                  constraint: "H:|-[image(50)]-[labels]-|")
        
        VisualConstraintHelper.makeConstraintWith(self.contentView,
                                                  children: ["image":self.animalImage],
                                                  constraint: "V:|-[image(50)]-|")
        
        VisualConstraintHelper.makeConstraintWith(self.contentView,
                                                  children: ["labels":self.nameStackView],
                                                  constraint: "V:|-[labels]-50-|")
        
        VisualConstraintHelper.makeConstraintWith(self.contentView,
                                                  children: ["short":self.shortDescLabel,
                                                             "labels":self.nameStackView],
                                                  constraint: "V:|-[labels]-[short]|")
        
        VisualConstraintHelper.makeConstraintWith(self.contentView,
                                                  children: ["short":self.shortDescLabel],
                                                  constraint: "H:|-[short]-|")


    }
}
