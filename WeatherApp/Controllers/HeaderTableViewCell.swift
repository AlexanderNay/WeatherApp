//
//  HeaderTableViewCell.swift
//  WeatherApp
//
//  Created by AlexanderN on 10.11.2017.
//  Copyright © 2017 AlexanderN. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var forecastLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        forecastLable.text = NSLocalizedString("Forecast", comment: "A label peceding the forecast")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
