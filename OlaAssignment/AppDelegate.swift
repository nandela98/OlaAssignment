//
//  AppDelegate.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import UIKit
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var internetPopupOpen: Bool? =  false
    private weak var rechabilityObserver: ReachabilityHandler?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        onApplicationLaunch()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

fileprivate extension AppDelegate {
    
    func onApplicationLaunch() {
        addInternetCheckObserver()
    }
    
    /**
       setup notification to show internet not avialble popup
    */
    func addInternetCheckObserver() {
        let rechabilityHandler = ReachabilityHandler()
        rechabilityObserver = rechabilityHandler
        NotificationCenter.default.addObserver(self, selector: #selector(showInternetAlert), name: OlaConstants.NotificationConstants.ShowInternetPopup, object: nil)
    }
    
    /**
       Show intetnet not available popup if internet connection not available
     */
    @objc private func showInternetAlert()
    {
        DispatchQueue.main.async {
            if let topController = UIApplication.shared.topMostViewController() {
                topController.hideLoader()
            }
            if self.internetPopupOpen == false {
                self.internetPopupOpen = true
                showAlert(title: "internet_connection_issue".localized(), message: "internet_connection_subtitle".localized()) { (sucess) in
                    self.internetPopupOpen  = false
                }
            }
        }
    }
    
}


