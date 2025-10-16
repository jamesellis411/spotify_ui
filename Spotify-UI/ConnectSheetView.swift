//
//  ConnectSheetView.swift
//  Spotify-UI
//
//  Created by James Ellis on 10/16/25.
//

import SwiftUI

struct ConnectSheetView: View {
    @Binding var isPresented: Bool
    @State private var autoInviteEnabled = false
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            sheetContent
                .offset(y: max(dragOffset, 0))
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            let translation = value.translation.height
                            state = translation > 0 ? translation : 0
                        }
                        .onEnded { value in
                            if value.translation.height > 120 {
                                closeSheet()
                            }
                        }
                )
                .transition(.move(edge: .bottom))
        }
        .ignoresSafeArea()
    }
    
    private var sheetContent: some View {
        VStack(alignment: .leading, spacing: 24) {
            RoundedRectangle(cornerRadius: 2)
                .frame(width: 48, height: 4)
                .foregroundColor(.white.opacity(0.4))
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text("Connect")
                .font(.title2.weight(.semibold))
                .foregroundColor(.white)
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Label("This iPhone", systemImage: "iphone")
                        .foregroundColor(.spotifyGreen)
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.white.opacity(0.5))
                }
                
                Toggle("Auto-invite people nearby to a Jam", isOn: $autoInviteEnabled)
                    .toggleStyle(SwitchToggleStyle(tint: .spotifyGreen))
                    .foregroundColor(.white.opacity(0.85))
            }
            .padding()
            .background(Color.white.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Label("Don't see your device?", systemImage: "questionmark.circle")
                        .foregroundColor(.white)
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.up")
                        .foregroundColor(.white.opacity(0.5))
                }
                
                Text("Make sure the device is turned on and on the same WiFi network. You also need to allow access to your local network in Settings.")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.7))
                
                HStack {
                    Button {
                        closeSheet()
                    } label: {
                        Text("Dismiss")
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.white.opacity(0.08))
                            .clipShape(Capsule())
                    }
                    
                    Button {
                        // Placeholder for navigation to Settings
                    } label: {
                        Text("Go to Settings")
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.white)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding()
            .background(Color.white.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            
            VStack(alignment: .leading, spacing: 20) {
                Text("No devices found on this network.")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.7))
                
                HStack(spacing: 16) {
                    ConnectActionButton(title: "Start a Jam", systemImage: "person.3.fill")
                    ConnectActionButton(title: "Bluetooth & Airplay", systemImage: "airplayaudio")
                }
            }
            
        }
        .padding(.horizontal, 24)
        .padding(.top, 20)
        .padding(.bottom, 32)
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.94))
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        .padding(.horizontal, 12)
        .padding(.bottom, 12)
        .shadow(color: Color.black.opacity(0.5), radius: 20, x: 0, y: -10)
    }
    
    private func closeSheet() {
        withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
            isPresented = false
        }
    }
}

private struct ConnectActionButton: View {
    let title: String
    let systemImage: String
    
    var body: some View {
        Button {
            // Placeholder for action
        } label: {
            VStack(spacing: 8) {
                Image(systemName: systemImage)
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(width: 48, height: 48)
                    .background(Color.white.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                
                Text(title)
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color.white.opacity(0.06))
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
