//
//  MemoFomeVC.swift
//  Notepad.ver3
//
//  Created by gunhyeong on 2020/11/06.
//  Copyright © 2020 geonhyeong. All rights reserved.
//

import UIKit

class MemoFomeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    var subject: String!
    @IBOutlet var tvContents: UITextView!
    @IBOutlet var ivPreview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvContents.delegate = self
    }
    
    // 자장 버튼을 클릭했을 때, 호출되는 메소드
    @IBAction func save(_ sender: Any) {
        // 내용을 입력하지 않았을 경우, 경고창
        guard self.tvContents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: false, completion: nil)
            return
        }

        
        // MemoData 객체를 생성하고, 데이터를 담음
        let data = MemoData()
        data.title = self.subject // 제목
        data.contents = self.tvContents.text // 내용
        data.image = self.ivPreview.image // 이미지
        data.regdate = Date() // 작성 시각
        
        // App Delegate 객체를 읽어온 다음, memoList 배열에 MemoData 객체를 추가
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memoList.append(data)
        
        // 작성폼 화면을 종료하고, 이전화면으로 되돌아감
        navigationController?.popViewController(animated: true)
    }
    
    // 카메라 버튼을 클릭했을 때, 호출되는 메소드
    @IBAction func pick(_ sender: Any) {
        // 이미지 피커 인스턴스를 생성
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        // 이미지 피커 화면을 표시
        self.present(picker, animated: false, completion: nil)
    }

    // 이미지 피커에서 이미지를 선택했을때, 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 선택된 이미지를 미리보기에 표시
        if let editedImage = info[.editedImage] as? UIImage {
            self.ivPreview.image = editedImage
        }
        
        // 이미지 피커 컨트롤러 닫기
        dismiss(animated: false, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // 내용의 최대 15자리까지 읽어 subject 변수에 저장
        let contents = textView.text as NSString
        let length = contents.length > 15 ? 15 : contents.length
        self.subject = contents.substring(with: _NSRange(location: 0, length: length))
        
        self.navigationItem.title = subject
    }
}

//MARK: - 새 메모가 발생시 List update
extension MemoFomeVC {
    static let newMemoDidInsert = Notification.Name(rawValue: "newMomoDidInsert")
    static let memoDidChange = Notification.Name(rawValue: "memoDidChange")
}
