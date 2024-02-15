//
//  ResultViewController.swift
//  Game Road
//
//  Created by admin on 8/22/20.
//  Copyright © 2020 Vitali Leikin. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var arrayResult:[ResultObject] = []
//    let array:[String] = ["","","","","","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipe()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        arrayResult = StorageManager.shared.loadObject()
        arrayResult.reverse()

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
    
}


extension UILabel {
    
    func displayLabel(){
        
        self.layer.cornerRadius = 500
        self.alpha = 0.5
        self.backgroundColor = .black
        self.textColor = .systemBlue
    }
    
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else{
            return UITableViewCell()
        }
        
        
        cell.textLabel?.text = "очки: " + arrayResult[indexPath.row].result! + ",  " + "Дата заезда " + arrayResult[indexPath.row].date!

       
        return cell
    }
    
   
    
}
