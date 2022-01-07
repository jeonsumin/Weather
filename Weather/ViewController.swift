//
//  ViewController.swift
//  Weather
//
//  Created by Terry on 2022/01/07.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet var cityNameTextField: UITextField!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var weatherDescriptionLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    
    //MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK: - IBAction
    @IBAction func tapFetchWeatherButton(_ sender: Any) {
        if let cityName = cityNameTextField.text {
            getCurrentWeather(cityName: cityName)
            view.endEditing(true)
        }
    }
    
    //MARK: - Function
    func getCurrentWeather(cityName : String ){
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=bd739ffb0fc5425c5b1731d209334352") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error  in
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            let weatherInfomation = try? decoder.decode(weatherInfomotion.self, from: data)
            debugPrint(weatherInfomation)
        }.resume()
    }
}

