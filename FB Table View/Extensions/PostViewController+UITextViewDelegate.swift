//
//  PostViewController+UITextViewDelegate.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/6/26.
//

import UIKit

extension PostViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        //  發布按鈕樣式 隨著內文變更
        if textView.text.isEmpty {
            postButton.backgroundColor = UIColor(red: 228/255, green: 229/255, blue: 234/255, alpha: 1)
        } else {
            postButton.backgroundColor = UIColor(red: 23/255, green: 119/255, blue: 241/255, alpha: 1)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // 開始打字時 文字欄變空白
        textView.text = ""
        textView.textColor = UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1)
    }
}
