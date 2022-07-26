//
//  Data.swift
//  WeatherApp
//
//  Created by Matthew  on 17.07.2022.
//

//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import SwiftUI

struct ForecastData: Codable, Identifiable {
    let id = UUID()
    let data: [DayOfTheWeek]
    let city_name: String
    let lon: Double
    let timezone: String
    let lat: Double
    let country_code: String
    let state_code: String
}

struct DayOfTheWeek: Codable, Identifiable {
    let id = UUID()
    let moonrise_ts: Int
    let wind_cdir: String
    let rh: Int
    let pres: Double
    let high_temp: Double
    let sunset_ts: Int
    let ozone: Double
    let moon_phase: Double
    let wind_gust_spd: Double
    let snow_depth: Int
    let clouds: Int
    let ts: Int
    let sunrise_ts: Int
    let app_min_temp: Double
    let wind_spd: Double
    let pop: Int
    let wind_cdir_full: String
    let slp: Double
    let moon_phase_lunation: Double
    let valid_date: String
    let app_max_temp: Double
    let vis: Double
    let dewpt: Double
    let snow: Int
    let uv: Double
    let weather: WeatherInfo
    let wind_dir: Int
    let max_dhi: Double?
    let clouds_hi: Int
    let precip: Double
    let low_temp: Double
    let max_temp: Double
    let moonset_ts: Int
    let datetime: String
    let temp: Double
    let min_temp: Double
    let clouds_mid: Int
    let clouds_low: Int
}

struct WeatherInfo: Codable {
    let icon: String
    let code: Int
    let description: String
}

