//
//  MemoListVC.swift
//  Notepad.ver3
//
//  Created by gunhyeong on 2020/11/06.
//  Copyright © 2020 geonhyeong. All rights reserved.
//

import UIKit

class MemoListVC: UITableViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let formatter: DateFormatter = {
        let format = DateFormatter()
        format.dateStyle = .long
        format.timeStyle = .short
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        format.locale = Locale(identifier: "Ko_kr") // 한글표시
        return format
    }()
    
    var token: NSObjectProtocol? // 메모리 낭비를 줄임
    
    deinit { // 소멸자에서 해제
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Observers
        token = NotificationCenter.default.addObserver(forName: MemoFomeVC.newMemoDidInsert, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
            self?.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.appDelegate.memoList.count
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // memolist 배열 데이터에서 주어진 행에 맞는 데이터를 꺼냄
        let row = self.appDelegate.memoList[indexPath.row]
        
        // 이미지 속성이 비어 있을 경우 "memoCell", 아니면 "memoCellWithImage"
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        
        // 재사용 큐로부터 프로토타입 셀의 인스턴스를 전달받음
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoCell
        
        // memoCell의 내용을 구성
        cell.lblSubject?.text = row.title
        cell.lblContents?.text = row.contents
        cell.ivThum?.image = row.image
        
        // Date 타입의 날짜를 yyyy-MM-dd HH:mm:ss 포멧으로 변경
        cell.lblRegdate?.text = formatter.string(for: row.regdate!)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 배열에서 선택된 행에 맞는 데이터를 꺼내옴
        let row = self.appDelegate.memoList[indexPath.row]
        
        // 상세 화면의 인스턴스를 생성
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else {
            return
        }
        
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
