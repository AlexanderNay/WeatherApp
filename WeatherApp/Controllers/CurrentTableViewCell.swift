//
//  CurrentTableViewCell.swift
//  WeatherApp
//
//  Created by AlexanderN on 09.11.2017.
//  Copyright © 2017 AlexanderN. All rights reserved.
//

import UIKit

class CurrentTableViewCell: UITableViewCell {

   // @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var backgroudImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var dictrict: UILabel!
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var typeOfWeather: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var iconOfWeather: UIImageView!
    
    func confugureCell(data: CurrentWeather) {
        cityName.text = data.cityName
        dictrict.text = data.district
        dictrict.isHidden = false
        if cityName.text == dictrict.text {
            dictrict.isHidden = true
        }
        typeOfWeather.text = data.whetherDetailType.capitalized
        currentTemperature.text = data.currentTemp
        todayDate.text = data.date
        backgroudImage.image = UIImage(named: String(data.currentWeatherID))
        
    
        iconOfWeather.image = UIImage(named: data.iconNameForCurrentWeather)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
