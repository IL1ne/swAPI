//
//  SWPlanet.swift
//  SWApi
//
//  Created by IL1ne on 28/03/2019.
//  Copyright © 2019 IL1ne. All rights reserved.
//

import Foundation
import RealmSwift

// Film model
class SWPlanetModel: Object {
    @objc dynamic var name = ""
    @objc dynamic var population = ""
    @objc dynamic var climate = ""
    @objc dynamic var diameter = ""
    @objc dynamic var terrain = ""
    @objc dynamic var url = ""
    
    override static func primaryKey() -> String? {
        return "url"
    }
}
