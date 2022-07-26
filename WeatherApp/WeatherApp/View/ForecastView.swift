//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Matthew  on 17.07.2022.
//

import SwiftUI

struct ForecastView: View {
    
    let dayOfWeek: String
    let imageName: String
    let temperature: Int
    let textSize: CGFloat
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    
    var body: some View {
        VStack(spacing: 10) {
            Text(dayOfWeek)
                .font(.system(size: textSize, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imageWidth, height: imageHeight, alignment: .top)

            Text("\(temperature)°")
                .font(.system(size: textSize + (textSize * 0.3), weight: .medium, design: .default))
                .foregroundColor(.white)
                
        }
    }
}
