//
//  ViewController.swift
//  Stormy
//
//  Created by Pasan Premaratne on 2/15/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let client = DarkSkyAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentWeather()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayWeather(using viewModel: CurrentWeatherViewModel) {
        self.currentTemperatureLabel.text = viewModel.temperature
        self.currentHumidityLabel.text = viewModel.humidity
        self.currentPrecipitationLabel.text = viewModel.precipitationProbability
        self.currentWeatherIcon.image = viewModel.icon
        self.currentSummaryLabel.text = viewModel.summary
    }
    
    @IBAction func getCurrentWeather() {
        
        toggleRefreshAnimation(on: true)
        
        let coordinate = Coordinate(latitude: 42.643665, longitude: -71.327878)
        
        self.client.getCurrentWeather(at: coordinate) { [unowned self] currentWeather, error in
            if let currentWeather = currentWeather {
                let viewModel = CurrentWeatherViewModel(with: currentWeather)
                self.displayWeather(using: viewModel)
                self.toggleRefreshAnimation(on: false)
            }
            
        }
    }
    
    func toggleRefreshAnimation(on: Bool) {
        self.refreshButton.isHidden = on
        
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
















