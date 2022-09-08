//
//  GetData.swift
//  WeatherApp
//
//  Created by Matthew  on 19.07.2022.
//

import SwiftUI

class FetchData {
    
    var apiKey: String
    var latitude: Double?
    var longtitude: Double?
    var city: String?

    func getJSON(completed: @escaping (ForecastData) -> Void) {
        var address: String
        
        if let latitude = latitude {
            address = "&lat=\(latitude.description)&lon=\(longtitude!.description)"
        } else {
            address = "city=\(self.city!.description)"
        }
        
        guard let url = URL(string: "https://api.weatherbit.io/v2.0/forecast/daily?\(address)&key=\(apiKey)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error == nil {
                let decoder = JSONDecoder()
                do {
                    let posts = try decoder.decode(ForecastData.self, from: data!)
                    DispatchQueue.main.async {
                        completed(posts)
                    }
                } catch {
                    print("\(error) ERROR \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    init(latitude: Double, longtitude: Double, apiKey: String) {
        self.apiKey = apiKey
        self.latitude = latitude
        self.longtitude = longtitude
    }
    
    init(city: String, apiKey: String) {
        self.city = city
        self.apiKey = apiKey
    }
}
