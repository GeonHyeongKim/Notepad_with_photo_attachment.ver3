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
    
    var token: NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        token = NotificationCenter.default.addObserver(forName: MemoFomeVC.memoDidChange, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
//            self?.
//        })
        
        self.lblSubject.text = param?.title
        self.lblContents.text = param?.contents
        self.ivImg.image = param?.image
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formatter.string(from: (param?.regdate)!)
        
        self.navigationItem.title = dateString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? MemoFomeVC {
            vc.editTarget = param
        }
    }

}
