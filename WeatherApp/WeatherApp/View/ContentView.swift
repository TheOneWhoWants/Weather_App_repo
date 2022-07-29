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
    @State private var currentWeather: DayOfTheWeek?
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
            VStack {
                List {
                    Section {
                        VStack{
                            VStack{
                                Text(json?.city_name ?? "Unknown city")
                                    .frame(width: 300, height: 40)
                                    .font(.system(size: 35, weight: .medium, design: .default))
                                    .foregroundColor(Color.white)
                                VStack(spacing: 1){
                                    VStack{
                                        Image(systemName: currentWeather?.weather.icon.nameToImage()! ?? "")
                                            .renderingMode(.original)
                                            .resizable()
                                            .aspectRatio                (contentMode: .fill)
                                            .frame(width: 50, height: 70, alignment: .center)
                                        if currentWeather?.pop ?? 0 > 0 {
                                            Text("\(currentWeather!.pop)%")
                                                .font(.system(size: 30, weight: .medium, design: .default))
                                                .foregroundColor(.blue)
                                        }
                                    }
                                    Text("Today")
                                        .font(.system(size: 25, weight: .medium, design: .default))
                                        .foregroundColor(.white)
                                        .padding()
                                    HStack(alignment: .top){
                                        Spacer()
                                        Text("Min: \(Int(currentWeather?.low_temp ?? 0))°")
                                            .font(.system(size: 20, weight: .medium, design: .default))
                                            .foregroundColor(.white)
                                            .padding(.trailing, 0)
                                        Text("Max: \(Int(currentWeather?.high_temp ?? 0))°")
                                            .font(.system(size: 20, weight: .medium, design: .default))
                                            .foregroundColor(.white)
                                            .padding(.trailing, 0)
                                        Spacer()
                                    }.padding(.top, 0)
                                    
                                }
                            }
                        }.padding()
                    }.listRowBackground(Color.clear)
                    
                    ForEach(jsonData) { oneDayForecast in
                        HStack{
                            HStack{
                                Text(oneDayForecast.datetime.getDayOfWeek(format: "yyyy-MM-dd")!)
                                    .frame(width: 50, alignment: .leading)
                                    .font(.system(size: 20, weight: .medium, design: .default))
                                    .foregroundColor(.white)
                                    .padding()
                                Spacer()
                                HStack{
                                    
                                    VStack{
                                        Image(systemName: oneDayForecast.weather.icon.nameToImage()!)
                                            .renderingMode(.original)
                                            .resizable()
                                            .aspectRatio                (contentMode: .fill)
                                            .frame(width: 10, height: 20, alignment: .top)
                                        if oneDayForecast.pop > 0 {
                                            Text("\(oneDayForecast.pop)%")
                                                .font(.system(size: 12, weight: .medium, design: .default))
                                                .foregroundColor(.blue)
                                            
                                        }
                                    }.padding(.trailing, 0)
                                }
                                Spacer()
                            }
                            Spacer()
                            Text("Min: \(Int(oneDayForecast.low_temp))°")
                                .font(.system(size: 13, weight: .medium, design: .default))
                                .foregroundColor(.white)
                                .frame(width: 60, alignment: .leading)
                                .padding()
                            Spacer()
                            Text("Max: \(Int(oneDayForecast.high_temp))°")
                                .font(.system(size: 13, weight: .medium, design: .default))
                                .foregroundColor(.white)
                                .frame(width: 60, alignment: .leading)
                                .padding(.trailing, 0)
                            Spacer()
                            
                        }.listRowBackground(
                            Color.cyan.opacity(0.5)
                        )
                        .listRowBackground(Color.clear)
                        
                    }
                }.onAppear {
                    FetchData(latitude: currentLocation.lastLocation?.coordinate.latitude ?? 35.7796, longtitude: currentLocation.lastLocation?.coordinate.longitude ?? -78.6382, apiKey: "f8de3575158a471ebe59ab2e62ba8d2d").getJSON { json in
                        self.jsonData = json.data
                        self.jsonData.removeFirst()
                    }
                }
                
                Button {
                    NavigationLink(destination: Text("Choose city")) {
                        
                    }
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
                    self.currentWeather = json.data[0]
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



