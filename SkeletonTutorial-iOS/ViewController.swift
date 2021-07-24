//
//  ViewController.swift
//  SkeletonTutorial-iOS
//
//  Created by kimhyungyu on 2021/07/24.
//

import UIKit
import SkeletonView

class ViewController: UIViewController {
    var countData: [Int] = []

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var skeletonCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skeletonCollectionView.delegate = self
        skeletonCollectionView.dataSource = self
        skeletonCollectionView.register(UINib(nibName: "SkeletonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SkeletonCollectionViewCell")
        
        skeletonCollectionView.isSkeletonable = true
        skeletonCollectionView.showSkeleton()
        // 다음과 같이 설정 가능
//        skeletonCollectionView.showSkeleton(usingColor: .gray, transition: .crossDissolve(0.25))
        
        // 네트워크 통신 대신 DisdspatchQueue 를 통해서 2초간 딜레이를 주어서 구현
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            for i in 0..<10 {
                self.countData.append(i)
            }
        }
        skeletonCollectionView.stopSkeletonAnimation()
        skeletonCollectionView.hideSkeleton()
        // 다음과 같이 설정 가능
//        skeletonCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
    }
}

// MARK: - SkeletonTableViewDelegate
extension ViewController: SkeletonCollectionViewDelegate {
    
    
}
// MARK: - SkeletonTableViewDataSource
extension ViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "SkeletonCollectionViewCell"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkeletonCollectionViewCell", for: indexPath) as? SkeletonCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.skeletonImageView.image = UIImage(named: "icon") ?? UIImage()
        cell.skeletonFirstLabel.text = String(countData[indexPath.row])
        cell.skeletonSecondLabel.text = String(countData[indexPath.row])
        cell.skeletonThirdLabel.text = String(countData[indexPath.row])

        return cell
    }
    
    // 컬렉션뷰를 다 채우기 위한 개수
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UICollectionView.automaticNumberOfSkeletonItems
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width
        return CGSize(width: cellWidth, height: 150)
    }
}
