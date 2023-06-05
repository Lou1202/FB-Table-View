//
//  LikesTableViewCell.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/6/8.
//

import UIKit

class LikesTableViewCell: UITableViewCell {

    @IBOutlet weak var LikesLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(with postInfo: PostInfo){
        LikesLabel.text = String(postInfo.likes)
        sharesLabel.text = String(postInfo.shares)+"次分享"
        // 設定背景色為透明
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        
        // cell 的 selectedBackgroundView
        selectedBackgroundView = backgroundView
    }

}
