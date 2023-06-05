//
//  PostTableViewCell.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/5/31.
//

import UIKit

class HomePagePostTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stateButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var messageShareLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func updateUI(with postInfo: PostInfo) {
        profilePictureImageView.image = UIImage(named: postInfo.profilePictureName)
        nameLabel.text = postInfo.userName
        timeLabel.text = postInfo.timestamp
        messageLabel.text = postInfo.text
        postImageView.image = UIImage(named: postInfo.imageName)
        likeCountLabel.text = String(postInfo.likes)
        messageShareLabel.text = String(postInfo.commentsCount)+"則留言 "+String(postInfo.shares)+"次分享"
        
        // 設定背景色為透明
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        
        // cell 的 selectedBackgroundView
        selectedBackgroundView = backgroundView
    }

}
