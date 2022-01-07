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
    @IBOutlet var weatherStackView: UIStackView!
    
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
        session.dataTask(with: url) {[weak self] data, response, error  in
            let successRang = (200..<300)
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            if let response = response as? HTTPURLResponse, successRang.contains(response.statusCode) {
                guard let weatherInfomation = try? decoder.decode(WeatherInfomotion.self, from: data) else { return }
                
                DispatchQueue.main.async {
                    self?.weatherStackView.isHidden = false
                    self?.configureView(weatherInfomation: weatherInfomation)
                }
            }else {
                guard let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) else { return }
                
                DispatchQueue.main.async {
                    self?.showAlert(message: errorMessage.message)
                }
            }
            
        }.resume()
    }
    
    func configureView(weatherInfomation: WeatherInfomotion){
        cityNameLabel.text = weatherInfomation.name
        if let weather = weatherInfomation.weather.first {
            weatherDescriptionLabel.text = weather.description
        }
        tempLabel.text = "\(Int(weatherInfomation.temp.temp - 273.15)) °C" //섭시 변환
        minTempLabel.text = "최저: \(Int(weatherInfomation.temp.minTemp - 273.15))°C"
        maxTempLabel.text = "최고: \(Int(weatherInfomation.temp.maxTemp - 273.15))°C"
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true , completion: nil )
    }
}

