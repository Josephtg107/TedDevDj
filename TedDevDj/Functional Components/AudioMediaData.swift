//
//  AudioMediaData.swift
//  TedDevDj
//
//  Created by Joseph Garcia on 24/09/24.
//

import Foundation
import AVFoundation

struct AudioMetadata {
    let fileName: String
    let duration: Double
    let currentTime: Double
}

func extractAudioMetadata(from url: URL) -> AudioMetadata? {
    let asset = AVURLAsset(url: url)
    
    let fileName = url.lastPathComponent
    
    let duration = asset.duration.seconds
    
    let currentTime = 0.0
    
    return AudioMetadata(fileName: fileName, duration: duration, currentTime: currentTime)
}
