# Closer - Video Call App

Closer is a simple FaceTime-like iOS application that enables users to sign up, sign in, sign out, and join video calls. The app is built using **Firebase Authentication** for user management and **Stream Video** for real-time video calls.

## Features
- User Authentication (Sign Up, Sign In, Sign Out) using Firebase
- Join and participate in video calls using Stream Video
- Real-time call state management
- Simple UI with SwiftUI and UIKit

## Tech Stack
- **Language:** Swift
- **Frameworks:** SwiftUI, UIKit, Combine
- **Backend Services:** Firebase Authentication, Stream Video API
- **Dependency Management:** Swift Package Manager (SPM)

## Installation
1. Clone this repository:
   ```sh
   git clone https://github.com/bayusedana26/Closer.git
   cd Closer
   ```
2. Open the project in Xcode.
3. Install dependencies using Swift Package Manager (SPM).
4. Set up **Firebase**:
   - Create a Firebase project.
   - Download `GoogleService-Info.plist` and add it to the project.
   - Enable **Email/Password Authentication** in Firebase Console.
5. Set up **Stream Video**:
   - Create a [Stream Video](https://getstream.io/video/) account.
   - Obtain your API Key and Secret.
   - Store the API Key in `Constants.swift`.

## Configuration
Modify `Constants.swift` to add your credentials:
```swift
struct Constants {
    static let apiKey = "YOUR_STREAM_API_KEY"
    static let userToken = "YOUR_GENERATED_JWT_TOKEN"
}
```

## Usage
### Authentication
- **Sign Up**: Users can create an account using Firebase Authentication.
- **Sign In**: Users can log in and access the call feature.
- **Sign Out**: Users can log out anytime.

### Video Calls
- **Join Call**: Users can join a video call with a pre-defined `callId`.
- **Incoming Calls**: The app listens for incoming calls and displays UI accordingly.

## Contributing
1. Fork the repository.
2. Create a new branch: `git checkout -b feature-branch`.
3. Commit your changes: `git commit -m "Add new feature"`.
4. Push to the branch: `git push origin feature-branch`.
5. Create a Pull Request.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
