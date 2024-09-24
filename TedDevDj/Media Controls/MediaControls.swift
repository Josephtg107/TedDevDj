//
//  MediaControls.swift
//  TedDevDj
//
//  Created by Joseph Garcia on 24/09/24.
//

import SwiftUI

struct ColorButton: View {
    var color: Color
    
    var body: some View {
        Button(action: {
            
        }) {
            Rectangle()
                .fill(color)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
        }
    }
}

struct AudioMetadataView: View {
    let metadata: AudioMetadata
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("File: \(metadata.fileName)")
            Text("Duration: \(formatTime(metadata.duration))")
            Text("Current Time: \(formatTime(metadata.currentTime))")
        }
        .font(.footnote)
        .foregroundColor(.secondary)
        .padding(.top, 8)
    }
    
    private func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct ButtonView: View {
    @Binding var color: Color
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(maxWidth: .infinity, minHeight: 80) // Dynamic width, fixed height
            .cornerRadius(10)
            .onTapGesture {
                // Example color cycling
                if color == .blue {
                    color = .red
                } else if color == .red {
                    color = .green
                } else {
                    color = .blue
                }
            }
    }
}

struct PauseButtonView: View {
    @Binding var color: Color
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(maxWidth: .infinity, minHeight: 80)
            .cornerRadius(10)
            .onTapGesture {
                // Cycle colors
                if color == .blue {
                    color = .purple
                } else if color == .purple {
                    color = .orange
                } else {
                    color = .blue
                }
            }
    }
}
