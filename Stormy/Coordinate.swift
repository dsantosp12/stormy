//
//  Coordinate.swift
//  Stormy
//
//  Created by Daniel Santos on 3/16/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

struct Coordinate {
    let latitude: Double
    let longitude: Double
}

extension Coordinate: CustomStringConvertible {
    var description: String {
        return "\(self.latitude),\(self.longitude)"
    }
}
