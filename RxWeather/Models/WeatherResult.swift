//
//  WeatherResult.swift
//  RxWeather
//
//  Created by Len van Zyl on 2021/07/11.
//

import Foundation


struct WeatherResult: Decodable {
    let main: Weather
}

extension WeatherResult {
    static var emptyResponse: WeatherResult {
        return WeatherResult(main: Weather(temp: 0.0, humidity: 0.0))
    }
}
