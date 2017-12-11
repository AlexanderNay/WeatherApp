//
//  ViewController.swift
//  WeatherApp
//
//  Created by AlexanderN on 07.09.17.
//  Copyright © 2017 AlexanderN. All rights reserved.
//

import UIKit

// Start making code a better place

class MainViewController: UIViewController {
 
    @IBOutlet weak var backgroundImage: UIImageView!
 
    @IBOutlet weak var tableView: UITableView!

    
    var currentDataWeather: CurrentWeather!
    var forecastDataWeather: ForecastStruct!
    
    
    //TODO: - how to appear only one element
    var forecastDataWeatherArray: [ForecastStruct]? = [ForecastStruct()]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //Get data from URL and update UI for Current Weather
        currentDataWeather = CurrentWeather()
        currentDataWeather.getDataFromUrl(completed: updateMainUI)
        
        //Get data from URL and update UI for Forecast
        forecastDataWeather = ForecastStruct()
        forecastDataWeather.getForecastData(completed: updateForecastUI)

//        tableView.delegate = self
//        tableView.dataSource = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}


//UITableView

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return forecastDataWeatherArray![1].separetedForecast.baseDays.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCellForecast", for: indexPath) as? ForecastTableViewCell {
                
                if let forecast = forecastDataWeatherArray {
                    //if let forecast = forecastDataWeather {
                    cell.configureCell(forecast: forecast, cellRow: indexPath.row)
                    print("Cell cell cell cell cell \(indexPath.row)")
                    
                }
                return cell
                
            } else {
                return ForecastTableViewCell()
            }
            
        } else if indexPath.section == 0 {
            if let cell2 = tableView.dequeueReusableCell(withIdentifier: "CurrentWeatherCell", for: indexPath) as? CurrentTableViewCell {
                cell2.confugureCell(data: currentDataWeather)
                return cell2
            } else {
                return CurrentTableViewCell()
            }
        } else {
            return UITableViewCell()
        }
        
    }
}


extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? ForecastTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourseDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 40
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as? HeaderTableViewCell
        return header
        
    }
    
    
    
    
    
}


// UICollectionView

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return forecastDataWeatherArray![1].separetedForecast.baseDays[collectionView.tag].partsOfTheDay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? ForecastCollectionViewCell {
            let data = forecastDataWeatherArray![1].separetedForecast.baseDays[collectionView.tag].partsOfTheDay[indexPath.row]
            cell.setCellsItems(data: data)
            return cell
        } else {
            return ForecastCollectionViewCell()
        }
        
    }
    
    
}

extension MainViewController: UICollectionViewDelegate {
    
}



// Function for update UI

extension MainViewController {
   
    func updateMainUI() {
        
        backgroundImage.image = UIImage(named: currentDataWeather.whetherDetailType)
      

        
    }
    
    func updateForecastUI(data: ForecastStruct) {
        
        forecastDataWeatherArray?.append(data)
        
        print("ffffffffffffffffffff___________\(forecastDataWeatherArray)")
        print(forecastDataWeatherArray![1].separetedForecast)
        tableView.delegate = self
        tableView.dataSource = self
       
        //TODO: - Understand what does heppen here and change if it's necessary
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}











