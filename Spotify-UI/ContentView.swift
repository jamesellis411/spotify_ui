//
//  ContentView.swift
//  Spotify-UI
//
//  Created by James Ellis on 9/18/25.
//

import SwiftUI
import Combine

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
                    
                    Button {isLiked.toggle()} label: {
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
    
                    Button {
                        if isPaused{
                            if time >= duration {time = 0}
                            isPaused = false
                        } else {
                            isPaused = true
                        }
                    } label: {
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
            _ in guard !isPaused else {return} //utilized AI to debug the tick
            if time < duration {
                time += 1
            } else{
                isPaused = true //stops at the end of the track
            }
        }
    }
    
    func formatTime(_ seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

#Preview {
    ContentView()
}
