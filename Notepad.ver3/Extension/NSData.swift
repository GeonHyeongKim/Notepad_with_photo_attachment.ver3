//
//  NSData.swift
//  Notepad.ver3
//
//  Created by gunhyeong on 2020/11/08.
//  Copyright © 2020 geonhyeong. All rights reserved.
//

import UIKit

extension NSData {
    func toAttributedString() -> NSAttributedString? {
        let data = Data(referencing: self)
        let options : [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.rtfd,
            .characterEncoding: String.Encoding.utf8
        ]
        
        return try? NSAttributedString(data: data,
                                       options: options,
                                       documentAttributes: nil)
    }
}
