//
//  Location.swift
//  RainShineCloud
//
//  Created by Scott Martin on 5/12/17.
//  Copyright © 2017 Scott Martin. All rights reserved.
//

import Foundation
import CoreLocation


class Location {
    static var sharedInstance = Location()
    var latitude: Double!
    var longitude: Double!
    
    
    private init() {}
}
