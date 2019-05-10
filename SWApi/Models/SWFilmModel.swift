//
//  SWFilm.swift
//  SWApi
//
//  Created by IL1ne on 28/03/2019.
//  Copyright © 2019 IL1ne. All rights reserved.
//

import Foundation
import RealmSwift

// Film model

class SWFilmModel: Object {
    @objc dynamic var title = ""
    @objc dynamic var episode_id = 0
    @objc dynamic var opening_crawl = ""
    @objc dynamic var director = ""
    @objc dynamic var producer = ""
    @objc dynamic var release_date = ""
    @objc dynamic var url = ""
    var characters = List<String>()
    
    override static func primaryKey() -> String? {
        return "url"
    }
}
