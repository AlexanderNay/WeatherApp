//
//  ViewController.swift
//  WeatherApp
//
//  Created by AlexanderN on 07.09.17.
//  Copyright © 2017 AlexanderN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
 
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var imageBackground = ""
    var imageIcon = ""
    var labelCity = ""
    var labelCurrentDate = ""
    var labelDetailTypeOfWeather = ""
    var currentTemp = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentDataWeather: CurrentWeather!
    var forecastDataWeather: ForecastStruct!
    //var forecastDataWeatherArray: [String]? = ["Oren"]
    var forecastDataWeatherArray: [ForecastStruct]? = [ForecastStruct()]
    //var separetedForecastData = SeparatedForecastStruct()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - Solve the problem with blurEffect
//        if imageBackground.bounds != nil {
//            let blurEffect = UIBlurEffect(style: .dark)
//            let blurView = UIVisualEffectView(effect: blurEffect)
//            blurView.frame = imageBackground.bounds
//            blurView.alpha = 0.1
//            imageBackground.addSubview(blurView)
//        }
        
        
        
        currentDataWeather = CurrentWeather()
        //TODO: Test 2
        currentDataWeather.getDataFromUrl(completed: updateMainUI)
        print("??????????? \(currentDataWeather.whetherDetailType) ??????????????")
        
        forecastDataWeather = ForecastStruct()
        
        //xxxxxxxxxxxxxxxxxxxxxxxxx
        forecastDataWeather.getForecastData(completed: updateForecastUI)
//        tableView.delegate = self
//        tableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
   
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            //return forecastDataWeatherArray![1].list.count
           
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? ForecastTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourseDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    //TODO: - CollecrionView
    
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
    
    


    //TODO: Test 1
    
    func updateMainUI() {
//        labelCity = currentDataWeather.cityName
//        labelDetailTypeOfWeather = currentDataWeather.whetherDetailType.capitalized
//        currentTemp = currentDataWeather.currentTemp
//        labelCurrentDate = currentDataWeather.date
//        imageBackground = currentDataWeather.whetherDetailType
//        //imageBackground.image = UIImage(named: currentDataWeather.whetherDetailType)
//        imageIcon = currentDataWeather.iconNameForCurrentWeather
//        //imageIcon.image = UIImage(named: currentDataWeather.iconNameForCurrentWeather)
        
        backgroundImage.image = UIImage(named: currentDataWeather.whetherDetailType)
        
                if backgroundImage.bounds != nil {
                    let blurEffect = UIBlurEffect(style: .dark)
                    let blurView = UIVisualEffectView(effect: blurEffect)
                    blurView.frame = backgroundImage.bounds
                    blurView.alpha = 0.5
                    backgroundImage.addSubview(blurView)
                }
        
        print("********************************** \n \n **************Functon updateMainUI completed***************** \n \n *****************")
        print(currentDataWeather.cityName)

    }
    
    func updateForecastUI(data: ForecastStruct) {
        forecastDataWeatherArray?.append(data)
        
        print("ffffffffffffffffffff___________\(forecastDataWeatherArray)")
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }

    
}

