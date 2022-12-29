//
//  CharactersListViewCell.swift
//  obnk
//
//  Created by Javier Calatrava on 28/12/22.
//

import UIKit

class CharactersListViewCell: UITableViewCell {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterIcon: UIImageView!

    // MARK: - Lifecycle/Overridden
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }
    
    // MARK: - Public/Helper
    func set(character: Character) {
        guard nameLabel != nil else { return }
        self.nameLabel.text = character.name
        if let url = character.thumbnail.getURL() {
            characterIcon.setImage(from: url)
        }
    }
}
