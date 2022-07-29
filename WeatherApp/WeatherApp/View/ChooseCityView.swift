//
//  ChooseCity.swift
//  WeatherApp
//
//  Created by Matthew  on 29.07.2022.
//

import SwiftUI

struct ChooseCity: View {
    init(sendCity: @escaping((String) -> Void)) {
        UITableView.appearance().backgroundColor = .clear
        self.sendCity = sendCity
    }
    
    
    @Environment(\.dismiss) var dismiss
    @State private var cityName: String = ""
    let sendCity: ((String) -> Void)
    
    var body: some View {
        ZStack {
            VStack {
                HStack{
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }.foregroundColor(.blue)
                }.padding()
                
                VStack {
                    TextField("What city do you whant to find?", text: $cityName) {
                        
                    }.padding()
                        .frame(height: 40)
                        .cornerRadius(1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray, lineWidth: 1))
                        .padding()
                    Text("Enter city name correctly, in english version")
                        .padding(.top, 0)
                        .foregroundColor(.gray)
                }
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        sendCity(cityName)
                        dismiss()
                    } label: {
                        Text("FIND")
                    }.padding()
                }.padding()
            }
        }
    }
}

struct ChooseCity_Previews: PreviewProvider {
    static var previews: some View {
        ChooseCity { city in }
    }
}
