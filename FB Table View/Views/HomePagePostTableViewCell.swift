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
        timeLabel.text = timeAgoDisplay(date: postInfo.timestamp)
        if postInfo.isPublic {
            stateButton.setImage(UIImage(systemName: "globe.asia.australia.fill"), for: .normal)
        } else {
            stateButton.setImage(UIImage(systemName: "person.2.fill"), for: .normal)
        }
        messageLabel.text = postInfo.text
        if let imageName = postInfo.imageName {
            if UUID(uuidString: imageName) != nil { // 如果 imageName 是 UUID，则从文件系统读取
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentsDirectory.appendingPathComponent(imageName)

                postImageView.image = UIImage(contentsOfFile: fileURL.path)
            } else { // 否则，从 Asset Catalogs 读取
                postImageView.image = UIImage(named: imageName)
            }
        } else {
            postImageView.image = nil
        }

        likeCountLabel.text = String(postInfo.likes)
        messageShareLabel.text = String(postInfo.commentsCount)+"則留言 "+String(postInfo.shares)+"次分享"
    }
    
}
