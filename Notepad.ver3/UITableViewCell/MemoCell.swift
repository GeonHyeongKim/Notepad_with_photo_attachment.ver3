//
//  MemoCell.swift
//  Notepad.ver3
//
//  Created by gunhyeong on 2020/11/06.
//  Copyright © 2020 geonhyeong. All rights reserved.
//

import UIKit

class MemoCell: UITableViewCell {

    @IBOutlet var lblSubject: UILabel! // 메모 제목
    @IBOutlet var lblContents: UILabel! // 메모 내용
    @IBOutlet var lblRegdate: UILabel! // 등록 일자
    @IBOutlet var ivThum: UIImageView! // 이미지
}
