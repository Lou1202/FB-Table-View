//
//  PostViewController.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/6/9.
//

import UIKit

// 建立更新表格的協議
protocol CommentViewControllerDelegate: AnyObject {
    func updateTable()
}

class CommentViewController: UIViewController {
    
    var selectSection: Int
    var shouldOpenKeyboard: Bool
    weak var delegate: CommentViewControllerDelegate? // 代理人
    @IBOutlet weak var postContainerViewBottomConstraint: NSLayoutConstraint! // ContainerView與留言欄auto layout條件
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var postContainerView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    
    init?(coder: NSCoder, selectSection: Int, shouldOpenKeyboard: Bool ) {
        self.selectSection = selectSection
        self.shouldOpenKeyboard = shouldOpenKeyboard
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.hidesBarsOnSwipe = false
        self.tabBarController?.tabBar.isHidden = false
        registerForKeyboardNotifications()
        updateUI()
        setNavigationbar()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if shouldOpenKeyboard {
            commentTextField.becomeFirstResponder()
        }
    }
    
    func updateUI() {
        sendButton.transform = CGAffineTransform(rotationAngle: .pi/2)
        sendButton.tintColor = UIColor(red: 100/255, green: 103/255, blue: 106/255, alpha: 1)
    }
    
    func setNavigationbar() {
        // 設定左邊返回按鈕
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let backSymbolConfig = UIImage.SymbolConfiguration(weight: .heavy)
        let backImage = UIImage(systemName: "chevron.backward", withConfiguration: backSymbolConfig)
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let backButtonItem = UIBarButtonItem(customView: backButton)
        
        
        // 設定左邊ImageView
        let profilePictureImageView = UIImageView()
        profilePictureImageView.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        profilePictureImageView.image = UIImage(named: postArray[selectSection].profilePictureName)
        profilePictureImageView.contentMode = .scaleAspectFill
        profilePictureImageView.layer.cornerRadius = 22
        profilePictureImageView.clipsToBounds = true
        let profilePictureItem = UIBarButtonItem(customView: profilePictureImageView)
        
        // 貼文者資料view
        let container = UIView()
        // 發文者名稱
        let nameLabel = UILabel()
        nameLabel.text = postArray[selectSection].userName
        nameLabel.font = UIFont.systemFont(ofSize: 17)
        nameLabel.textColor = UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(nameLabel)
        // 發文時間
        let timeLabel = UILabel()
        timeLabel.text = timeAgoDisplay(date: postArray[selectSection].timestamp)
        timeLabel.font = UIFont.systemFont(ofSize: 17)
        timeLabel.textColor = UIColor(red: 101/255, green: 103/255, blue: 106/255, alpha: 1)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(timeLabel)
        // 分隔符號
        let separatorLabel = UILabel()
        separatorLabel.text = "．"
        separatorLabel.font = UIFont(name: "蘋方-繁", size: 17)
        separatorLabel.textColor = UIColor(red: 101/255, green: 103/255, blue: 106/255, alpha: 1)
        separatorLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(separatorLabel)
        // 貼文狀態
        let stateButton = UIButton()
        if postArray[selectSection].isPublic {
            stateButton.setImage(UIImage(systemName: "globe.asia.australia.fill"), for: .normal)
        } else {
            stateButton.setImage(UIImage(systemName: "person.2.fill"), for: .normal)
        }
        stateButton.tintColor = UIColor(red: 101/255, green: 103/255, blue: 106/255, alpha: 1)
        stateButton.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(stateButton)
        
        // 設定auto layout條件
        NSLayoutConstraint.activate([
            profilePictureImageView.widthAnchor.constraint(equalToConstant: 44),
            profilePictureImageView.heightAnchor.constraint(equalToConstant: 44),
            nameLabel.heightAnchor.constraint(equalToConstant: 22),
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 22),
            separatorLabel.widthAnchor.constraint(equalToConstant: 17),
            separatorLabel.heightAnchor.constraint(equalToConstant: 22),
            stateButton.widthAnchor.constraint(equalToConstant: 22),
            stateButton.heightAnchor.constraint(equalToConstant: 22),
            
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: container.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            separatorLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            separatorLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            stateButton.leadingAnchor.constraint(equalTo: separatorLabel.trailingAnchor),
            stateButton.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        
        let userItem = UIBarButtonItem(customView: container)
        
        navigationItem.leftBarButtonItems = [backButtonItem, profilePictureItem, userItem]
    }
    
    @objc func backButtonTapped () {
        navigationController?.popViewController(animated: true)
    }
    
    
    func registerForKeyboardNotifications() {
        // 鍵盤出現
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        // 鍵盤隱藏
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification) {
        guard let info = notification.userInfo,
              let keyboardFrameValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let tabHeight = tabBarController?.tabBar.frame.size.height else { return }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        self.commentView.transform = CGAffineTransform(translationX: 0, y: -(keyboardSize.height - tabHeight))
        // 變動ContainerView與留言欄auto layout條件
        postContainerViewBottomConstraint.constant = -(commentView.frame.height)
        
        // 留言欄移動的動畫設定
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        // 重置ContainerView與留言欄auto layout條件
        postContainerViewBottomConstraint.constant = 0
        commentView.transform = CGAffineTransform(translationX: 0, y: 0)
    }
    
    
    

    
    
    
    
    @IBAction func commentChangeButtonColor(_ sender: Any) {
        
        if let text = commentTextField.text, !text.isEmpty {
            // 輸入文字發送按鈕變藍色
            sendButton.tintColor = UIColor(red: 23/255, green: 119/255, blue: 241/255, alpha: 1)
        } else {
            sendButton.tintColor = UIColor(red: 100/255, green: 103/255, blue: 106/255, alpha: 1)
        }
        
    }
    
    
    
    @IBAction func comment(_ sender: Any) {
        if let text = commentTextField.text, !text.isEmpty {
            let postComment = PostComment(userName: "Lou", profilePictureName: "userphoto", content: text, timestamp: Date()) // 留言功能
            postArray[selectSection].postComments.append(postComment)
            delegate?.updateTable() // 代理CommentTableViewController更新表格
            commentTextField.text = "" // 留言發送後 清除文字
            view.endEditing(true) // 留言發送後 收鍵盤
            sendButton.tintColor = UIColor(red: 100/255, green: 103/255, blue: 106/255, alpha: 1) // 發送鈕顏色變回預設
        }
    }
    
    // 點選其他地方 收鍵盤
    @IBAction func closeKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedCommentTableViewControllerSegue",
           let commentTableVC = segue.destination as? CommentTableViewController {
            commentTableVC.selectSection = selectSection
            // CommentTableViewController設定為代理人
            commentTableVC.delegate = self
            // CommentViewController設定為CommentTableViewController代理人
            self.delegate = commentTableVC
        }
    }
    
}



