//
//  NSAttributedString.swift
//  Notepad.ver3
//
//  Created by gunhyeong on 2020/11/08.
//  Copyright © 2020 geonhyeong. All rights reserved.
//

import UIKit

extension NSAttributedString {
    func toNSData() -> NSData? {
        let options : [NSAttributedString.DocumentAttributeKey: Any] = [
            .documentType: NSAttributedString.DocumentType.rtfd,
            .characterEncoding: String.Encoding.utf8
        ]

        let range = NSRange(location: 0, length: length)
        guard let data = try? data(from: range, documentAttributes: options) else {
            return nil
        }

        return NSData(data: data)
    }
}
