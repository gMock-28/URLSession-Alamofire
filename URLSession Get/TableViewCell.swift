//
//  TableViewCell.swift
//  URLSession Get
//
//  Created by Gold_Mock on 21.09.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCellView: UIImageView!
    @IBOutlet weak var nameOfCourceLabel: UILabel!
    @IBOutlet weak var numOfCoursesLabel: UILabel!
    @IBOutlet weak var lowestLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
