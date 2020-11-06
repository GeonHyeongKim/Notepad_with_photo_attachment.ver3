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
    @IBOutlet var ivPreView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvContents.delegate = self
    }
    
    // 자장 버튼을 클릭했을 때, 호출되는 메소드
    @IBAction func save(_ sender: Any) {
        
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
            self.ivPreView.image = editedImage
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
