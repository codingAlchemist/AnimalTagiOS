//
//  BaseTab.swift
//  AnimalIDAppiOSNew
//
//  Created by jason debottis on 6/8/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit
protocol BaseTabDelegate {
    func cellSelected(animal: Animal)
}

class BaseTab: UIView, UITableViewDelegate, UITableViewDataSource, AnimalCellDelegate{
    
    var isBeingShown = Bool()
    var dataTable:UITableView? = nil
    var animalList = [Animal]()
    var backgroundImage = UIImageView()
    var parentController:UIViewController? = nil
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.dataTable?.delegate = self
        self.dataTable?.dataSource = self
    }
    
    init(frame: CGRect, tag: Int) {
        super.init(frame: frame)
        self.initTab(frame: frame, tag: tag, background: "", parentControllerIn: self.parentController!)
    }
    
    init(frame: CGRect , tag: Int, background:String){
        super.init(frame: frame)
        self.initTab(frame: frame, tag: tag, background: background, parentControllerIn: self.parentController!)
    }
    
    init(frame: CGRect , tag: Int, background:String, parentControllerIn: UIViewController){
        super.init(frame: frame)
        self.initTab(frame: frame, tag: tag, background: background, parentControllerIn: parentControllerIn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAnimalData(_ animals: [Animal]) -> Void {
        self.animalList = animals
        self.dataTable?.reloadData()
    }
    
    func initTab(frame: CGRect , tag: Int, background:String, parentControllerIn: UIViewController) -> Void {
        self.dataTable = UITableView(frame: CGRect(x: 30,y: self.frame.origin.y, width: 350, height: self.frame.size.height), style: .plain)
        self.dataTable?.register(AnimalTableCell.self, forCellReuseIdentifier: "AnimalCell")
        self.dataTable?.delegate = self
        self.dataTable?.dataSource = self
        self.backgroundImage = UIImageView(frame: self.frame)
        self.backgroundImage.image = UIImage(named: background)
        self.isBeingShown = false;
        self.parentController = parentControllerIn
        self.tag = tag
        self.addSubview(self.backgroundImage)
        self.addSubview((self.dataTable)!)
    }
    
    //MARK: tableview delegate
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (animalList.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell") as! AnimalTableCell
        if self.animalList.count > 0{
            let animal = self.animalList[indexPath.row]
            cell.setAnimal(animal)
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if self.animalList.count > 0{
            
        }
        print("Selected animal")
    }
    
    func cellTapped(animalSelected: Animal) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let animalinfo = storyBoard.instantiateViewController(withIdentifier: "animalinfo") as! AnimalInfoViewController
        animalinfo.animal = animalSelected
        self.parentController?.show(animalinfo, sender: self)
    }
}
