//
//  CollectionViewCell.swift
//  FlickrApp
//
//  Created by utku on 12.10.2022.
//

import UIKit

class PostCell: UICollectionViewCell {

    // MARK: - Properties

    var data: PhotoElement? {
        didSet {
            guard let data = data else { return }
        }
    }

    var postImageView: UIImageView = {
           let iv = UIImageView()
           iv.contentMode = .scaleAspectFill
           iv.clipsToBounds = true
          
           return iv
       }()

    var usernameLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.boldSystemFont(ofSize: 14)
           label.textColor = .black
           return label
       }()

       private let profileImageView: UIImageView = {
           let iv = UIImageView()
           iv.contentMode = .scaleAspectFill
           iv.clipsToBounds = true
           iv.backgroundColor = .lightGray
           return iv
       }()

       private let captionLabel: UILabel = {
           let label = UILabel()
           
           label.textColor = .black
           return label
       }()

       private let likesLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 14)
           label.textColor = .black
           return label
       }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
          super.init(frame: frame)
          backgroundColor = .white
          addSubview(postImageView)
          addSubview(usernameLabel)
          addSubview(profileImageView)
          addSubview(captionLabel)
          addSubview(likesLabel)
          
          //postImageView.backgroundColor = .red
        //captionLabel.text = data?.title
        
      }

      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

      override func layoutSubviews() {
          super.layoutSubviews()
          profileImageView.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
          profileImageView.layer.cornerRadius = 40 / 2
          usernameLabel.frame = CGRect(x: profileImageView.frame.origin.x + 50, y: 10, width: contentView.frame.size.width - 60, height: 40)
          postImageView.frame = CGRect(x: 0, y: profileImageView.frame.origin.y + 50, width: frame.width, height: contentView.frame.size.width)
          likesLabel.frame = CGRect(x: 10, y: postImageView.frame.origin.y + postImageView.frame.size.height + 10, width: contentView.frame.size.width - 20, height: 40)
          captionLabel.frame = CGRect(x: profileImageView.frame.origin.x + 50, y: likesLabel.frame.origin.y + 50, width: 200, height: 40)
      }
    
    


}
