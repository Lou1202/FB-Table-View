//
//  PostBarTableViewCell.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/5/31.
//

import UIKit

class PostButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateUI(with postInfo: PostInfo){
        if postInfo.isLiked {
            likeButton.setImage(UIImage(systemName: postInfo.likeButtonImageName), for: .normal)
            likeButton.tintColor = UIColor(red: 23/255, green: 119/255, blue: 241/255, alpha: 1)
        } else {
            likeButton.setImage(UIImage(systemName: postInfo.likeButtonImageName), for: .normal)
            likeButton.tintColor = UIColor(red: 100/255, green: 103/255, blue: 106/255, alpha: 1)
        }
        
    }

}
