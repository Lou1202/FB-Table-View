//
//  CommentTableViewCell.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/6/8.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(with postComment: PostComment) {
        
        userImageView.image = UIImage(named: postComment.profilePictureName)
        commentLabel.text = "\(postComment.userName)\n\(postComment.content)"
        timeLabel.text = timeAgoDisplay(date: postComment.timestamp)
        if postComment.likes != 0 {
            likesLabel.text = "\(postComment.likes)👍"
        } else {
            likesLabel.text = ""
        }
        if postComment.isLiked {
            likeButton.tintColor = UIColor(red: 23/255, green: 119/255, blue: 241/255, alpha: 1)
        } else {
            likeButton.tintColor = UIColor(red: 100/255, green: 103/255, blue: 106/255, alpha: 1)
        }
        
    }

}
