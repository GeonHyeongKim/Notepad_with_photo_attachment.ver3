//
//  MemoReadVC.swift
//  Notepad.ver3
//
//  Created by gunhyeong on 2020/11/06.
//  Copyright © 2020 geonhyeong. All rights reserved.
//

import UIKit

class MemoReadVC: UIViewController {

    var memo: Memo?
    @IBOutlet var tvMemo: UITableView!
    
    var token: NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvMemo.rowHeight = UITableView.automaticDimension
        
        token = NotificationCenter.default.addObserver(forName: MemoFomeVC.memoDidChange, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
            
            self?.tvMemo.reloadData()
        })
                
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formatter.string(from: (memo?.insertDate)!)
        
        self.navigationItem.title = dateString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? MemoFomeVC {
            vc.editTarget = memo
        }
    }

    @IBAction func deleteMemo(_ sender: Any) {
        let alert = UIAlertController(title: "알림", message: "삭제 확인", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] (action) in
            DataManager.shared.deleteMemo(self?.memo)
            self?.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(okAction)
        
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancleAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func share(_ sender: UIBarButtonItem) {
        guard let memo = memo?.content else { return }
        
        let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
        
        if let pc = popoverPresentationController {
            pc.barButtonItem = sender
        }
        
        present(vc, animated: true, completion: nil)
    }
}

//MARK: - TableVeiw DataSource
extension MemoReadVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "readTtitleTableViewCell", for: indexPath)
            cell.textLabel?.text = memo?.title
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "readContentsTableViewCell", for: indexPath)
            cell.textLabel?.text = memo?.content
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "readImgTableViewCell", for: indexPath)
            guard let data = memo?.insertImg else {
                return cell
            }
            cell.imageView?.image = UIImage(data: data)
            return cell
        default:
            fatalError()
        }
    }
}

//MARK: - UITableView Delegate
extension MemoReadVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.row > 1 else {
            return tableView.estimatedRowHeight
        }
        
        return 200
    }
}

