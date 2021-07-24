//
//  SkeletonCollectionViewCell.swift
//  SkeletonTutorial-iOS
//
//  Created by kimhyungyu on 2021/07/24.
//

import UIKit

class SkeletonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var skeletonThirdLabel: UILabel!
    @IBOutlet weak var skeletonSecondLabel: UILabel!
    @IBOutlet weak var skeletonFirstLabel: UILabel!
    @IBOutlet weak var skeletonImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isSkeletonable = true
        self.skeletonImageView.isSkeletonable = true
        self.skeletonFirstLabel.isSkeletonable = true
        self.skeletonSecondLabel.isSkeletonable = true
        self.skeletonThirdLabel.isSkeletonable = true
        
        skeletonImageView.skeletonCornerRadius = 10
        skeletonFirstLabel.skeletonCornerRadius = 10
        skeletonSecondLabel.skeletonCornerRadius = 10
        skeletonThirdLabel.skeletonCornerRadius = 10
        
        skeletonFirstLabel.lastLineFillPercent = 30
        skeletonSecondLabel.lastLineFillPercent = 50
        skeletonThirdLabel.lastLineFillPercent = 70
    }

}
