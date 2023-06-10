//
//  PostViewController.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/6/9.
//

import UIKit

class PostViewController: UIViewController {
    
    let selectSection: Int
    weak var delegate: PostViewControllerDelegate?
    @IBOutlet weak var postContainerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var postContainerView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    
    
    init?(coder: NSCoder, selectSection: Int) {
        self.selectSection = selectSection
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
        
        // Do any additional setup after loading the view.
        
    }
    
    func updateUI() {
        sendButton.transform = CGAffineTransform(rotationAngle: .pi/2)
        sendButton.tintColor = UIColor(red: 100/255, green: 103/255, blue: 106/255, alpha: 1)
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
        if segue.identifier == "embedPostTableViewControllerSegue",
           let postTableVC = segue.destination as? PostTableViewController {
            postTableVC.selectSection = selectSection
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
            let postComment = PostComment(userName: "Lou", profilePictureName: "userphoto", content: text, timestamp: "5分鐘")
            postArray[selectSection].comments.append(postComment)
            delegate?.updateTable()
            commentTextField.text = ""
        }
        
    }
    
    
    
}

protocol PostViewControllerDelegate: AnyObject {
    func updateTable()
}
