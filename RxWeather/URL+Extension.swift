//
//  URL+Extension.swift
//  RxWeather
//
//  Created by Len van Zyl on 2021/07/12.
//

import Foundation

extension URL {
    static func weatherSearchUrl(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(Commons.apiKey)&units=metric")
    }
}
