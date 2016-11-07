//
//  AnimalInfoViewController.swift
//  AnimalTag
//
//  Created by jason debottis on 10/28/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit
import CoreData
class AnimalInfoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var NaturalHistoryTextView: UITextView!
    @IBOutlet weak var GalleryPageControl: UIPageControl!
    @IBOutlet weak var ImageGalleryScrollView: UIScrollView!
    @IBOutlet weak var ScientificName: UILabel!
    @IBOutlet weak var CommonName: UILabel!
    
    public var animal = Animal()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initAnimal()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initAnimal() -> Void {
        self.CommonName.text = self.animal.commonName
        self.ScientificName.text = self.animal.scientificName
        self.NaturalHistoryTextView.text = self.animal.naturalHistory
        
        let img1 = "\(Constants.baseUrl)app/public/\(animal.image1)"
        let img2 = "\(Constants.baseUrl)app/public/\(animal.image2)"
        let img3 = "\(Constants.baseUrl)app/public/\(animal.image3)"
        
        let image1 = GetGalleryImage(imageUrl: img1,xPos: 0)
        let image2 = GetGalleryImage(imageUrl: img2, xPos: 1)
        let image3 = GetGalleryImage(imageUrl: img3, xPos: 2)
        
        self.ImageGalleryScrollView.delegate = self
        self.ImageGalleryScrollView.isPagingEnabled = true
        self.ImageGalleryScrollView.contentSize = CGSize(width: self.ImageGalleryScrollView.frame.size.width * 3,
                                                         height: self.ImageGalleryScrollView.frame.size.height)
        self.ImageGalleryScrollView.addSubview(image1)
        self.ImageGalleryScrollView.addSubview(image2)
        self.ImageGalleryScrollView.addSubview(image3)
        
    }
    
    @IBAction func MakeFavorite(_ sender: Any) {
        
    }

    func GetGalleryImage(imageUrl: String, xPos: CGFloat) -> UIImageView {
        let galleryImageView = UIImageView(frame: CGRect(x: xPos * self.ImageGalleryScrollView.frame.size.width,
                                                         y: 0,
                                                         width: self.ImageGalleryScrollView.frame.size.width,
                                                         height: self.ImageGalleryScrollView.frame.size.height))
        let imageUrl = URL(string:imageUrl)
        do{
            let data = try Data(contentsOf: imageUrl!)
            galleryImageView.image = UIImage(data: data)
        }catch let error as NSError{
            print("Error getting image: \(error.description)")
        }
        return galleryImageView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = self.ImageGalleryScrollView.frame.size.width
        let offSet = self.ImageGalleryScrollView.contentOffset.x / pageWidth
        let page = lround(Double(offSet))
        self.GalleryPageControl.currentPage = page
    }
    
    
}
