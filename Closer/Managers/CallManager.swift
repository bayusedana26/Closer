//
//  CallManager.swift
//  Closer
//
//  Created by Bayu Sedana on 10/02/25.
//

import Foundation
import StreamVideo
import StreamVideoUIKit
import StreamVideoSwiftUI

/// Singleton class to manage video call setup
final class CallManager {
    // MARK: - Shared Instance
    static let shared = CallManager()
    
    // MARK: - Private Constants
    private struct Constants {
        static let apiKey = "68cvkq3ftjst" // Store API key safely
        static let userToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3Byb250by5nZXRzdHJlYW0uaW8iLCJzdWIiOiJ1c2VyL0phaW5hX1NvbG8iLCJ1c2VyX2lkIjoiSmFpbmFfU29sbyIsInZhbGlkaXR5X2luX3NlY29uZHMiOjYwNDgwMCwiaWF0IjoxNzM5MjAyNzU1LCJleHAiOjE3Mzk4MDc1NTV9.UA63stPsHqzl_fqiWbLLQ_whIgDuYEi6quYYH1l5A8w" // Replace with dynamic secure fetching
    }
    
    // MARK: - Properties
    private var video: StreamVideo?
    private var videoUI: StreamVideoUI?
    private(set) var callViewModel: CallViewModel?
    
    /// Represents user credentials needed for authentication
    private struct UserCredentials {
        let user: User
        let token: UserToken
    }
    
    // MARK: - Initializer
    private init() {} // Prevent external initialization

    /// Sets up the video call environment
    /// - Parameter email: Email to register as a guest user
    @MainActor func setUp(email: String) {
        guard video == nil, videoUI == nil else { return } // Prevent re-initialization
        
        // Initialize Call ViewModel
        setUpCallViewModel()
        
        // Create user credentials
        let credentials = UserCredentials(
            user: .guest(email),
            token: UserToken(rawValue: Constants.userToken)
        )
        
        // Initialize Stream Video
        let video = StreamVideo(
            apiKey: Constants.apiKey,
            user: credentials.user,
            token: credentials.token
        ) { completion in
            completion(.success(credentials.token)) // Correct way to return the token
        }
        
        // Assign instances to property
        self.video = video
        
        // Initialize Stream Video UI
        self.videoUI = StreamVideoUI(streamVideo: video)
    }
    
    /// Initializes the CallViewModel only once
    @MainActor private func setUpCallViewModel() {
        if callViewModel == nil {
            callViewModel = CallViewModel()
        }
    }
    
    /// Updates the token if needed
    private func updateToken(_ newToken: UserToken) {
        // Update logic if token handling is dynamic
        print("New token received: \(newToken.rawValue)")
    }
}

