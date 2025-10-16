//
//  SongOptionsSheet.swift
//  Spotify-UI
//
//  Created by James Ellis on 10/16/25.
//

import SwiftUI

enum SongOptionsSheetState {
    case hidden
    case half
    case full
    
    var isVisible: Bool {
        switch self {
        case .hidden: return false
        case .half, .full: return true
        }
    }
    
    func offset(in totalHeight: CGFloat, topInset: CGFloat) -> CGFloat {
        switch self {
        case .hidden:
            return totalHeight + 40
        case .half:
            return totalHeight * 0.45
        case .full:
            return topInset + 12
        }
    }
}

struct SongOptionsSheet: View {
    struct TrackInfo {
        let title: String
        let subtitle: String
        let artworkName: String
    }
    
    @Binding var position: SongOptionsSheetState
    var track: TrackInfo
    
    @GestureState private var dragOffset: CGFloat = 0
    
    private let actions: [(systemImage: String, label: String)] = [
        ("square.and.arrow.up", "Share"),
        ("plus.circle", "Add to playlist"),
        ("xmark.circle", "Exclude track from your taste profile"),
        ("minus.circle", "Remove from this playlist"),
        ("text.badge.plus", "Add to Queue"),
        ("list.bullet", "Go to Queue"),
        ("person.3.fill", "Start a Jam"),
        ("dot.radiowaves.left.and.right", "Go to radio"),
        ("opticaldisc", "Go to album"),
        ("person.crop.circle", "Go to artist"),
        ("ticket.fill", "Go to artist concerts"),
        ("music.note.list", "View song credits"),
        ("alarm", "Sleep timer"),
        ("waveform.path.ecg", "Show Spotify Code")
    ]
    
    var body: some View {
        GeometryReader { geo in
            let totalHeight = geo.size.height
            let topInset = geo.safeAreaInsets.top
            
            VStack(spacing: 0) {
                Spacer()
                
                content()
                    .offset(y: max(position.offset(in: totalHeight, topInset: topInset) + dragOffset, 0))
                    .gesture(
                        DragGesture()
                            .updating($dragOffset) { value, state, _ in
                                state = value.translation.height
                            }
                            .onEnded { value in
                                handleDragEnd(translation: value.translation.height)
                            }
                    )
            }
        }
        .ignoresSafeArea()
    }
    
    private func content() -> some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 2)
                .frame(width: 48, height: 4)
                .foregroundColor(.white.opacity(0.4))
                .padding(.top, 12)
                .padding(.bottom, 16)
            
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 16) {
                    Image(track.artworkName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 52, height: 52)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(track.title)
                            .font(.headline)
                            .foregroundStyle(.white)
                        
                        Text(track.subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.7))
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
            
            Divider().overlay(Color.white.opacity(0.1))
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(actions.indices, id: \.self) { index in
                        let item = actions[index]
                        SongOptionRow(systemImage: item.systemImage, label: item.label)
                            .padding(.horizontal)
                            .padding(.vertical, 14)
                        
                        if index != actions.count - 1 {
                            Divider().overlay(Color.white.opacity(0.06))
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.94))
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .padding(.horizontal, 10)
        .padding(.bottom, 10)
        .shadow(color: Color.black.opacity(0.45), radius: 20, x: 0, y: -12)
    }
    
    private func handleDragEnd(translation: CGFloat) {
        let threshold: CGFloat = 120
        withAnimation(.spring(response: 0.45, dampingFraction: 0.85)) {
            switch position {
            case .half:
                if translation < -threshold {
                    position = .full
                } else if translation > threshold {
                    position = .hidden
                } else {
                    position = .half
                }
            case .full:
                if translation > threshold {
                    position = .half
                } else {
                    position = .full
                }
            case .hidden:
                break
            }
        }
    }
}

private struct SongOptionRow: View {
    let systemImage: String
    let label: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: systemImage)
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 28)
            
            Text(label)
                .foregroundColor(.white)
                .font(.body)
            
            Spacer()
        }
    }
}
