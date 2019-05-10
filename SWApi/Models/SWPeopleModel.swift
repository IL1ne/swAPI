//
//  SWPeopleModel
//  SWApi
//
//  Created by IL1ne on 28/03/2019.
//  Copyright © 2019 IL1ne. All rights reserved.
//

import Foundation
import RealmSwift

// Film model
class SWPeopleModel: Object {
    @objc dynamic var name = ""
    @objc dynamic var gender = ""
    @objc dynamic var birthYear = ""
    @objc dynamic var homeworld = ""
    var species = List<String>()
    var films = List<String>()
    @objc dynamic var url = ""
    override static func primaryKey() -> String? {
        return "url"
    }
}
