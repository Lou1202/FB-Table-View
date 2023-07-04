//
//  PostViewController.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/6/9.
//

import UIKit

// 建立更新表格的協議
protocol PostViewControllerDelegate: AnyObject {
    func updateTable()
}

class CommentViewController: UIViewController {
    
    var selectSection: Int
    var shouldOpenKeyboard: Bool
    weak var delegate: PostViewControllerDelegate? // 代理人
    @IBOutlet weak var postContainerViewBottomConstraint: NSLayoutConstraint!
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
        // 設定左邊關閉按鈕
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
        
        let container = UIView()
        
        let nameLabel = UILabel()
        nameLabel.text = postArray[selectSection].userName
        nameLabel.font = UIFont.systemFont(ofSize: 17)
        nameLabel.textColor = UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(nameLabel)
        
        let timeLabel = UILabel()
        timeLabel.text = timeAgoDisplay(date: postArray[selectSection].timestamp)
        timeLabel.font = UIFont.systemFont(ofSize: 17)
        timeLabel.textColor = UIColor(red: 101/255, green: 103/255, blue: 106/255, alpha: 1)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(timeLabel)
        
        let separatorLabel = UILabel()
        separatorLabel.text = "．"
        separatorLabel.font = UIFont(name: "蘋方-繁", size: 17)
        separatorLabel.textColor = UIColor(red: 101/255, green: 103/255, blue: 106/255, alpha: 1)
        separatorLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(separatorLabel)
        
        let stateButton = UIButton()
        if postArray[selectSection].isPublic {
            stateButton.setImage(UIImage(systemName: "globe.asia.australia.fill"), for: .normal)
        } else {
            stateButton.setImage(UIImage(systemName: "person.2.fill"), for: .normal)
        }
        stateButton.tintColor = UIColor(red: 101/255, green: 103/255, blue: 106/255, alpha: 1)
        stateButton.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(stateButton)
        
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
            
            // Constraints for nameLabel and timeLabel relative to container
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification) {
        guard let info = notification.userInfo,
              let keyboardFrameValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let tabHeight = tabBarController?.tabBar.frame.size.height else { return }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        self.commentView.transform = CGAffineTransform(translationX: 0, y: -(keyboardSize.height - tabHeight))
        // Update commentView's bottom constraint
        postContainerViewBottomConstraint.constant = -(commentView.frame.height)
        
        // Animate changes
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        // Reset commentView's bottom constraint
        postContainerViewBottomConstraint.constant = 0
        
        // Animate changes
        //        UIView.animate(withDuration: 0.3) {
        //            self.view.layoutIfNeeded()
        //        }
        
        commentView.transform = CGAffineTransform(translationX: 0, y: 0)
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedCommentTableViewControllerSegue",
           let postTableVC = segue.destination as? CommentTableViewController {
            postTableVC.selectSection = selectSection
            postTableVC.delegate = self
            // CommentTableViewController設定為代理人
            self.delegate = postTableVC
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    
    
    @IBAction func commentChangeButtonColor(_ sender: Any) {
        
        if let text = commentTextField.text, !text.isEmpty {
            sendButton.tintColor = UIColor(red: 23/255, green: 119/255, blue: 241/255, alpha: 1)
        } else {
            sendButton.tintColor = UIColor(red: 100/255, green: 103/255, blue: 106/255, alpha: 1)
        }
        
    }
    
    
    
    @IBAction func comment(_ sender: Any) {
        
        if let text = commentTextField.text, !text.isEmpty {
            let postComment = PostComment(userName: "Lou", profilePictureName: "userphoto", content: text, timestamp: Date())
            postArray[selectSection].postComments.append(postComment)
            delegate?.updateTable()
            commentTextField.text = ""
        }
        
    }
    
    @IBAction func closeKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    
}


