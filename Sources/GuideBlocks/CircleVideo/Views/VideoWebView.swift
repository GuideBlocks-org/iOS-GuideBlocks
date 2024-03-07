//
//  VideoWebView.swift
//  GuideBlocks
//
//  Created by David Jones on 2023/12/11.
//  Copyright © 2024 Contextual.
//

import SwiftUI
import WebKit

struct VideoWebView: UIViewRepresentable {
    let url: URL?
    let videoIsPlaying: () -> ()
    
    let webView = WKWebView()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(videoWebView: self)
    }

    func makeUIView(context: Context) -> WKWebView {
        circleVideoViewModel.guideIsVisible = true
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = url {
            uiView.load(URLRequest(url: url))
        }
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var videoWebView: VideoWebView
        var timer: Timer?
        var elapsedTime: TimeInterval = 0
        let totalTime: TimeInterval = 60 // Total duration in seconds
        
        init(videoWebView: VideoWebView) {
            self.videoWebView = videoWebView
            super.init()
            
            // Set up WKNavigationDelegate
            videoWebView.webView.navigationDelegate = self
            
            // Start observing for video playback
            startObservingVideoPlayback()
        }
        
        func startObservingVideoPlayback() {
            // Create and schedule a repeating timer
            timer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(checkVideoPlayback),
                userInfo: nil,
                repeats: true
            )
        }
        
        @objc func checkVideoPlayback() {
            // JavaScript code to detect video playback
            let javascript = """
            (function() {
                var videos = document.querySelectorAll('video');
                var playing = false;
                videos.forEach(function(video) {
                    if (!video.paused) {
                        playing = true;
                    }
                });
                return playing;
            })();
            """
            
            // Evaluate JavaScript code in WKWebView
            videoWebView.webView.evaluateJavaScript(javascript) { [weak self] result, error in
                guard let self else { return }
                if let error = error {
                    print("Error evaluating JavaScript: \(error)")
                    return
                }
                
                // Check if result indicates video playback
                if let isPlaying = result as? Bool, isPlaying {
                    print("Video is playing")
                    self.videoWebView.videoIsPlaying()
                    stopObservingVideoPlayback()
                } else {
                    //print("No video is playing, elapsedTime: \(elapsedTime)")
                }
            }
            
            // Increment elapsed time
            elapsedTime += 1
            
            // Stop timer if elapsed time reaches total time
            if elapsedTime >= totalTime || !circleVideoViewModel.guideIsVisible {
                stopObservingVideoPlayback()
            }
        }
        
        func stopObservingVideoPlayback() {
            //print("stopObservingVideoPlayback")
            // Invalidate the timer to stop it from firing
            timer?.invalidate()
            timer = nil
        }
    }
}
