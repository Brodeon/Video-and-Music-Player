//
//  VideoCell.swift
//  Video Player
//
//  Created by Przemek on 3/9/19.
//  Copyright © 2019 Przemek Broda. All rights reserved.
//

import UIKit

protocol VideoCellDelegate {
    func cellClicked(movie: Movie?)
}

class VideoCell: UITableViewCell {
    
    var movie: Movie?
    var delegate: VideoCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            delegate?.cellClicked(movie: movie)
        }

    }

}
