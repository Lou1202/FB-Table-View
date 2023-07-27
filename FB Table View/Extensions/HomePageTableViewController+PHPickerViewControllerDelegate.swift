//
//  HomePageTableViewController+PHPickerViewControllerDelegate.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/6/5.
//

import PhotosUI

extension HomePageTableViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard !results.isEmpty else {
            // 使用者沒有選擇照片
            return
        }

        let itemProvider = results.first?.itemProvider

        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error loading image: \(error)")
                        return
                    }

                    if let image = object as? UIImage {
                        // 使用 Segue 跳轉 PostViewController傳遞圖片
                        self?.performSegue(withIdentifier: "selcetPhoto", sender: image)
                    }
                }
            }
        }

    }
}
