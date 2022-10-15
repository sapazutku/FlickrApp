//
//  PhotoCell.swift
//  FlickrApp
//
//  Created by utku on 15.10.2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    // MARK: - Properties

    var postImageView: UIImageView = {
           let iv = UIImageView()
           iv.contentMode = .scaleAspectFill
           iv.clipsToBounds = true
          
           return iv
       }()
    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(postImageView)
        // add border to the cell
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
      }

      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

      override func layoutSubviews() {
          super.layoutSubviews()
          postImageView.frame = CGRect(x: 0, y: 0, width: frame.width , height: frame.height)

      }
}
