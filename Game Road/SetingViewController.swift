//
//  SetingViewController.swift
//  Game Road
//
//  Created by admin on 8/22/20.
//  Copyright © 2020 Vitali Leikin. All rights reserved.
//

import UIKit

class SetingViewController: UIViewController {
    
    
    @IBOutlet  var CarPlayerImage: UIImageView!
    @IBOutlet weak var carDangerRightImage: UIImageView!
    @IBOutlet weak var carDangerLeftImage: UIImageView!
    
    var count = 0
    
    
    var arrayImage = ["car", "carTwo", "carThree"]
    
    var carPlayer: String = "car"
    var carRight: String = "carTwo"
    var carLeft: String = "carThree"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipe()
        
    }
    
    
    @IBAction func carPlayerNextButton(_ sender: UIButton) {
        carPlayer = stepNextImage(carImage: CarPlayerImage)
        
    }
    
    
    
    @IBAction func carDangerRightButton(_ sender: UIButton) {
        carRight = stepNextImage(carImage: carDangerRightImage)
        
    }
    
    
    @IBAction func carDangerLeftButton(_ sender: UIButton) {
        carLeft = stepNextImage(carImage: carDangerLeftImage)
        
    }
    
    
    
    
    @IBAction func saveChoiseButton(_ sender: UIButton) {
        saveResult()
        
    }
    
    
    
    func stepNextImage(carImage: UIImageView) -> String {
        
        count += 1
        if count > (arrayImage.count - 1){
            count = 0
        }
        
        let imageV = UIImage(named: arrayImage[count])
        let imageCar = UIImageView(image: imageV)
        imageCar.frame = CGRect(x:carImage.frame.origin.x, y: carImage.frame.origin.y, width: CGFloat(Int( carImage.bounds.width)), height: CGFloat(Int(carImage.bounds.height)))
        view.addSubview(imageCar)
        
        UIImageView.animate(withDuration: 0.3) {
            
            carImage.image = imageCar.image
            imageCar.image = nil
        }
        
        
        return arrayImage[count]
        
    }
    
    
    
    
    
    @objc func backFirstViewtap(){
        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "FirstViewController") as? FirstViewController else{return}
        
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    
    
    func swipe(){
        
        let swipeClear = UISwipeGestureRecognizer(target: self, action: #selector(backFirstViewtap))
        swipeClear.direction = .right
        self.view.addGestureRecognizer(swipeClear)
        
    }
    
    
    
    
    func saveResult(){
        
        StorageManager.shared.save(text: carPlayer, keys: .carPlayer)
        StorageManager.shared.save(text: carRight, keys: .carRight)
        StorageManager.shared.save(text: carLeft, keys: .carLeft)
        
    }
    
    
    
}







