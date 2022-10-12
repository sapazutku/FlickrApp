//
//  HomeController.swift
//  FlickrApp
//
//  Created by utku on 12.10.2022.
//

import UIKit
import Moya

// create a text Home Controller 
class HomeController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return responseArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor    
        cell.post = responseArray[indexPath.row]

        return cell
    }
    
    // MARK: - Properties
    
    private let provider = MoyaProvider<FlickrAPI>()

    var responseArray = [Post]()

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
        fetchPosts()
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
    
    
    func fetchPosts(){
        provider.request(.getRecent) { result in
            switch result {
            case .success(let response):
                do {
                    // print response json
                    let json = try JSONSerialization.jsonObject(with: response.data, options: [])
                    print(json)

                    let posts = try JSONDecoder().decode(Post.self, from: response.data)
                    self.responseArray.append(posts)
                    self.collectionView.reloadData()
                    
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
