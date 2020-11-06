//
//  MemoFomeVC.swift
//  Notepad.ver3
//
//  Created by gunhyeong on 2020/11/06.
//  Copyright © 2020 geonhyeong. All rights reserved.
//

import UIKit

class MemoFomeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var tvMemo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 자장 버튼을 클릭했을 때, 호출되는 메소드
    @IBAction func save(_ sender: Any) {
        
    }
    
    // 카메라 버튼을 클릭했을 때, 호출되는 메소드
    @IBAction func pick(_ sender: Any) {
        
    }

    // 이미지 피커에서 이미지를 선택했을때, 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        <#code#>
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
