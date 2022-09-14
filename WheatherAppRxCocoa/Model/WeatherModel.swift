//
//  WeatherModel.swift
//  WheatherAppRxCocoa
//
//  Created by Inna Kokorina on 14.09.2022.
//

import Foundation

struct WeatherModel: Decodable {
    var main: Weather
}

extension WeatherModel {
    static var empty: WeatherModel {
        return WeatherModel(main: Weather(temp: 0.0, humidity: 0.0))
    }
}

struct Weather: Decodable {
    var temp: Double
    var humidity: Double
}
