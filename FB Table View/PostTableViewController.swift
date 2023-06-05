//
//  PostTableViewController.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/6/7.
//

import UIKit

class PostTableViewController: UITableViewController {
    
    var selectSection: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let selectSection = selectSection else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PostTableViewCell.self)", for: indexPath) as? PostTableViewCell else { fatalError("PostTableViewCell failed") }
            let postInfo = postArray[selectSection]
            cell.updateUI(with: postInfo)
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PostButtonTableViewCell.self)", for: indexPath) as? PostButtonTableViewCell else { fatalError("PostBarTableViewCell failed") }
            let postInfo = postArray[selectSection]
            cell.updateUI(with: postInfo)
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(LikesTableViewCell.self)", for: indexPath) as? LikesTableViewCell else { fatalError("LikesTableViewCell failed") }
            let postInfo = postArray[selectSection]
            cell.updateUI(with: postInfo)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CommentTableViewCell.self)" , for: indexPath) as? CommentTableViewCell else { fatalError("CommentTableViewCell failed ") }
            let postComment = postArray[selectSection].comments[0]
            cell.updateUI(with: postComment)
            return cell
        }
        
    }
    
    @IBAction func likePost(_ sender: UIButton) {
        
        guard let selectSection = selectSection else { return }
        
        postArray[selectSection].isLiked = !postArray[selectSection].isLiked
        let likeBtnImageName = postArray[selectSection].likeButtonImageName
        sender.setImage(UIImage(systemName: likeBtnImageName), for: .normal)
        
        if postArray[selectSection].isLiked {
            sender.tintColor = UIColor(red: 23/255, green: 119/255, blue: 241/255, alpha: 1)
        } else {
            sender.tintColor = UIColor(red: 100/255, green: 103/255, blue: 106/255, alpha: 1)
        }
        // 取得likecountLabel所在的 indexPath
        let postIndexPath = [IndexPath(row: 0, section: 2)]
        // 重新載入表格
        tableView.reloadRows(at: postIndexPath, with: .none)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    
}


