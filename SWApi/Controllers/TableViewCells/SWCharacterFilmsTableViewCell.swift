//
//  SWCharacterFilmsTableViewCell.swift
//  SWApi
//
//  Created by IL1ne on 18/04/2019.
//  Copyright © 2019 IL1ne. All rights reserved.
//

import UIKit

class SWCharacterFilmsTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeIdLabel: UILabel!
    @IBOutlet weak var episodeTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(episodeIdLabel: String, episodeTitle: String) {
        self.episodeIdLabel?.text = episodeIdLabel
        self.episodeTitle?.text = episodeTitle
    }
}
