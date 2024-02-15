//
//  StorageManager.swift
//  Game Road
//
//  Created by admin on 8/22/20.
//  Copyright © 2020 Vitali Leikin. All rights reserved.
//

import Foundation
import UIKit


class StorageManager {
    
    enum Keys: String {
        case carPlayer = "carPlayer"
        case carRight = "carRight"
        case carLeft = "carLeft"
        
      //  case oneResult = "oneResult"
       // case twoResult = "twoResult"
       // case threeResult = "threeResult"
        //case fourResult = "fourResult"
        //case fiveResult = "fiveResult"
        
      //  case count = "count"
       case nameUser = "nameUser"
        case key = "customKey"

    }
    
    
           private let defaults = UserDefaults.standard
     //  private let key = "customKey"
    
        
    
    var counter = 0
    static let shared = StorageManager()
    
    private init() {}
    
    
    func save(text: String, keys: Keys) {
        UserDefaults.standard.set(text, forKey: keys.rawValue)
    }
    
    
    
    func load(keys: Keys) -> String? {
        guard let text = UserDefaults.standard.value(forKey: keys.rawValue) as? String else { return nil }
        
        return text
    }
    
    
    
    
      func saveObject(object: ResultObject) {
          var array = StorageManager.shared.loadObject()
          array.append(object)
        defaults.set(encodable: array, forKey: Keys.key.rawValue)
      }
      
      func loadObject() -> [ResultObject] {
          let array = defaults.value([ResultObject].self, forKey: Keys.key.rawValue)
          
          if let array = array {
              return array
          } else  {
              return []
          }
      }
      
    
    
    
    
    
    
    
    
    
 /*
     
    func incrementStartCountSave() {
        
        if counter > 5 {
            counter = 0
        }
        counter += 1
        UserDefaults.standard.set(counter, forKey: Keys.count.rawValue)
    }
    
    
    func incrementStartCountLoad() -> Int {
        guard let count = UserDefaults.standard.value(forKey: Keys.count.rawValue) as? Int else{return 1}
        return count
    }
 
 */
}

extension UserDefaults {
    
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
            let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}
