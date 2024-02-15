//
//  SecondViewController.swift
//  Game Road
//
//  Created by admin on 8/4/20.
//  Copyright © 2020 Vitali Leikin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var OutletButtonPlayAgain: UIButton!
    @IBOutlet weak var myCountResaltLabel: UILabel!
     var countResultSecond:Int = 0
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        swipeJumpVC()
        
        let date = Date()
        let formatterString = DateFormatter()
        formatterString.dateFormat = "hh:mm dd. MM. yyyy"
        
        let string = formatterString.string(from: date)
        
        
        let resultSaved = (String(self.countResultSecond))
        let saveResulObject = ResultObject(result: resultSaved, date: string)
        
        StorageManager.shared.saveObject(object: saveResulObject )
        
        myCountResaltLabel.text = "Очки: \(String(self.countResultSecond))"
        
        OutletButtonPlayAgain.dropShadow()
        
        
        
    }
    
    
    
    
    @IBAction func playAgainButton(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else{return}
        
        self.navigationController?.pushViewController(controller, animated: true)
        clearCount()
        
    }
    
    
    func clearCount(){
        self.countResultSecond = 0
    }
    
    
    
    
    @objc func backFirstViewtap(){
        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "FirstViewController") as? FirstViewController else{return}
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    
    
    func swipeJumpVC(){
        
        let swipeClear = UISwipeGestureRecognizer(target: self, action: #selector(backFirstViewtap))
        swipeClear.direction = .right
        self.view.addGestureRecognizer(swipeClear)
        
    }
    
    
    
}

extension UIButton {
    
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 10, height: 1)
        layer.shadowRadius = self.radiusOne()
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
    }
    
    func radiusOne(radius: CGFloat = 20) -> CGFloat{
        self.layer.cornerRadius = radius
        return radius
    }
}



