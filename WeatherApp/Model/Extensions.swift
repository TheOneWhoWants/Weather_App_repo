//
//  Extensions.swift
//  WeatherApp
//
//  Created by Matthew  on 26.07.2022.
//

import SwiftUI

//From common date format to the day of the week
extension String {
    func getDayOfWeek(format: String) -> String? {
        
        let weekDays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]

        let formatter = DateFormatter()
        formatter.dateFormat = format
        guard let myDate = formatter.date(from: self) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: myDate)
        
        let dayOfWeek = String(weekDays[weekDay-1].prefix(3))
        return dayOfWeek
    }
}

//From JSON icon name to SwiftUI system icon name
extension String {
    func nameToImage() -> String? {
        let images: [String: String] = [
            "t01d": "cloud.sun.bolt.fill",
            "t01n": "cloud.moon.bolt.fill",
            "t02d": "cloud.sun.bolt.fill",
            "t02n": "cloud.moon.bolt.fill",
            "t03d": "cloud.sun.bolt.fill",
            "t03n": "cloud.moon.bolt.fill",
            "t04d": "cloud.sun.bolt.fill",
            "t04n": "cloud.moon.bolt.fill",
            "t05d": "cloud.bolt.fill",
            "t05n": "cloud.moon.bolt.fill",
            "d01d": "cloud.drizzle.fill",
            "d01n": "cloud.drizzle.fill",
            "d02d": "cloud.drizzle.fill",
            "d02n": "cloud.drizzle.fill",
            "d03d": "cloud.drizzle.fill",
            "d03n": "cloud.drizzle.fill",
            "r01d": "cloud.rain.fill",
            "r01n": "cloud.rain.fill",
            "r02d": "cloud.rain.fill",
            "r02n": "cloud.rain.fill",
            "r03d": "cloud.heavyrain.fill",
            "r03n": "cloud.heavyrain.fill",
            "f01d": "cloud.rain.fill",
            "f01n": "cloud.rain.fill",
            "r04d": "cloud.drizzle.fill",
            "r04n": "cloud.drizzle.fill",
            "r05d": "cloud.sun.fill",
            "r05n": "cloud.fill",
            "r06d": "cloud.heavyrain.fill",
            "r06n": "cloud.heavyrain.fill",
            "s01d": "cloud.snow.fill",
            "s01n": "cloud.snow.fill",
            "s02d": "cloud.snow.fill",
            "s02n": "cloud.snow.fill",
            "s03d": "cloud.snow.fill",
            "s03n": "cloud.snow.fill",
            "s04d": "cloud.snow.fill",
            "s04n": "cloud.snow.fill",
            "s05d": "wind.circle.fill",
            "s05n": "wind.circle.fill",
            "s06d": "wind.circle.fill",
            "s06n": "wind.circle.fill",
            "a01d": "cloud.fog.fill",
            "a01n": "cloud.fog.fill",
            "a02d": "cloud.fog.fill",
            "a02n": "cloud.fog.fill",
            "a03d": "cloud.fog.fill",
            "a03n": "cloud.fog.fill",
            "a04d": "cloud.fog.fill",
            "a04n": "cloud.fog.fill",
            "a05d": "cloud.fog.fill",
            "a05n": "cloud.fog.fill",
            "a06d": "cloud.fog.fill",
            "a06n": "cloud.fog.fill",
            "c01d": "sun.max.fill",
            "c01n": "moon.fill",
            "c02d": "cloud.sun.fill",
            "c02n": "cloud.moon.fill",
            "c03d": "cloud.sun.fill",
            "c03n": "cloud.moon.fill",
            "c04d": "smoke.fill",
            "c04n": "smoke.fill",
            "u00d": "aqi.high",
            "u00n": "aqi.high"
        ]
        let myImage = images[self]
        return myImage
    }
}
