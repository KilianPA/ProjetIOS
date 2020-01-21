//
//  HolidayCellViewTableViewCell.swift
//  ProjetIOS
//
//  Created by Kilian Pasini on 21/01/2020.
//  Copyright © 2020 Kilian Pasini. All rights reserved.
//

import UIKit

class HolidayCellViewTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fill(withHoliday holiday: Holiday) {
        name.text = holiday.name
        date.text = holiday.date?.iso
    }
}
