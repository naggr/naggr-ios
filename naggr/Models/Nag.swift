//
//  Nag.swift
//  naggr
//
//  Created by Jonathan Moallem on 7/7/18.
//  Copyright © 2018 naggr. All rights reserved.
//

import Foundation

class Nag: Encodable, Decodable {
    
    let name: String
    let number: String
    var lastCalled: Date
    
    init(name: String, number: String, lastCalled: Date) {
        self.name = name
        self.number = number
        self.lastCalled = lastCalled
    }
}
