//
//  MarqueeText.swift
//  Spotify-UI
//
//  Created by ChatGPT on 2025-01-29.
//

import SwiftUI

struct MarqueeText: View {
    let text: String
    let font: Font
    let speed: Double
    
    @State private var textWidth: CGFloat = 0
    @State private var containerWidth: CGFloat = 0
    @State private var offset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geo in
            let container = geo.size.width
            
            HStack(spacing: 40) {
                Text(text)
                    .font(font)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .background(
                        GeometryReader { textGeo in
                            Color.clear.onAppear {
                                textWidth = textGeo.size.width
                                containerWidth = container
                                startAnimation()
                            }
                        }
                    )
                
                Text(text)
                    .font(font)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
            }
            .offset(x: offset)
        }
        .clipped()
    }
    
    private func startAnimation() {
        guard textWidth > containerWidth else { return }
        
        offset = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.linear(duration: speed)) {
                offset = -textWidth - 40
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + speed + 1) {
                startAnimation()
            }
        }
    }
}
