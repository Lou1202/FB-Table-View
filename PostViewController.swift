//
//  PostViewController.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/6/9.
//

import UIKit

class PostViewController: UIViewController {
    
    let selectSection: Int
    @IBOutlet weak var postContainerViewBottomConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var postContainerView: UIView!
    
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
        // Do any additional setup after loading the view.
        
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
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    


}
