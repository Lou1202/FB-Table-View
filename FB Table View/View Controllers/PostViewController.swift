//
//  PostViewController.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/6/15.
//

import UIKit
import PhotosUI

class PostViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var stateButton: UIButton!
    @IBOutlet weak var addPhotoButton: UIButton!
    var postButton: UIButton!
    var isPostPublic = true // 貼文公開狀態
    var selectedImage: UIImage?  // 前一頁選擇的照片
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = false
        tabBarController?.tabBar.isHidden = true
        postTextView.delegate = self // 代理TextView
        updateUI()
        setNavigationbar()
        // 使用選取的照片 更新畫面
        if let image = selectedImage {
            postImageView.image = image
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 有選擇圖片 發布按鈕樣式變成藍色
        if selectedImage != nil {
            postButton.backgroundColor = UIColor(red: 23/255, green: 119/255, blue: 241/255, alpha: 1)
        }
    }

    
    func updateUI() {
        
        userNameLabel.text = "Lou"
        userImageView.image = UIImage(named: "userphoto")
        stateButton.layer.borderWidth = 1
        stateButton.layer.borderColor = CGColor(red: 100/255, green: 103/255, blue: 106/255, alpha: 1)
        stateButton.layer.cornerRadius = 10
        stateButton.setImage(UIImage(systemName: "globe.asia.australia.fill"), for: .normal)
        stateButton.tintColor = UIColor(red: 100/255, green: 103/255, blue: 106/255, alpha: 1)
        stateButton.contentHorizontalAlignment = .left
        addPhotoButton.layer.borderWidth = 1
        addPhotoButton.layer.borderColor = CGColor(red: 100/255, green: 103/255, blue: 106/255, alpha: 1)
        addPhotoButton.layer.cornerRadius = 10
        
        // 調整間距 (檢查版本兩種寫法 消除舊版黃色警告)
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
            stateButton.configuration = config
        } else {
            // 使用舊版的方式
            stateButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }
        
    }
    
    
    func setNavigationbar() {
        // 設定左邊關閉按鈕
        let closeButton = UIButton(type: .system)
        closeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let closeSymbolConfig = UIImage.SymbolConfiguration(weight: .heavy)
        let closeImage = UIImage(systemName: "xmark", withConfiguration: closeSymbolConfig)
        closeButton.setImage(closeImage, for: .normal)
        closeButton.tintColor = UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        let closeButtonItem = UIBarButtonItem(customView: closeButton)
        navigationItem.leftBarButtonItem = closeButtonItem
        
        // 設定右邊發文按鈕
        postButton = UIButton(type: .system)
        postButton.setTitle("發布", for: .normal)
        postButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        postButton.backgroundColor = UIColor(red: 228/255, green: 229/255, blue: 234/255, alpha: 1)
        postButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        postButton.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        postButton.layer.cornerRadius = 4
        postButton.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        let postButtonItem = UIBarButtonItem(customView: postButton)
        navigationItem.rightBarButtonItem = postButtonItem
        
        // 設定標題
        navigationItem.title = "建立貼文"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1),
            .font: UIFont.systemFont(ofSize: 18)
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 247/255, green: 248/255, blue: 249/255, alpha: 1)
        
    }
    
    @objc func postButtonTapped() {
        
        // 沒有文字或圖片 無法發布
        guard !(postTextView.text.isEmpty || postTextView.text == "在想些什麼？") || postImageView.image != nil else {
            return
        }
        
        // 儲存圖片至app資料夾 並獲取圖片路徑
        if let postImage = postImageView.image,
           let imageData = postImage.pngData(),
           let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
           
            let fileName = UUID().uuidString
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            
            do {
                try imageData.write(to: fileURL)
            } catch {
                print("Error saving image: \(error)")
            }
            
            // 沒有輸入文字 只儲存圖片
            let text = postTextView.text.isEmpty || postTextView.text == "在想些什麼？" ? "" : postTextView.text
            let postInfo = PostInfo(userName: "Lou", profilePictureName: "userphoto", timestamp: Date(), isPublic: isPostPublic, text: text, imageName: fileName)
            postArray.append(postInfo)
        } else {
            // 無圖片 只儲存文字
            let text = postTextView.text.isEmpty || postTextView.text == "在想些什麼？" ? "" : postTextView.text
            
            let postInfo = PostInfo(userName: "Lou", profilePictureName: "userphoto", timestamp: Date(), isPublic: isPostPublic, text: text, imageName: nil)
            postArray.append(postInfo)
        }
        
        self.navigationController?.popViewController(animated: true) //發布即跳出視窗
    }
    
    @objc func closeButtonTapped() {
        // 返回上一頁
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectPublic() {
        stateButton.setImage(UIImage(systemName: "globe.asia.australia.fill"), for: .normal)
        isPostPublic = true
    }
    
    @objc func selectPrivate() {
        stateButton.setImage(UIImage(systemName: "person.2.fill"), for: .normal)
        isPostPublic = false
    }
    
    @IBAction func selectphoto(_ sender: Any) {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
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
