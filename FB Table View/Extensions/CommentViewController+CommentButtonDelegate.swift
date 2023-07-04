//
//  CommentViewController+CommentButtonDelegate.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/7/3.
//

import UIKit

extension CommentViewController: CommentButtonDelegate {
    
    func commentButtonTapped() {
        commentTextField.becomeFirstResponder()
    }
}
