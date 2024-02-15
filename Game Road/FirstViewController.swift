//
//  FirstViewController.swift
//  Game Road
//
//  Created by admin on 8/4/20.
//  Copyright © 2020 Vitali Leikin. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    let corner: CGFloat = 10
    let borderWidth: CGFloat = 2
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var startOutletButton: UIButton!
    @IBOutlet weak var settingsOutletButton: UIButton!
    @IBOutlet weak var pointsOutletButton: UIButton!
    
    @IBOutlet weak var saveOutletButton: UIButton!
    @IBOutlet weak var startTextFieldNameUser: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startOutletButton.dropShadow()
        settingsOutletButton.dropShadow()
        pointsOutletButton.dropShadow()
        
        //параллакс
        self.imageView.addParalaxEffect()
   
    }
    override func viewDidLayoutSubviews() {
        self.imageView.addParalaxEffect()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        saveOutletButton.layer.cornerRadius = corner
        startOutletButton.layer.cornerRadius = corner
        settingsOutletButton.layer.cornerRadius = corner
        pointsOutletButton.layer.cornerRadius = corner
        
        saveOutletButton.layer.borderWidth = borderWidth
        startOutletButton.layer.borderWidth = borderWidth
        settingsOutletButton.layer.borderWidth = borderWidth
        pointsOutletButton.layer.borderWidth = borderWidth
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    @IBAction func myStartButton(_ sender: UIButton) {
        saveName()
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else{return}
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
 
    
    @IBAction func mySettingsButton(_ sender: UIButton) {
        guard let controllerSettings = self.storyboard?.instantiateViewController(withIdentifier: "SetingViewController") as? SetingViewController else{return}
        self.navigationController?.pushViewController(controllerSettings, animated: true)
    }
    
    
    
    @IBAction func myPointsButton(_ sender: UIButton) {
        
        guard let controllerSettings = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController else{return}
        self.navigationController?.pushViewController(controllerSettings, animated: true)
        
        
        
    }
    

    @IBAction func saveNameUser(_ sender: UIButton) {
        saveName()
    }
    
    func saveName(){
        let namedUser = self.startTextFieldNameUser.text ?? " "
       StorageManager.shared.save(text: namedUser, keys: .nameUser)
    }
    
}



// параллакс

extension UIView {
    func addParalaxEffect(amount: Int = 20) {
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        addMotionEffect(group)
    }
}



