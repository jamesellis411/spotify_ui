//
//  ContentView.swift
//  Spotify-UI
//
//  Created by James Ellis on 9/18/25.
//

import SwiftUI

struct ContentView: View {
    @State private var time: Double = 0 //part of slider
    var body: some View {
        let duration: Double = 226 //length of song
        let remaining: Double = duration - time //right time on slider
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.lightPurpleAF2.opacity(1), .purpleAF2.opacity(1)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea() //allows background to stretch across entire screen
            VStack (spacing: 40){
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
                
                HStack{
                    Image("Album Cover")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(13)
                }
                        
                
                HStack{
                    VStack(spacing: 8){
                        Text("Ensalada (feat. Anderson .Paak)")
                                .font(Font.title2.bold())
                                .foregroundColor(.white)
                        
                        HStack(spacing: 4){
                            Image("explicitE")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18)
                            Text("Freddie Gibbs, The Alchemist, Anderson .Paak")
                                .font(Font.subheadline)
                                .lineLimit(1)
                                .foregroundColor(.explicitgray)

                        }
                    }
                    Spacer()
                    Image(systemName: "heart")
                        .font(.title)
                        .foregroundColor(.white)
                }
                
                VStack(spacing: 18){
                    Slider(value: $time, in: 0...226)
                    HStack{
                        Text("\(Int($time.wrappedValue) / 60):0\(Int($time.wrappedValue) % 60)")
                            .font(Font.caption.bold())
                        Spacer()
                        Text("\(Int(remaining) / 60):\(Int(remaining) % 60)")
                            .font(Font.caption.bold())
                    }
                    .foregroundColor(Color.white.opacity(0.7))
                    

                HStack(spacing:53){
                    Image("Shuffle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
                    Image("backwardStep")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
                    Image(systemName: "pause.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundColor(.white)
                    Image("forwardStep")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
                    Image("repeat")
                        .resizable()
                        .scaledToFit()
                        .frame(width:32)
                        }
                
                    
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
            }
            .padding(.horizontal)

        }
    }
}

#Preview {
    ContentView()
}
