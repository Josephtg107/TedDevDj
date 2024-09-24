//
//  ContentView.swift
//  TedDevDj
//
//  Created by Joseph Garcia on 24/09/24.
//

import SwiftUI
import AVKit
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var selectedAudioFile1: URL? = nil
    @State private var selectedAudioFile2: URL? = nil
    @State private var selectedVideoFile: URL? = nil
    @State private var isShowingAudioPicker1 = false
    @State private var isShowingAudioPicker2 = false
    @State private var isShowingVideoPicker = false
    @State private var gain: Double = 0.5
    @State private var bass: Double = 0.5
    @State private var treble: Double = 0.5
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button(action: {
                        isShowingAudioPicker1 = true
                    }) {
                        Text(selectedAudioFile1 == nil ? "Select Audio 1" : selectedAudioFile1?.lastPathComponent ?? "Audio 1")
                            .frame(width: 450, height: 69)
                            .background(Color(UIColor.systemGray4))
                            .cornerRadius(10)
                            .foregroundColor(.primary)
                    }
                    .sheet(isPresented: $isShowingAudioPicker1) {
                        DocumentPickerView(supportedTypes: [UTType.audio]) { url in
                            selectedAudioFile1 = url
                        }
                    }
                    
                    Text("TedDevDj")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding()
                    
                    Button(action: {
                        isShowingAudioPicker2 = true
                    }) {
                        Text(selectedAudioFile2 == nil ? "Select Audio 2" : selectedAudioFile2?.lastPathComponent ?? "Audio 2")
                            .frame(width: 450, height: 69)
                            .background(Color(UIColor.systemGray4))
                            .cornerRadius(10)
                            .foregroundColor(.primary)
                    }
                    .sheet(isPresented: $isShowingAudioPicker2) {
                        DocumentPickerView(supportedTypes: [UTType.audio]) { url in
                            selectedAudioFile2 = url
                        }
                    }
                }
                .padding()
                
                // Colored Buttons for User Actions
                HStack {
                    ColorButton(color: .red)
                    ColorButton(color: .blue)
                    ColorButton(color: .green)
                    ColorButton(color: .yellow)
                }
                .padding()
                
                // Vertical Sliders and Audio Controls
                HStack(spacing: 50) {
                    VStack {
                        Text("+").font(.title).padding(.bottom, 5)
                        Slider(value: $gain, in: 0...1)
                            .rotationEffect(.degrees(-90))  // Make it vertical
                            .frame(height: 150)
                        Text("-").font(.title).padding(.top, 5)
                        Text("Gain").font(.headline).padding(.top, 5)
                    }
                    VStack {
                        Text("+").font(.title).padding(.bottom, 5)
                        Slider(value: $bass, in: 0...1)
                            .rotationEffect(.degrees(-90))  // Make it vertical
                            .frame(height: 150)
                        Text("-").font(.title).padding(.top, 5)
                        Text("Bass").font(.headline).padding(.top, 5)
                    }
                    VStack {
                        Text("+").font(.title).padding(.bottom, 5)
                        Slider(value: $treble, in: 0...1)
                            .rotationEffect(.degrees(-90))  // Make it vertical
                            .frame(height: 150)
                        Text("-").font(.title).padding(.top, 5)
                        Text("Treble").font(.headline).padding(.top, 5)
                    }
                }
                .padding()
                
                // Video Player Section
                VStack {
                    Text("Video Player")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Button(action: {
                        isShowingVideoPicker = true
                    }) {
                        Text(selectedVideoFile == nil ? "Select Video File" : selectedVideoFile?.lastPathComponent ?? "Video File")
                            .frame(width: 300, height: 60)
                            .background(Color.red.opacity(0.7))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .sheet(isPresented: $isShowingVideoPicker) {
                        DocumentPickerView(supportedTypes: [UTType.movie]) { url in
                            selectedVideoFile = url
                        }
                    }
                    
                    if let videoURL = selectedVideoFile {
                        VideoPlayer(player: AVPlayer(url: videoURL))
                            .frame(height: 200)
                            .cornerRadius(10)
                    } else {
                        Text("No Video Selected")
                            .frame(width: 300, height: 200)
                            .background(Color(UIColor.systemGray4))
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        }
    }
}

struct MainView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 100) {
                TopAudioSelectors()
                    .padding(.horizontal)
                
                TopMiddleButtons()
                    .padding(.horizontal)
                
                MiddleButtons()
                Spacer()
            }
        }
        .background(Color(UIColor.systemBackground))
        .edgesIgnoringSafeArea(.all)
    }
}

struct TopAudioSelectors: View {
    @State private var selectedAudioFile1: URL? = nil
    @State private var selectedAudioFile2: URL? = nil
    @State private var isShowingAudioPicker1 = false
    @State private var isShowingAudioPicker2 = false
    
    @State private var audioMetadata1: AudioMetadata? = nil
    @State private var audioMetadata2: AudioMetadata? = nil

    var body: some View {
        GeometryReader { geometry in
            HStack {
                // Audio Selector 1
                VStack {
                    Button(action: {
                        isShowingAudioPicker1 = true
                    }) {
                        Text(selectedAudioFile1 == nil ? "Select Audio 1" : selectedAudioFile1?.lastPathComponent ?? "Audio 1")
                            .frame(width: geometry.size.width * 0.35, height: 69)
                            .background(Color(UIColor.systemGray4))
                            .cornerRadius(10)
                            .foregroundColor(.primary)
                    }
                    .sheet(isPresented: $isShowingAudioPicker1) {
                        DocumentPickerView(supportedTypes: [UTType.audio]) { url in
                            selectedAudioFile1 = url
                            audioMetadata1 = extractAudioMetadata(from: url)
                        }
                    }
                    
                    if let metadata = audioMetadata1 {
                        AudioMetadataView(metadata: metadata)
                    }
                }
                
                Spacer()

                Text("TedDevDj")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding()
                    .frame(width: geometry.size.width * 0.2)
                
                Spacer()
                
                // Audio Selector 2
                VStack {
                    Button(action: {
                        isShowingAudioPicker2 = true
                    }) {
                        Text(selectedAudioFile2 == nil ? "Select Audio 2" : selectedAudioFile2?.lastPathComponent ?? "Audio 2")
                            .frame(width: geometry.size.width * 0.35, height: 69)
                            .background(Color(UIColor.systemGray4))
                            .cornerRadius(10)
                            .foregroundColor(.primary)
                    }
                    .sheet(isPresented: $isShowingAudioPicker2) {
                        DocumentPickerView(supportedTypes: [UTType.audio]) { url in
                            selectedAudioFile2 = url
                            audioMetadata2 = extractAudioMetadata(from: url)
                        }
                    }
                    
                    if let metadata = audioMetadata2 {
                        AudioMetadataView(metadata: metadata)
                    }
                }
            }
            .padding()
        }
    }
}

struct TopMiddleButtons: View {
    @State private var buttonColor1: Color = .blue
    @State private var buttonColor2: Color = .blue
    @State private var buttonColor3: Color = .blue
    @State private var buttonColor4: Color = .blue
    @State private var buttonColor5: Color = .blue
    @State private var buttonColor6: Color = .blue
    
    @State private var fadeOut: Double = 0.5
    
    var body: some View {
        HStack(spacing: 10) {
            ButtonView(color: $buttonColor1)
            PauseButtonView(color: $buttonColor2)
            PauseButtonView(color: $buttonColor3)
            
            VStack {
                Slider(value: $fadeOut, in: 0...1)
                Text("Fade Out")
                    .font(.footnote)
            }
            .frame(maxWidth: .infinity, minHeight: 69)
            
            PauseButtonView(color: $buttonColor5)
            PauseButtonView(color: $buttonColor6)
            ButtonView(color: $buttonColor4)
        }
        .frame(maxWidth: .infinity, minHeight: 80)
        .padding()
    }
}

struct MiddleButtons: View {
    @State private var isShowingVideoPicker = false
    @State private var selectedVideoFile: URL? = nil
    @State private var volume: Double = 0.5
    
    var body: some View {
        HStack {
            // First Slider with Top and Bottom Icons
            VStack(spacing: 20) {
                Image(systemName: "plus.rectangle.fill")
                    .font(.title)
                    .padding(.bottom, 10)
                
                Slider(value: $volume, in: 0...1)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 169, height: 150) // Fixed size for balance
                    .padding(.vertical, 10)
                
                Image(systemName: "minus.rectangle.fill")
                    .font(.title)
                    .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            
            // Color Buttons in a 2x2 Grid with padding
            VStack {
                HStack {
                    ColorButton(color: .red)
                    ColorButton(color: .blue)
                }
                .padding(.horizontal, 8)
                
                HStack {
                    ColorButton(color: .green)
                    ColorButton(color: .yellow)
                }
                .padding(.horizontal, 8)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Two Center Sliders closer together
            HStack(spacing: 0) {  // Set spacing to 0 to bring sliders closer
                VStack {
                    Slider(value: $volume, in: 0...1)
                        .rotationEffect(.degrees(-90))
                        .frame(width: 150, height: 150)
                }
                .frame(width: 150) // Fixed width for this slider

                VStack {
                    Slider(value: $volume, in: 0...1)
                        .rotationEffect(.degrees(-90))
                        .frame(width: 150, height: 150)
                }
                .frame(width: 150) // Fixed width for this slider
            }
            .frame(width: 300) // Fix total width to keep sliders closer together
            
            // Video Player with Button Underneath
            VStack(spacing: 20) {
                if let videoURL = selectedVideoFile {
                    VideoPlayer(player: AVPlayer(url: videoURL))
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .cornerRadius(10)
                } else {
                    Text("No Video Selected")
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .background(Color(UIColor.systemGray4))
                        .cornerRadius(10)
                }

                // Button underneath the video view
                Button(action: {
                    isShowingVideoPicker = true
                }) {
                    Text(selectedVideoFile == nil ? "Select Video File" : selectedVideoFile?.lastPathComponent ?? "Video File")
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .background(Color.red.opacity(0.7))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                .sheet(isPresented: $isShowingVideoPicker) {
                    DocumentPickerView(supportedTypes: [UTType.movie]) { url in
                        selectedVideoFile = url
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            
            // Third Slider with Top and Bottom Icons
            VStack(spacing: 20) {
                Image(systemName: "plus.rectangle.fill")
                    .font(.title)
                    .padding(.bottom, 10)
                
                Slider(value: $volume, in: 0...1)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 169, height: 150)
                    .padding(.vertical, 10)
                
                Image(systemName: "minus.rectangle.fill")
                    .font(.title)
                    .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Stretch entire HStack
        .padding()
    }
}

#Preview {
    MainView()
}
