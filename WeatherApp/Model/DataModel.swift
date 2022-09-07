//
//  Data.swift
//  WeatherApp
//
//  Created by Matthew  on 17.07.2022.
//

import SwiftUI

struct ForecastData: Codable, Identifiable, Hashable {
    let id = UUID()
    let data: [DayOfTheWeek]
    let city_name: String
    let lon: String?
    let timezone: String
    var lat: String?
    let country_code: String
    let state_code: String
    
    //Depending on the request, the response from the server for lat and lon can come either as a Double or as a String
    init(lon: String? = nil, lat: String? = nil, data: [DayOfTheWeek], city_name: String, timezone: String, country_code: String, state_code: String) {
        self.lon = lon
        self.lat = lat
        self.data = data
        self.city_name = city_name
        self.timezone = timezone
        self.country_code = country_code
        self.state_code = state_code
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode([DayOfTheWeek].self, forKey: .data)
        city_name = try container.decode(String.self, forKey: .city_name)
        timezone = try container.decode(String.self, forKey: .timezone)
        country_code = try container.decode(String.self, forKey: .country_code)
        state_code = try container.decode(String.self, forKey: .state_code)
        do {
            lat = try String(container.decode(Double.self, forKey: .lat))
            lon = try String(container.decode(Double.self, forKey: .lon))
        } catch {
            lat = try container.decode(String.self, forKey: .lat)
            lon = try container.decode(String.self, forKey: .lon)
        }
    }
    
}

struct DayOfTheWeek: Codable, Identifiable, Hashable{
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

struct WeatherInfo: Codable, Hashable {
    let icon: String
    let code: Int
    let description: String
}

//@propertyWrapper
//struct PreferredDouble {
//    private var value: Double
//
//    var wrappedValue: Double {
//        get {value }
//        set { value = newValue }
//    }
//}
//
//extension PreferredDouble: Decodable {
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if let double = try? container.decode(Double.self) {
//            value = double
//        } else if let string = try? container.decode(String.self), let double = Double(string) {
//            value = double
//        } else {
//            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot convert to Double")
//        }
//    }
//}
