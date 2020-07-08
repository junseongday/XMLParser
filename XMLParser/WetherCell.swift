//
//  WetherCell.swift
//  XMLParser
//
//  Created by JSMAC on 2020/07/08.
//  Copyright © 2020 JSPRO. All rights reserved.
//

import UIKit

class WetherCell: UITableViewCell {
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
