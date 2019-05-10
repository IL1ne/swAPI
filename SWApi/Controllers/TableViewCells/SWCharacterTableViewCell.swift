//
//  SWCharacterTableViewCell.swift
//  SWApi
//
//  Created by IL1ne on 08/04/2019.
//  Copyright © 2019 IL1ne. All rights reserved.
//

import UIKit

class SWCharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(characterName: String) {
        self.characterNameLabel?.text = characterName
    }
}
