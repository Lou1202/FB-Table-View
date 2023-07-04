//
//  HomePageTableViewController+PHPickerViewControllerDelegate.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/6/5.
//

import UIKit
import PhotosUI

extension HomePageTableViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard !results.isEmpty else {
            // 用户没有选择照片
            return
        }

        let itemProvider = results.first!.itemProvider

        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                if let error = error {
                    print("Error loading image: \(error)")
                    return
                }

                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        // 使用 Segue 跳转至 PostViewController，并传递图片
                        self.performSegue(withIdentifier: "selcetPhoto", sender: image)
                    }
                }
            }
        }
    }

    
}
