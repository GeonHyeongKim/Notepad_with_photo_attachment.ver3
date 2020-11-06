//
//  MemoReadVC.swift
//  Notepad.ver3
//
//  Created by gunhyeong on 2020/11/06.
//  Copyright © 2020 geonhyeong. All rights reserved.
//

import UIKit

class MemoReadVC: UIViewController {

    var param: MemoData?
    @IBOutlet var lblSubject: UILabel!
    @IBOutlet var lblContents: UILabel!
    @IBOutlet var ivImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblSubject.text = param?.title
        self.lblContents.text = param?.contents
        self.ivImg.image = param?.image
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formatter.string(from: (param?.regdate)!)
        
        self.navigationItem.title = dateString
    }

}
