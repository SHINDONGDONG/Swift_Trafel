//
//  OnboardingCollectionViewCell.swift
//  Swift_Trafel
//
//  Created by 申民鐡 on 2022/07/04.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    @IBOutlet weak var slideImageView: UIImageView!
    
    
    
    //MARK: - Configures
    
    func configure(image: UIImage) {
        slideImageView.image = image
    }
    
}
