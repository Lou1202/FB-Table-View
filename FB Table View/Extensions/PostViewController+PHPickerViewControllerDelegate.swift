//
//  PostViewController+PHPickerViewControllerDelegate.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/7/3.
//

import PhotosUI

extension PostViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self?.postImageView.image = image
                        // 變更發布按鈕樣式
                        self?.postButton.backgroundColor = UIColor(red: 23/255, green: 119/255, blue: 241/255, alpha: 1)
                    }
                }
            }
        }
    }
}

