//
//  SpotifySlider.swift
//  Spotify-UI
//
//  Created by ChatGPT on 2025-01-29.
//

import SwiftUI

struct SpotifySlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    
    var body: some View {
        GeometryReader { geo in
            let percent = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
            let width = geo.size.width
            
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(height: 2)
                    .foregroundColor(.white.opacity(0.3))
                
                Capsule()
                    .frame(width: CGFloat(percent) * width, height: 2)
                    .foregroundColor(.white)
                
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.white)
                    .offset(x: max(0, min(CGFloat(percent) * width - 6, width - 12)))
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { drag in
                                let newPercent = min(max(0, drag.location.x / width), 1)
                                value = range.lowerBound + Double(newPercent) * (range.upperBound - range.lowerBound)
                            }
                    )
            }
        }
        .frame(height: 20)
    }
}
