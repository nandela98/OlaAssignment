//
//  ReachabilityHandler.swift
//  Assignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import Foundation
import Reachability

final class ReachabilityHandler {
    
    private var reachability : Reachability?
    private let hostname = "www.google.com"

    // MARK: - LifeCycle
    
    init() {
        configure()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        reachability?.stopNotifier()
    }
    
    // MARK: - Private
    
    private func configure() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ReachabilityHandler.checkForReachability(notification:)),
                                               name: Notification.Name.reachabilityChanged,
                                               object: nil)
        do {
            reachability = try Reachability.init(hostname: hostname)
            try? reachability?.startNotifier()
        } catch let error {
            debugPrint("Could not initiate reachability with hostname : \(error)")
        }
    }
    
    @objc private func checkForReachability(notification: NSNotification) {
        if let networkReachability = notification.object as? Reachability {
            let remoteHostStatus = networkReachability.connection
            switch remoteHostStatus {
            case .none:
                NotificationCenter.default.post(name: OlaConstants.NotificationConstants.ShowInternetPopup, object: nil)
                break
            case .wifi,
                 .cellular: break
            case .unavailable:
                NotificationCenter.default.post(name: OlaConstants.NotificationConstants.ShowInternetPopup, object: nil)
            @unknown default:
                NotificationCenter.default.post(name: OlaConstants.NotificationConstants.ShowInternetPopup, object: nil)
            }
        }
    }
}


