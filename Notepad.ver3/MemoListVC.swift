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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.lblRegdate?.text = formatter.string(from: row.regdate!)

        return cell
    }
}
