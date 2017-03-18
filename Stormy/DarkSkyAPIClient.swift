//
//  DarkSkyAPIClient.swift
//  Stormy
//
//  Created by Daniel Santos on 3/16/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

class DarkSkyAPIClient {
    fileprivate let darkSkyAPIKey = "enter-api-key-from-darksky.net"

    lazy var baseUrl: URL = {
        return URL(string: "https://api.darksky.net/forecast/\(self.darkSkyAPIKey)/")!
    
    }()
    
    let downloader = JSONDownloader()
    
    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion:
        @escaping (CurrentWeather?, DarkSkyError?) -> Void) {
        guard let url = URL(string: coordinate.description, relativeTo: self.baseUrl) else {
            completion(nil, .invalidUrl)
            return 
        }
        
        let request = URLRequest(url: url)
        
        let task = downloader.jsonTask(with: request) { json, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }
                guard let currentWeatherJson = json["currently"] as? [String: AnyObject],
                    let currentWeather = CurrentWeather(json: currentWeatherJson) else {
                        completion(nil, .jsonParsingFailure)
                        return
                }
                completion(currentWeather, nil)
            }
        }
        
        task.resume()
    }
    
}




