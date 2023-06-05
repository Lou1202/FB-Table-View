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
    }
}
