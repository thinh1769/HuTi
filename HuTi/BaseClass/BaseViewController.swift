//
//  BaseViewController.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 17/02/2023.
//

import UIKit

class BaseViewController: UIViewController {
 
    var isHiddenNavigationBar = false {
        didSet {
            self.navigationController?.isNavigationBarHidden = isHiddenNavigationBar
        }
    }
    
    var isTouchDismissKeyboardEnabled = false {
        didSet {
            if isTouchDismissKeyboardEnabled {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                tapGesture.cancelsTouchesInView = false
                view.addGestureRecognizer(tapGesture)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isHiddenNavigationBar = true
    }
    
    @objc func dismissKeyboard() {
        view.window?.endEditing(true)
    }
    
    func navigateTo(_ controller: UIViewController, _ animated: Bool = true) {
        self.navigationController?.pushViewController(controller, animated: animated)
    }
    
    func setRootTabBar() {
        guard let window = UIApplication.shared.windows.first else { return }
        window.rootViewController = MainTabBarController()
        window.makeKeyAndVisible()
        
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionCrossDissolve],
                          animations: {},
                          completion: nil)
    }
}
