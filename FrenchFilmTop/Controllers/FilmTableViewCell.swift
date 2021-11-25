//
//  FilmTableViewCell.swift
//  FrenchFilmTop
//
//  Created by ineta.magone on 22/11/2021.
//

import UIKit

class FilmTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageForCell: UIImageView!
    
    @IBOutlet weak var dateForCell: UILabel!
    
    @IBOutlet weak var voteLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
