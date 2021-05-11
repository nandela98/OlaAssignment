//
//  OlaImageLoader.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    /**
       download image from server initially and cache it - next time images retrieve from cache
    */
    func setImage(from url: URL, withPlaceholder placeholder: UIImage? = .none, withCache cache:NSCache<NSURL,UIImage>? = .none) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let cached = cache?.object(forKey: url as NSURL) {
                DispatchQueue.main.async { self.image = cached }
                return
            }
            DispatchQueue.main.async { self.image = placeholder }
            URLSession.shared.dataTask(with: url)  { (data, _, _) in
                if let data = data, let image = UIImage(data: data) {
                    cache?.setObject(image, forKey: url as NSURL)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }.resume()
        }
    }
    
}
