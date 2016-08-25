//
//  BaseTab.swift
//  AnimalIDAppiOSNew
//
//  Created by jason debottis on 6/8/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit
protocol BaseTabDelegate {
    func getAnimals()
}

class BaseTab: UIView, UITableViewDelegate, UITableViewDataSource{
    
    var isBeingShown = Bool()
    var dataTable = AnimalTable()
    var animalList = [Animal]()
    var backgroundImage = UIImageView()
    
    init(frame: CGRect, tag: Int) {
        super.init(frame: frame)
        self.tag = tag
        self.isBeingShown = false
        self.dataTable = AnimalTable(frame: CGRect(x: 50,y: 50, width: 350, height: self.frame.size.height), style: .plain)
        self.dataTable.register(AnimalTableCell.self, forCellReuseIdentifier: "AnimalCell")
        self.dataTable.delegate = self
        self.dataTable.dataSource = self
    }
    
    init(frame: CGRect , tag: Int, background:String){
        super.init(frame: frame)
        self.dataTable = AnimalTable(frame: CGRect(x: 30,y: self.frame.origin.y, width: 350, height: self.frame.size.height), style: .plain)
        self.dataTable.register(AnimalTableCell.self, forCellReuseIdentifier: "AnimalCell")
        self.dataTable.delegate = self
        self.dataTable.dataSource = self
        self.backgroundImage = UIImageView(frame: self.frame)
        self.backgroundImage.image = UIImage(named: background)
        self.isBeingShown = false;
        self.tag = tag
        self.addSubview(self.backgroundImage)
        self.addSubview(self.dataTable)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAnimalData(_ animals: [Animal]) -> Void {
        self.animalList = animals
        self.dataTable.reloadData()
    }
    
    //MARK: tableview delegate
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (animalList.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell") as! AnimalTableCell
        if self.animalList.count > 0{
            let animal = self.animalList[indexPath.row]
            cell.setAnimal(animal)
        }
        return cell
    }
    
}
