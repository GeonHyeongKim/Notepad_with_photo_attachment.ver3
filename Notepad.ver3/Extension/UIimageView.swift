//
//  UIimageView.swift
//  Notepad.ver3
//
//  Created by gunhyeong on 2020/11/23.
//  Copyright © 2020 geonhyeong. All rights reserved.
//


import UIKit

extension UIImageView {
    public func imageFromURL(urlString: String, placeholder: UIImage?, completion: @escaping () -> ()) {
        if self.image == nil {
            self.image = placeholder
        }
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error! as NSError)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
                self.setNeedsLayout()
                completion()
            })
        }).resume()
    }
}
