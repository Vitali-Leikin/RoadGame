//
//  ResultObject.swift
//  Game Road
//
//  Created by admin on 9/8/20.
//  Copyright © 2020 Vitali Leikin. All rights reserved.
//

import Foundation


class ResultObject: Codable {
    var result: String?
    var date: String?
    
    init(result: String, date: String ) {
        self.result = result
        self.date = date
    }
    
    public enum CodingKeys: String, CodingKey {
        case result, date
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.date = try container.decodeIfPresent(String.self, forKey: .date)
        self.result = try container.decodeIfPresent(String.self, forKey: .result) ?? String()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.result, forKey: .result)
        try container.encode(self.date, forKey: .date)
    }

}
