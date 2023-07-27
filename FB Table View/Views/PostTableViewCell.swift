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
            if UUID(uuidString: imageName) != nil { // imageName是UUID，從文件系統讀取
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentsDirectory.appendingPathComponent(imageName)

                postImageView.image = UIImage(contentsOfFile: fileURL.path)
            } else { // 從Asset圖庫讀取
                postImageView.image = UIImage(named: imageName)
            }
        } else {
            postImageView.image = nil
        }

        
    }

}
