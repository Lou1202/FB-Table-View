//
//  MyStoryCollectionViewCell.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/6/1.
//

import UIKit

class MyStoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var plusButton: UIButton!
    
    
    func updateUI() {

        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = CGColor(red: 222/255, green: 223/255, blue: 225/255, alpha: 1)
        plusButton.layer.cornerRadius = 15
        plusButton.layer.borderWidth = 2
        plusButton.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
    
}
