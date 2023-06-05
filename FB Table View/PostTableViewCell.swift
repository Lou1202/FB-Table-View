//
//  PostTableViewCell.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/6/8.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postMessageLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func updateUI(with postInfo: PostInfo) {
        postMessageLabel.text = postInfo.text
        postImageView.image = UIImage(named: postInfo.imageName)
        // 設定背景色為透明
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        
        // cell 的 selectedBackgroundView
        selectedBackgroundView = backgroundView
    }

}
