//
//  AccountViewController.swift
//  Closer
//
//  Created by Bayu Sedana on 10/02/25.
//

import Combine
import StreamVideo
import StreamVideoUIKit
import StreamVideoSwiftUI
import UIKit

/// Controller handling account actions and call UI
class AccountViewController: UIViewController {
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private var activeCallVC: CallViewController?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        listenForIncomingCalls()
    }
    
    // MARK: - UI Setup
    private func configureUI() {
        title = "Account"
        view.backgroundColor = .systemGreen
        
        // Navigation Buttons
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Sign Out",
            style: .done,
            target: self,
            action: #selector(signOut)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Join Call",
            style: .done,
            target: self,
            action: #selector(joinCall)
        )
    }
    
    // MARK: - Call Handling
    
    /// Joins a predefined call
    @objc private func joinCall() {
        guard let callViewModel = CallManager.shared.callViewModel else {
            print("Error: CallViewModel not initialized")
            return
        }
        
        callViewModel.joinCall(callType: .default, callId: "default_c58e4664-668c-4f16-a8a1-13856e792a7a")
        showCallUI()
    }
    
    /// Listens for incoming calls and updates UI accordingly
    private func listenForIncomingCalls() {
        guard let callViewModel = CallManager.shared.callViewModel else {
            print("Error: CallViewModel not initialized")
            return
        }
        
        callViewModel.$callingState
            .receive(on: DispatchQueue.main) // Ensures UI updates on main thread
            .sink { [weak self] newState in
                switch newState {
                case .incoming(_):
                    self?.showCallUI()
                case .idle:
                    self?.hideCallUI()
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Authentication
    
    /// Signs the user out and navigates to the welcome screen
    @objc private func signOut() {
        AuthManager.shared.signOut()
        
        let welcomeVC = UINavigationController(rootViewController: WelcomeViewController())
        welcomeVC.modalPresentationStyle = .fullScreen
        present(welcomeVC, animated: true)
    }
    
    // MARK: - UI Call Management
    
    /// Displays the call UI
    private func showCallUI() {
        guard activeCallVC == nil, let callViewModel = CallManager.shared.callViewModel else { return }
        
        let callVC = CallViewController.make(with: callViewModel)
        addChild(callVC)
        callVC.view.frame = view.bounds
        view.addSubview(callVC.view)
        callVC.didMove(toParent: self)
        
        activeCallVC = callVC
    }
    
    /// Hides the call UI
    private func hideCallUI() {
        guard let callVC = activeCallVC else { return }
        
        callVC.willMove(toParent: nil)
        callVC.view.removeFromSuperview()
        callVC.removeFromParent()
        
        activeCallVC = nil
    }
}
