//
//  ViewController.swift
//  WeatherApp
//
//  Created by AlexanderN on 07.09.17.
//  Copyright © 2017 AlexanderN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelCurrentDate: UILabel!
    @IBOutlet weak var labelDetailTypeOfWeather: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentDataWeather: CurrentWeather!
    var forecastDataWeather: ForecastStruct!
    //var forecastDataWeatherArray: [String]? = ["Oren"]
    var forecastDataWeatherArray: [ForecastStruct]? = [ForecastStruct()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageBackground.bounds
        blurView.alpha = 0.3
        imageBackground.addSubview(blurView)
        
        
        currentDataWeather = CurrentWeather()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastDataWeatherArray![1].list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? ForecastTableViewCell {
            
            if let forecast = forecastDataWeatherArray {
            //if let forecast = forecastDataWeather {
                cell.configureCell(forecast: forecast, cellRow: indexPath.row)
                print("Cell cell cell cell cell")
            }
          
            
            
            
            return cell
        } else {
           return ForecastTableViewCell()
        }
        
    }
    
    func updateMainUI() {
        labelCity.text = currentDataWeather.cityName
        labelDetailTypeOfWeather.text = currentDataWeather.whetherDetailType.capitalized
        currentTemp.text = currentDataWeather.currentTemp
        labelCurrentDate.text = currentDataWeather.date
        imageBackground.image = UIImage(named: currentDataWeather.whetherDetailType)
        imageIcon.image = UIImage(named: currentDataWeather.iconNameForCurrentWeather)
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

