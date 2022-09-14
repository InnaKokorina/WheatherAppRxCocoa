//
//  ViewController.swift
//  WheatherAppRxCocoa
//
//  Created by Inna Kokorina on 14.09.2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.textField.text  }
            .subscribe(onNext: { [weak self] city in
                if let cityName = city {
                    if cityName.isEmpty {
                        self?.displayWeather(nil)
                    } else {
                        self?.fetchWeather(by: cityName)
                    }
                }
                
            }).disposed(by: disposeBag)
        
    }

    private func displayWeather(_ weather: Weather?) {
        if let weather = weather {
            temperatureLabel.text = "\(weather.temp) ℃"
            humidityLabel.text = "\(weather.humidity) 💦"
        } else {
            temperatureLabel.text = "💫"
            humidityLabel.text = "💦"
        }
        
        
    }
    private func fetchWeather(by city: String) {
        
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlWeatherApi(city: cityEncoded) else { return }
        
        let resource = Resource<WeatherModel>(url: url)
        
      let search = URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .asDriver(onErrorJustReturn: WeatherModel.empty)
          
        search.map { "\($0.main.temp) ℃" }
            .drive(temperatureLabel.rx.text)
            .disposed(by: disposeBag)
     
    search.map { "\($0.main.humidity) 💦" }
                .drive(humidityLabel.rx.text)
        .disposed(by: disposeBag)

    }
    
}

