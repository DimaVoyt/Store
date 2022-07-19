//
//  AppDelegate.swift
//  testovoe
//
//  Created by Дмитрий Войтович on 18.07.2022.
//

import UIKit
import Firebase


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let navigationController: MainNavigationController = {
        let c = MainNavigationController()
        return c
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.black
        window?.rootViewController = navigationController        
        return true
    }
}

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            switchToMain()
        } else {
            switchToLogin()
        }
    }
    
    func switchToLogin() {
        let loginController = LoginViewController()
        setViewControllers([loginController], animated: false)
    }
    
    func switchToMain() {
        let viewController = ProductsViewController()
        setViewControllers([viewController], animated: false)
    }
}

var navigation: MainNavigationController {
    return (UIApplication.shared.delegate as! AppDelegate).navigationController
}
