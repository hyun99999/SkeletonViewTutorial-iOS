//
//  SkeletonCollectionViewCell.swift
//  SkeletonTutorial-iOS
//
//  Created by kimhyungyu on 2021/07/24.
//

import UIKit

class SkeletonCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var skeletonTextView: UITextView!
    @IBOutlet weak var skeletonFirstLabel: UILabel!
    @IBOutlet weak var skeletonImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isSkeletonable = true
        self.skeletonImageView.isSkeletonable = true
        self.skeletonFirstLabel.isSkeletonable = true
        self.skeletonTextView.isSkeletonable = true
        
        // 둥근 모서리
        
        self.skeletonImageView.skeletonCornerRadius = 10
        self.skeletonFirstLabel.linesCornerRadius = 5
        self.skeletonTextView.linesCornerRadius = 5

        // 마지막 줄에 skeleton 채우는 비율
        
        // numberOfLines 가 1 이면 적용되지 않음
        self.skeletonFirstLabel.numberOfLines = 2
        self.skeletonFirstLabel.lastLineFillPercent = 50

        self.skeletonTextView.lastLineFillPercent = 50
    }
}
