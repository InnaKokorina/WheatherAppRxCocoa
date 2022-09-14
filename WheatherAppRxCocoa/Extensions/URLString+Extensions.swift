//
//  URLString+Extensions.swift
//  WheatherAppRxCocoa
//
//  Created by Inna Kokorina on 14.09.2022.
//

import Foundation

extension URL {
    static func urlWeatherApi(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=dbcc7d7707c29b3259f88aae7365f26e&units=metric")
    }
}
