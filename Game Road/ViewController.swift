//
//  ViewController.swift
//  Game Road
//
//  Created by admin on 8/1/20.
//  Copyright © 2020 Vitali Leikin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet var myView: UIView!
    @IBOutlet weak var roadViewBackground: UIView!
    @IBOutlet weak var curdRoadViewRight: UIView!
    @IBOutlet weak var curdRoadViewLeft: UIView!
    @IBOutlet weak var myViewClear: UIView!
    @IBOutlet weak var myLabelResultVC: UILabel!
    @IBOutlet weak var myLabelNameUser: UILabel!
    
    
    // MARK: - let
    
    let screenSize = UIScreen.main.bounds
    let timeAnimate: Double = 0.5
    let markingWidth = 10
    let markingHeight = 200
    let oneStepCarMoving = 60
    let creatingPointObject = -200
    let pointFishObjectBehindScreen: CGFloat = 1700
    let sizePlant = 50
    let sizeCarDangerWidht = 80
    let timerAnimatCarAndPlants: TimeInterval = 3
    let pointsCount = 10
    
    var carDangerView = UIImageView()
    var carDangerViewLeft = UIImageView()
    var myCar = UIImageView()
    var plantViewLeft = UIImageView()
    var plantViewRight = UIImageView()
    var timerStop: Bool = false
    var countResult: Int = 0{
        willSet{}
        didSet{
            myLabelResultVC.text = String(countResult)
        }
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countResult = 0
        self.myLabelNameUser.text = StorageManager.shared.load(keys: .nameUser)
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        creatMyCar()
        timerMarkingRoad()
    }
    
    // MARK: - IBAction
    
    @IBAction func movingDirectionRight(_ sender: UIButton) {
        if (self.myCar.frame.origin.x + self.myCar.frame.width + CGFloat(oneStepCarMoving)) <= self.myViewClear.frame.width {
            
            UIImageView.animate(withDuration: 0.3) {
                self.myCar.frame.origin.x += CGFloat(self.oneStepCarMoving)
            }
        }
    }
    
    
    @IBAction func movingDirectionLeft(_ sender: UIButton) {
        if self.myCar.frame.origin.x - CGFloat(oneStepCarMoving) >= -10 {
            UIImageView.animate(withDuration: 0.3) {
                self.myCar.frame.origin.x -= CGFloat(self.oneStepCarMoving)
            }
            
        }
    }
    
    // MARK: - func
    
    func timerMarkingRoad(){

        
        let timerCrash = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (_) in
            self.checkCrash()
        }
        
        
        let timerMarking = Timer.scheduledTimer(withTimeInterval: timeAnimate, repeats: true) { (_) in
            self.animatedMarkingRoad()
        }
        
        
        let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(Int.random(in: 7...8)), repeats: true) { (_) in
            self.createCarTwoDanger()
            
        }
        
        let timerTwo = Timer.scheduledTimer(withTimeInterval: TimeInterval(Int.random(in: 6...10)), repeats: true) { (_) in
            self.createCarRightDanger()
            
        }
        
        let timerPlant = Timer.scheduledTimer(withTimeInterval: TimeInterval(Int.random(in: 4...10)), repeats: true) { (_) in
            self.createPlantRight()
            self.createPlantLeft()
            
        }
        
        let timerPlantRight = Timer.scheduledTimer(withTimeInterval: TimeInterval(Int.random(in: 4...5)), repeats: true) { (_) in
            self.createPlantRight()
            
        }
        timerCrash.fire()
        timerMarking.fire()
        
        
        if timerStop {
            timer.invalidate()
            timerPlant.invalidate()
            timerTwo.invalidate()
            timerMarking.invalidate()
            timerPlantRight.invalidate()
            
        }
        
        
    }
    
    func creatMyCar(){
       // let nameCar = UIImage(named: "car")
        let nameCar = UIImage(named: StorageManager.shared.load(keys: .carPlayer) ?? "car")

        myCar = UIImageView(image: nameCar)
        myCar.frame = CGRect(x: Int(self.myViewClear.center.x / 2.5), y:  Int(self.myViewClear.bounds.height - 300), width: sizeCarDangerWidht , height: sizeCarDangerWidht * 2)
        self.myViewClear.addSubview(myCar)
    }
    
    func animatedMarkingRoad(){
        
        let markingViewRoad = UIView()
        markingViewRoad.backgroundColor = .white
        markingViewRoad.frame = CGRect(x:0, y: 0, width: markingWidth, height: markingHeight)
         markingViewRoad.frame = CGRect(x: Int(Int(roadViewBackground.bounds.width) / 2 ), y: -markingHeight, width: markingWidth, height: markingHeight)
        
        roadViewBackground.addSubview(markingViewRoad)
        
        UIView.animate(withDuration: timerAnimatCarAndPlants, delay: 0, options: .curveLinear
            , animations: {
                markingViewRoad.frame.origin.y += self.pointFishObjectBehindScreen
        }, completion: { (_) in
            markingViewRoad.removeFromSuperview()
            
        })
        
    }
    
    
    func createCarTwoDanger(){
        
        
      //  let carName = UIImage(named: "carTwo")
        
        let carName = UIImage(named: StorageManager.shared.load(keys: .carLeft) ?? "carTwo" )

        self.carDangerView = UIImageView(image: carName)
        
        self.carDangerView.frame = CGRect(x: 0, y: 0, width: sizeCarDangerWidht, height: sizeCarDangerWidht * 2)
        
        self.carDangerView.frame = CGRect(x: Int(self.myViewClear.center.x / 2.5), y: creatingPointObject, width: sizeCarDangerWidht, height: sizeCarDangerWidht * 2)
        
        self.myViewClear.addSubview(self.carDangerView)
        
        
        UIImageView.animate(withDuration: timerAnimatCarAndPlants, animations: {
            self.carDangerView.frame.origin.y += self.pointFishObjectBehindScreen
            
        }) { (_) in
            self.countResult += self.pointsCount
            self.carDangerView.removeFromSuperview()
        }
        
        
        
    }
    
    func createCarRightDanger(){
        
       // let carName = UIImage(named: "carThree")
        let carName = UIImage(named: StorageManager.shared.load(keys: .carRight)  ?? "carThree")

        
        self.carDangerViewLeft = UIImageView(image: carName)
        
        self.carDangerViewLeft.frame = CGRect(x:0, y: 0, width: sizeCarDangerWidht, height: sizeCarDangerWidht * 2)
        
          self.carDangerViewLeft.frame = CGRect(x: Int(self.roadViewBackground.frame.width - self.carDangerView.frame.width / 2), y: creatingPointObject, width: sizeCarDangerWidht, height: sizeCarDangerWidht * 2)
        
        self.myViewClear.addSubview(self.carDangerViewLeft)
        
        
        UIImageView.animate(withDuration: timerAnimatCarAndPlants, animations: {
            self.carDangerViewLeft.frame.origin.y += self.pointFishObjectBehindScreen
            
        }) { (_) in
            self.countResult += self.pointsCount
            self.carDangerViewLeft.removeFromSuperview()
        }
        
        
        
    }
    
    
    func createPlantRight(){
        let name = UIImage(named: "plant")
        self.plantViewRight = UIImageView(image: name)
        self.plantViewRight.frame = CGRect(x: Int(self.myViewClear.frame.width - self.curdRoadViewRight.frame.width ), y: creatingPointObject, width: sizePlant, height: sizePlant)
        self.myViewClear.addSubview(self.plantViewRight)
        
        UIImageView.animate(withDuration: timerAnimatCarAndPlants, animations: {
            self.plantViewRight.frame.origin.y += self.pointFishObjectBehindScreen
            
        }) { (_) in
            self.plantViewRight.removeFromSuperview()
        }
        
    }
    
    
    func createPlantLeft(){
        
        let name = UIImage(named: "plant")
        self.plantViewLeft = UIImageView(image: name)
        self.plantViewLeft.frame = CGRect(x: Int(self.curdRoadViewLeft.frame.origin.x), y: creatingPointObject, width: sizePlant, height: sizePlant)
        self.myViewClear.addSubview(self.plantViewLeft)
        
        UIImageView.animate(withDuration: timerAnimatCarAndPlants, animations: {
            self.plantViewLeft.frame.origin.y += self.pointFishObjectBehindScreen
            
        }) { (_) in
            self.plantViewLeft.removeFromSuperview()
        }
        
        
    }
    
    
    
    
    func checkCrash(){
        
        guard  let myCarGuard = myCar.layer.presentation()?.frame else{return}
        
        guard  let carDangerViewGuard = carDangerView.layer.presentation()?.frame else{return}
        guard  let carDangerViewGuardLeft = carDangerViewLeft.layer.presentation()?.frame else{return}
        guard  let plantViewGuard = plantViewLeft.layer.presentation()?.frame else{return}
        guard  let plantViewGuardTwo = plantViewRight.layer.presentation()?.frame else{return}
        
        
        if myCarGuard.intersects(carDangerViewGuard) ||  myCarGuard.intersects(plantViewGuard) || myCarGuard.intersects(plantViewGuardTwo) || myCarGuard.intersects(carDangerViewGuardLeft) {
            stopAnimation()
            print("Crash")
            timerStop = true
        }
        
    }
    
    func stopAnimation(){
        
        
        self.view.subviews.forEach({$0.layer.removeAllAnimations()})
        self.view.layer.removeAllAnimations()
        self.view.layoutIfNeeded()
        
        self.myViewClear.subviews.forEach({$0.layer.removeAllAnimations()})
        self.myViewClear.layer.removeAllAnimations()
        self.myViewClear.layoutIfNeeded()
       
        print("stopAnimation1111")
        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else{return}
        
        controller.countResultSecond = self.countResult
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
}




extension UIImageView {
    
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 10, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
    }
}
