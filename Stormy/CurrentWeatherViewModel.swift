//
//  CurrentWeatherViewModel.swift
//  Stormy
//
//  Created by Daniel Santos on 3/15/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeatherViewModel {
    let temperature: String
    let humidity: String
    let precipitationProbability: String
    let summary: String
    let icon: UIImage
    
    init(with model: CurrentWeather) {
        let roundedTemperature =  Int(model.temperature)
        self.temperature = "\(roundedTemperature)"
        
        let humidity = Int(model.humidity * 100)
        self.humidity = "\(humidity)%"
        
        let precipirationProbability = Int(model.precipitationProbability * 100)
        self.precipitationProbability = "\(precipirationProbability)%"
        
        self.summary = model.summary
        
        let weatherIcon = WeatherIcon(iconString: model.icon)
        self.icon = weatherIcon.image
    }
}

extension CurrentWeather {
    
    struct Key {
        static let temperature = "temperature"
        static let humidity = "humidity"
        static let precipitationProbability = "precipProbability"
        static let summary = "summary"
        static let icon = "icon"
    }
    
    init?(json: [String: AnyObject]) {
        guard let tempValue = json[Key.temperature] as? Double,
            let humidityValue = json[Key.humidity] as? Double,
            let precipitationProbability = json[Key.precipitationProbability] as? Double,
            let summaryString = json[Key.summary] as? String,
            let iconString = json[Key.icon] as? String else {
                return nil
        }
        
        self.temperature = tempValue
        self.humidity = humidityValue
        self.precipitationProbability = precipitationProbability
        self.summary = summaryString
        self.icon = iconString 
    }
}
