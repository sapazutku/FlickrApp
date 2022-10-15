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
        return responseArray.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        
        let post = responseArray[indexPath.item]
        
        cell.post = post
        cell.usernameLabel.text = post.ownername
        cell.postImageView.downloadImage(from: post.url_m)
        cell.captionLabel.text = post.title
        
        // if url have an image, download it
        let iconURL =  "http://farm\(post.iconfarm!).staticflickr.com/\(post.iconserver!)/buddyicons/\(post.owner!).jpg"
        

        if post.iconserver != "0"{
            cell.profileImageView?.downloadImage(from: URL(string: iconURL))
        }
        else{
            cell.profileImageView?.downloadImage(from: URL(string: "https://www.flickr.com/images/buddyicon.gif"))
        }
        
        //print(iconURL)
        return cell
    }
    
    // MARK: - Properties
    
    private let provider = MoyaProvider<FlickrAPI>()

    private var responseArray = [PhotoElement]()

    
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
