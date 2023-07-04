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

        
    }

}
