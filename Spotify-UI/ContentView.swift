//
//  ContentView.swift
//  Spotify-UI
//
//  Created by James Ellis on 9/18/25.
//

import SwiftUI
import Combine

extension Color {
    static let spotifyGreen = Color(red: 30/255, green: 215/255, blue: 96/255)
}

struct ContentView: View {
    @State private var time: Double = 0 //part of slider
    let duration: Double = 226 //length of song
    
    @State private var isLiked: Bool = false
    @State private var isPaused: Bool = false
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.lightPurpleAF2.opacity(1), .purpleAF2.opacity(1)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea() //allows background to stretch across entire screen
            
            VStack {
                
                HStack{
                    Image(systemName: "chevron.down")
                        .font(.title2)
                    Spacer()
                    Text("Alfredo 2")
                        .font(.subheadline.bold())
                    Spacer()
                    Image(systemName: "ellipsis")
                        .font(.title2)
                }
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.top, 8)
                
                Spacer()
                
                // Album art
                Image("Album Cover")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 360)
                    .cornerRadius(8)
                        
                Spacer()
                
                HStack{
                    VStack(spacing: 6){
                        Text("Ensalada (feat. Anderson .Paak)")
                                .font(Font.title2.bold())
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        
                        HStack(spacing: 4){
                            Image("explicitE")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18)
                            MarqueeText(
                                text: "Freddie Gibbs, The Alchemist, Anderson .Paak",
                                font: .subheadline,
                                speed: 8
                            )
                            .foregroundColor(.explicitgray)
                            .frame(height: 20)
                        }
                        .padding(.bottom, 6)
                    }
                    
                    Spacer()
                    
                    Button {
                        isLiked.toggle()
                    } label: {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .font(.title)
                            .foregroundColor(isLiked ? .spotifyGreen : .white)
                    }
                    
                }
                .padding(.top, 4)
                
                VStack(spacing: 2){
                    SpotifySlider(value: $time, range: 0...duration)
                    
                    HStack{
                        Text(formatTime(time))
                            .font(Font.caption.bold())
                            .monospacedDigit() //keeps time from moving without stop
                        
                        Spacer()
                        
                        Text(formatTime(duration - time))
                            .font(Font.caption.bold())
                            .monospacedDigit()
                    }
                    .foregroundColor(Color.white.opacity(0.7))
                    .padding(.bottom, 24)
                }
                
                HStack(spacing:47){
                    Image("Shuffle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
                    Image("backwardStep")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
    
                    Button {isPaused.toggle()} label: {
                        Image(systemName: isPaused ? "play.circle.fill" : "pause.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 55)
                            .foregroundColor(.white)
                    }
                    
                    Image("forwardStep")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
                    Image("repeat")
                        .resizable()
                        .scaledToFit()
                        .frame(width:32)
                }
                .padding(.bottom)
                
                HStack(spacing:30){
                    Image("connect")
                        .resizable()
                        .scaledToFit()
                        .frame(width:35)
                    
                    Spacer()
                    
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .scaledToFit()
                        .frame(width:18)
                        .foregroundColor(.white)

                    Image("queue")
                        .resizable()
                        .scaledToFit()
                        .frame(width:30)
                }
            }
            .padding(.horizontal)
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) {
            _ in if time < duration {
                time += 1
            }
        }
    }
    
    func formatTime(_ seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

struct SpotifySlider: View {
    //utilized AI to replicate a spotify's slider appearance
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
        .frame(height: 20) // tappable area
    }
}

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
        
        // Reset offset to start at 0
        offset = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.linear(duration: speed)) {
                offset = -textWidth - 40
            }
            
            // After finishing, restart
            DispatchQueue.main.asyncAfter(deadline: .now() + speed + 1) {
                startAnimation()
            }
        }
    }
}

#Preview {
    ContentView()
}
