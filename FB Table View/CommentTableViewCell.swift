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
        timeLabel.text = postComment.timestamp
        // 設定背景色為透明
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        // cell 的 selectedBackgroundView
        selectedBackgroundView = backgroundView
    }

}
