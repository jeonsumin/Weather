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
    
    //MARK: - LifeCycle
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
        // URLSession 선언
        let session = URLSession(configuration: .default)
        // dataTask를 통해 URL Data 가져오기
        session.dataTask(with: url) {[weak self] data, response, error  in
            let successRang = (200..<300)
            guard let data = data, error == nil else { return }
            // json decoder 선언 
            let decoder = JSONDecoder()
            if let response = response as? HTTPURLResponse, successRang.contains(response.statusCode) {
                // struct Codable을 통해 dataTask의 json형태의 데이터를 weatherInfomation 객체로 decode
                guard let weatherInfomation = try? decoder.decode(WeatherInfomotion.self, from: data) else { return }
                
                //View 관련 로직 처리는 Main 스레드에서 진행하여 하기 때문에 
                DispatchQueue.main.async {
                    self?.weatherStackView.isHidden = false
                    self?.configureView(weatherInfomation: weatherInfomation)
                }
            }else {
                guard let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) else { return }

                //View 관련 로직 처리는 Main 스레드에서 진행하여 하기 때문에 
                DispatchQueue.main.async {
                    self?.showAlert(message: errorMessage.message)
                }
            }
            
        }.resume()
    }
    //화면 구성
    func configureView(weatherInfomation: WeatherInfomotion){
        cityNameLabel.text = weatherInfomation.name
        if let weather = weatherInfomation.weather.first {
            weatherDescriptionLabel.text = weather.description
        }
        tempLabel.text = "\(Int(weatherInfomation.temp.temp - 273.15)) °C" //섭시 변환
        minTempLabel.text = "최저: \(Int(weatherInfomation.temp.minTemp - 273.15))°C"
        maxTempLabel.text = "최고: \(Int(weatherInfomation.temp.maxTemp - 273.15))°C"
    }
    
    //Error Alert 
    func showAlert(message: String){
        //AlertController 선언 
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        
        //AlertController에서 사용할 Action 추가
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))

        //화면으로 전달
        present(alert, animated: true , completion: nil )
    }
}

