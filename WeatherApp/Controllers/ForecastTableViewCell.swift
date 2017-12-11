//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by AlexanderN on 11.09.17.
//  Copyright © 2017 AlexanderN. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
 
    @IBOutlet weak var dataForecast: UILabel!
 
    func configureCell(forecast: [ForecastStruct], cellRow: Int) {
        
            dataForecast.text = forecast[1].separetedForecast.baseDays[cellRow].weekDay.capitalized
 
    }
    
 
    func setCollectionViewDataSourseDelegate<Type: UICollectionViewDataSource & UICollectionViewDelegate>(dataSourceDelegate: Type, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }
    
   

}
