//
//  WelcomeViewController.swift
//  Closer
//
//  Created by Bayu Sedana on 10/02/25.
//

import UIKit

// Auth sign up/in
// Join call (stream)
// Sign out

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sign In"
        view.backgroundColor = .systemBlue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Dummy account for test
        AuthManager.shared.signUp(email: "test1@gmail.com", password: "123456") { [weak self] done in
            guard done else { return }
            
            DispatchQueue.main.async {
                self?.showAccount()
            }
        }
    }
    private func showAccount() {
        let accountVC = UINavigationController(rootViewController: AccountViewController())
        accountVC.modalPresentationStyle = .fullScreen
        present(accountVC, animated: true)
    }
}

