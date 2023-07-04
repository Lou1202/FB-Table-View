//
//  StoryCollectionViewCell.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/5/31.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var storyProfilePictureImageView: UIImageView!
    @IBOutlet weak var storyPictureImageView: UIImageView!
    @IBOutlet weak var storyNameLabel: UILabel!
    
    @IBOutlet weak var storyBorderIamgeView: UIImageView!
    
    func updateUI(with postInfo: PostInfo) {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = CGColor(red: 222/255, green: 223/255, blue: 225/255, alpha: 1)
        storyProfilePictureImageView.layer.cornerRadius = 18
        storyBorderIamgeView.layer.cornerRadius = 22
        storyBorderIamgeView.layer.borderWidth = 2
        storyBorderIamgeView.layer.borderColor = CGColor(red: 26/255, green: 116/255, blue: 229/255, alpha: 1)
        
        storyNameLabel.text = postInfo.userName
        storyProfilePictureImageView.image = UIImage(named: postInfo.profilePictureName)
        
        if let imageName = postInfo.imageName {
            storyPictureImageView.image = UIImage(named: imageName)
        } else {
            storyPictureImageView.image = nil
        }
    }
    
    
}
