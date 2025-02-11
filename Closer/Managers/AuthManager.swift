//
//  AuthManager.swift
//  Closer
//
//  Created by Bayu Sedana on 10/02/25.
//

import Foundation
import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()
    
    var isSignedIn : Bool {
        return Auth.auth().currentUser != nil
    }
    
    @MainActor func signUp(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error creating user: \(error)")
                completion(false)
                return
            }
            CallManager.shared.setUp(email: email)
            completion(true)
        }
    }
    
    @MainActor func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error signing in: \(error)")
                completion(false)
                return
            }
            CallManager.shared.setUp(email: email)
            completion(true)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error)")
        }
    }
}
