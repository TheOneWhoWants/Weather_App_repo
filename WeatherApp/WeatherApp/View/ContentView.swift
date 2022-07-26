//
//  ContentView.swift
//  WeatherApp
//
//  Created by Matthew  on 15.07.2022.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    @Namespace private var namespace
        @ObservedObject private var currentLocation = LocationManager()
    @State private var json: ForecastData?
    @State private var jsonData: [DayOfTheWeek] = []
    
    fileprivate func getDayOfWeek(_ date:String, format: String) -> String? {
        
        let weekDays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]

        let formatter  = DateFormatter()
        formatter.dateFormat = format
        guard let myDate = formatter.date(from: date) else { return nil }
        
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: myDate)
        
        
        return weekDays[weekDay-1]
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 40) {
                Text(json?.city_name ?? "Your Location")
                    .frame(width: 300, height: 40)
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .background(.white)
                    .cornerRadius(18)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(.blue, lineWidth: 1))
                    .padding(.top, 20.0)
                
                List(jsonData) { oneDayForecast in
                    Section{
                        VStack{                            HStack {
                                Text("Low: \(Int(oneDayForecast.low_temp))°")
                                    .font(.system(size: 30, weight: .medium, design: .default))
                                    .foregroundColor(.white)
                                    .padding()
                                Spacer()
                                Text("Max: \(Int(oneDayForecast.high_temp))°")
                                    .font(.system(size: 30, weight: .medium, design: .default))
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            Spacer()
                            Image(systemName: oneDayForecast.weather.icon.nameToImage()!)
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio                (contentMode: .fill)
                                .frame(width: 120, height: 110, alignment: .top)
                            Spacer()
                            HStack(alignment: .bottom) {
                                
                                Text("Rain: \(oneDayForecast.pop)%")
                                    .font(.system(size: 30, weight: .medium, design: .default))
                                    .foregroundColor(.white)
                                    .padding()
                                Spacer()
                                Text(oneDayForecast.datetime.getDayOfWeek(format: "yyyy-MM-dd")!)
                                    .font(.system(size: 30, weight: .medium, design: .default))
                                    .foregroundColor(.white)
                                    .padding()
                            }.padding(.bottom, 40)
                            
                        }.listRowBackground(Color.cyan)
                        
                            .padding(.top, 40)
                            .listRowBackground(Color.clear)
                    }

                }.onAppear {
                    FetchData(latitude: currentLocation.lastLocation?.coordinate.latitude ?? 35.7796, longtitude: currentLocation.lastLocation?.coordinate.longitude ?? -78.6382, apiKey: "f8de3575158a471ebe59ab2e62ba8d2d").getJSON { json in
                        self.jsonData = json.data
                    }
                }
                Button {
                    //
                } label: {
                    Text("CHANGE MY LOCATION")
                        .frame(width: 300, height: 40)
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .background(.white)
                        .cornerRadius(18)
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(.blue, lineWidth: 1))
                }
                .padding(.bottom, 20.0)
            }.onAppear {
                FetchData(latitude: currentLocation.lastLocation?.coordinate.latitude ?? 35.7796, longtitude: currentLocation.lastLocation?.coordinate.longitude ?? -78.6382, apiKey: "f8de3575158a471ebe59ab2e62ba8d2d").getJSON { json in
                    self.json = json
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



