//
//  MemoFomeVC.swift
//  Notepad.ver3
//
//  Created by gunhyeong on 2020/11/06.
//  Copyright © 2020 geonhyeong. All rights reserved.
//

import UIKit
import Photos

class MemoFomeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var subject: String!
    var editTarget: Memo?
    var originalMemoContent: String?
    
    @IBOutlet var tvContents: UITextView!
    @IBOutlet var ivPreview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let memo = editTarget { // 편집
            navigationItem.title = "메모 편집"
            tvContents.text = memo.content
            originalMemoContent = memo.content
            
            if let data = memo.insertImg {
                ivPreview.image = UIImage(data: data)
            }
        } else { // 새 메모
            navigationItem.title = "새 메모"
            tvContents.text = ""
        }
        
        self.tvContents.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tvContents.becomeFirstResponder()
        navigationController?.presentationController?.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        tvContents.resignFirstResponder()
        navigationController?.presentationController?.delegate = nil
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // 자장 버튼을 클릭했을 때, 호출되는 메소드
    @IBAction func save(_ sender: Any) {
        // 내용을 입력하지 않았을 경우, 경고창
        guard self.tvContents.text?.isEmpty == false else {
            alert(message: "메모를 입력해주세요")
            return
        }
        
        // 메모가 입력되었을 경우
        if let memo = editTarget { // 편집
            memo.title = subject
            memo.content = self.tvContents.text // 내용
            memo.insertDate = Date()
            memo.insertImg = ivPreview.image?.pngData()
            DataManager.shared.saveContext()

            NotificationCenter.default.post(name: MemoFomeVC.memoDidChange, object: nil)
        } else { // 새 메모
            // MemoData 객체를 생성하고, 데이터를 담음
            DataManager.shared.addNewMemo(subject, tvContents.text, ivPreview.image?.pngData())
            NotificationCenter.default.post(name: MemoFomeVC.newMemoDidInsert, object: nil)
        }
        
        // 작성폼 화면을 종료하고, 이전화면으로 되돌아감
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Camera
    @IBAction func insertImage() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // 옵션 초기화
        let libraryAction = UIAlertAction(title: "앨범", style: .default) { [weak self] (alert) in
            self!.checkPhotoLibraryAuthorizationStatus()
        }
        
        let cameraAction = UIAlertAction(title: "새로운 촬영", style: .default, handler: {
            [weak self] (alert: UIAlertAction!) -> Void in
            self!.checkCameraAuthorizationStatus()
        })
        let linkAction = UIAlertAction(title: "외부 링크 이미지", style: .default, handler: {
            [weak self] (alert: UIAlertAction!) -> Void in
            
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(libraryAction)
        alert.addAction(cameraAction)
        //        alert.addAction(linkAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
        
    // photo library 권한 확인
    private func checkPhotoLibraryAuthorizationStatus(){
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                DispatchQueue.main.async { () -> Void in self.openLibraryAndCamera(.photoLibrary) }
            case .denied, .restricted:
                self.settingAlert(title: "사진 보관함에 접근 불가", message: "사진 보관함에 접근할 수 있도록, 앱 개인 정보 설정으로 이동하여 접근 허용해 주세요.")
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization() { status in
                    guard status == .authorized else { return }
                    self.openLibraryAndCamera(.photoLibrary)
                }
            case .limited:
                print("Photo Library Authorization Status에서 Limited")
            @unknown default:
                print("Photo Library Authorization Status에서 에러발생")
            }
        }
    }
    
    // camera 권한 확인
    private func checkCameraAuthorizationStatus(){
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch authorizationStatus {
        case .authorized:
            DispatchQueue.main.async { () -> Void in self.openLibraryAndCamera(.camera) }
        case .denied, .restricted:
            self.settingAlert(title: "카메라에 접근 불가", message: "카메라에 접근할 수 있도록, 앱 개인 정보 설정으로 이동하여 접근 허용해 주세요.")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] (granted) in
                if granted { DispatchQueue.main.async { self!.openLibraryAndCamera(.camera) } }
            }
        @unknown default:
            print("Camera Authorization Status에서 에러발생")
        }
    }
    
    // 엘범 열기 & 새로운 촬영
    func openLibraryAndCamera(_ sender: UIImagePickerController.SourceType){
        let imgaePicker = UIImagePickerController()
        imgaePicker.sourceType = sender
        imgaePicker.allowsEditing = true
        imgaePicker.delegate = self
        present(imgaePicker, animated: true)
    }
    
    // 권한 설정 알림 - photo library, camera
    private func settingAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let settingAction = UIAlertAction(title: "승인", style: .default){ (action) in // 다시 설정에서 허용할 수 있도록
                if let settingsUrl = NSURL(string:UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl as URL, options: [:], completionHandler: nil)
                }
            }
            let cancleAction = UIAlertAction(title: "허용 안함", style: .destructive, handler: nil)
            alert.addAction(cancleAction)
            alert.addAction(settingAction)
            self.present(alert, animated:true, completion:nil)
        }
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
    
}

//MARK: - UITextViewDelegate
extension MemoFomeVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let origin = originalMemoContent, let edited = textView.text {
            if #available(iOS 13.0, *) {
                isModalInPresentation = origin != edited
            } else {
                // Fallback on earlier versions
            }
        }
        
        // 내용의 최대 15자리까지 읽어 subject 변수에 저장
        let contents = textView.text as NSString
        let length = contents.length > 15 ? 15 : contents.length
        self.subject = contents.substring(with: _NSRange(location: 0, length: length))
        
        self.navigationItem.title = subject
    }
}
//MARK: - UIAdaptivePresentationControllerDelegate
extension MemoFomeVC: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        let alert = UIAlertController(title: "알림", message: "편집한 내용을 저장할까요?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { [weak self] (action) in
            self?.save(action)
        }
        
        alert.addAction(okAction)
        
        let cancleAction = UIAlertAction(title: "취소", style: .cancel) { [weak self] (action) in
            self?.close(action)
        }
        
        alert.addAction(cancleAction)
        
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - 새 메모가 발생시 List update
extension MemoFomeVC {
    static let newMemoDidInsert = Notification.Name(rawValue: "newMomoDidInsert")
    static let memoDidChange = Notification.Name(rawValue: "memoDidChange")
}
