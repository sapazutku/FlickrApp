//
//  HomeController.swift
//  FlickrApp
//
//  Created by utku on 12.10.2022.
//

import UIKit

// create a text Home Controller 
class HomeController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.layer.borderWidth = 1
        
        return cell
    }
    
    // MARK: - Properties

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.width = UIScreen.main.bounds.width
        // add border to the cell
        layout.itemSize.height = UIScreen.main.bounds.width + 50
        // change layout background color
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .gray
        navigationItem.title = "Home"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "PostCell")
        view.addSubview(collectionView)
        collectionView.frame = view.frame
        
    }

}
