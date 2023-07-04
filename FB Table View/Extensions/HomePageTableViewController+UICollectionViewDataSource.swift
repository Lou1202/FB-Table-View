//
//  HomePageTableViewController+UICollectionViewDataSource.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/6/5.
//

import UIKit

extension HomePageTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MyStoryCollectionViewCell.self)", for: indexPath) as? MyStoryCollectionViewCell else { fatalError("MyStoryCollectionViewCell failed") }
            cell.updateUI()
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(StoryCollectionViewCell.self)", for: indexPath) as? StoryCollectionViewCell else { fatalError("StoryCollectionViewCell failed") }
            let postInfo = postArray[indexPath.row - 1]
            cell.updateUI(with: postInfo)
            return cell
        }
    }
    
}
