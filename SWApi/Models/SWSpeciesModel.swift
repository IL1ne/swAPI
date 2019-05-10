//
//  SWSpecies.swift
//  SWApi
//
//  Created by IL1ne on 19/04/2019.
//  Copyright © 2019 IL1ne. All rights reserved.
//

import Foundation
import RealmSwift

// Species model

class SWSpeciesModel: Object {
    @objc dynamic var name = ""
    @objc dynamic var url = ""
    
    override static func primaryKey() -> String? {
        return "url"
    }
}
