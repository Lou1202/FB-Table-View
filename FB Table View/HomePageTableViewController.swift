//
//  HomepageTableViewController.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/5/29.
//

import UIKit
import PhotosUI

class HomePageTableViewController: UITableViewController {
    
//    var previousOffset: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationbar()
        commentTest()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let currentOffset = scrollView.contentOffset.y
//        let isScrollUp = currentOffset < previousOffset
//        let isScrollDown = currentOffset > previousOffset
//
//        if isScrollUp {
//            self.navigationController?.isNavigationBarHidden = false
//        } else if isScrollDown {
//            self.navigationController?.isNavigationBarHidden = true
//        }
//
//        previousOffset = currentOffset
//    }
    

    
    
    func setNavigationbar() {
        //設定左邊選單按鈕
        let menuButton = UIButton(type: .system)
        menuButton.frame = CGRect(x: 0, y: 0, width: 10, height: 40)
        let leftBarSymbolConfig = UIImage.SymbolConfiguration(weight: .heavy)
        let menuImage = UIImage(systemName: "line.3.horizontal", withConfiguration: leftBarSymbolConfig)
        menuButton.setImage(menuImage, for: .normal)
        menuButton.tintColor = UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1)
        let barButtonItem = UIBarButtonItem(customView: menuButton)
        
        //設定標題
        let label = UILabel()
        label.text = "facebook"
        label.textColor = UIColor(red: 23/255, green: 119/255, blue: 241/255, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 30)
        let labelItem = UIBarButtonItem(customView: label)
        
        //設定rightBarButtonItems的symbol圖片統一的樣式
        let rightBarSymbolConfig = UIImage.SymbolConfiguration(weight: .heavy)
        //設定messageButton樣式
        let messageButton = UIButton(type: .system)
        messageButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let messageImage = UIImage(systemName: "message.fill", withConfiguration: rightBarSymbolConfig)
        messageButton.setImage(messageImage, for: .normal)
        messageButton.backgroundColor = UIColor(red: 228/255, green: 229/255, blue: 234/255, alpha: 1)
        messageButton.tintColor = UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1)
        messageButton.layer.cornerRadius = 20
        let messageBarButtonItem = UIBarButtonItem(customView: messageButton)
        
        //設定searchButton樣式
        let searchButton = UIButton(type: .system)
        searchButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let searchImage = UIImage(systemName: "magnifyingglass", withConfiguration: rightBarSymbolConfig)
        searchButton.setImage(searchImage, for: .normal)
        searchButton.backgroundColor = UIColor(red: 228/255, green: 229/255, blue: 234/255, alpha: 1)
        searchButton.tintColor = UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1)
        searchButton.layer.cornerRadius = 20
        let searchBarButtonItem = UIBarButtonItem(customView: searchButton)
        
        //設定plusButton樣式
        let plusButton = UIButton(type: .system)
        plusButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let plusImage = UIImage(systemName: "plus", withConfiguration: rightBarSymbolConfig)
        plusButton.setImage(plusImage, for: .normal)
        plusButton.backgroundColor = UIColor(red: 228/255, green: 229/255, blue: 234/255, alpha: 1)
        plusButton.tintColor = UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1)
        plusButton.layer.cornerRadius = 20
        //設定選單(menu)按鈕
        plusButton.showsMenuAsPrimaryAction = true
        plusButton.menu = UIMenu(children: [UIAction(title: "發佈",image: UIImage(systemName: "square.and.pencil") ,handler: { _ in
            print("發佈")
        }),
                                            UIAction(title: "限時動態",image: UIImage(systemName: "book.fill") ,handler: { _ in
            print("限時動態")
        }),
                                            UIAction(title: "連續短片",image: UIImage(systemName: "play.rectangle.fill") ,handler: { _ in
            print("連續短片")
        }),
                                            UIAction(title: "直播",image: UIImage(systemName: "video.fill") ,handler: { _ in
            print("直播")
        })
                                           ])
        let plusBarButtonItem = UIBarButtonItem(customView: plusButton)
        
        
        //加入按鈕樣式到Navugation
        navigationItem.leftBarButtonItems = [barButtonItem, labelItem]
        navigationItem.rightBarButtonItems = [messageBarButtonItem, searchBarButtonItem, plusBarButtonItem]
    }
    
    func commentTest() {
        
        for i in 0..<postArray.count {
            postArray[i].comments.append(PostComment(userName: postArray[i].userName, profilePictureName: postArray[i].profilePictureName, content: "hello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello world", timestamp: "5分鐘"))
        }
    }
    
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 2 + postArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section < 2{
            return 1
        } else {
            return 2
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(TopTableViewCell.self)", for: indexPath) as? TopTableViewCell else {
                fatalError("TopTableViewCell failed") }
            return cell
            
        } else if indexPath.section == 1  {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(StoryTableViewCell.self)", for: indexPath) as? StoryTableViewCell else { fatalError("StoryTableViewCell failed") }
            return cell
            
        } else if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(HomePagePostTableViewCell.self)", for: indexPath) as? HomePagePostTableViewCell else { fatalError("HomePagePostTableViewCell failed") }
            let postInfo = postArray[indexPath.section - 2]
            cell.updateUI(with: postInfo)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PostButtonTableViewCell.self)", for: indexPath) as? PostButtonTableViewCell else { fatalError("PostBarTableViewCell failed") }
            let postInfo = postArray[indexPath.section - 2]
            cell.updateUI(with: postInfo)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 180
        } else {
            return UITableView.automaticDimension
        }
        
    }
    
    
    @IBAction func selectphoto(_ sender: Any) {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    
    @IBAction func likePost(_ sender: UIButton) {
        
        let point = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point){
            let section = indexPath.section
            postArray[section - 2].isLiked = !postArray[section - 2].isLiked
            let likeBtnImageName = postArray[section - 2].likeButtonImageName
            sender.setImage(UIImage(systemName: likeBtnImageName), for: .normal)
            
            
            if postArray[section - 2].isLiked {
                sender.tintColor = UIColor(red: 23/255, green: 119/255, blue: 241/255, alpha: 1)
            } else {
                sender.tintColor = UIColor(red: 100/255, green: 103/255, blue: 106/255, alpha: 1)
            }
            
            // 取得likecountLabel所在的 indexPath
            let postIndexPath = [IndexPath(row: 0, section: section)]
            // 重新載入表格
            tableView.reloadRows(at: postIndexPath, with: .none)
            
        }
    }
    
    

    @IBSegueAction func showPost(_ coder: NSCoder) -> PostViewController? {
        guard let section = tableView.indexPathForSelectedRow?.section else { return nil }
        let selectSection = section - 2
        return PostViewController(coder: coder, selectSection: selectSection)
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
