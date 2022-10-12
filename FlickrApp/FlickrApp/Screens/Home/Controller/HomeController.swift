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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        
       
        // create index path
        //print("ROW: \(indexPath.row)")
        
        
        //cell.usernameLabel.text = responseArray[indexPath.row].title
        //cell.usernameLabel.text = responseArray[indexPath.item].title
        cell.postImageView.downloadImage(from: URL(string: "https://live.staticflickr.com/65535/52423427088_3d8b920828_w.jpg"))


        

        return cell
    }
    
    // MARK: - Properties
    
    private let provider = MoyaProvider<FlickrAPI>()

    var responseArray = [PhotoElement]()

    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.width = UIScreen.main.bounds.width
        // add border to the cell
        layout.itemSize.height = UIScreen.main.bounds.width + 150
        // change layout background color
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchPosts()    }

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
                    let responsePosts = try JSONDecoder().decode(Post.self, from: response.data)
                    
                    self.responseArray = responsePosts.photos.photo
                    print(response.data)
                    
                } catch let error {
                    print(error)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
