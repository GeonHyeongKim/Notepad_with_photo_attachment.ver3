//
//  NSTextAttachment.swift
//  Notepad.ver3
//
//  Created by gunhyeong on 2020/11/08.
//  Copyright © 2020 geonhyeong. All rights reserved.
//

import UIKit

extension NSTextAttachment {
    func textAttachment(_ image: UIImage) -> NSTextAttachment{
        let textAttachment = NSTextAttachment()
        textAttachment.image = image
        
        //resize this
        textAttachment.bounds = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height)
        return textAttachment
    }
}
