//
//  WalkThroughCollectionViewCell.swift
//  Garsah
//
//  Created by Norah Almaneea on 19/05/2022.
//

import UIKit

class WalkThroughCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitle: UILabel!
    @IBOutlet weak var slideDescription: UILabel!
    
    func setup(_ slide: WalkThroughSlide){
        slideImageView.image = slide.image
        slideTitle.text = slide.title
        slideDescription.text = slide.description
    }
}
