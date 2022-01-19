//
//  ExploreCell.swift
//  Eat
//
//  Created by lu on 2022/1/3.
//

import UIKit

class ExploreCell: UICollectionViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgExplore: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgExplore.layer.cornerRadius = 9
        imgExplore.layer.masksToBounds = true
    }
}
