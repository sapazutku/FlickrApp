//
//  HomeController.swift
//  FlickrApp
//
//  Created by utku on 12.10.2022.
//

import UIKit
import Moya

// create a text Home Controller
class SearchController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return responseArray.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = responseArray[indexPath.item]
        cell.postImageView.downloadImage(from: post.url_m)
        return cell
    }
    
    // MARK: - Properties
    
    private let provider = MoyaProvider<FlickrAPI>()
    private var responseArray = [PhotoElement]()
    private var searchText = ""
    
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search for images"
        sb.searchBarStyle = .minimal
        sb.barStyle = .default
        sb.barTintColor = .white
        sb.backgroundColor = .white
        sb.layer.borderWidth = 0
        sb.layer.borderColor = UIColor.white.cgColor
        sb.layer.cornerRadius = 10
        sb.clipsToBounds = true
        return sb
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.width = UIScreen.main.bounds.width / 2.5
        layout.scrollDirection = .vertical
        // top 50
        layout.sectionInset = UIEdgeInsets(top: 60, left: 30, bottom: 0, right: 30)
        // add border to the cell
        layout.itemSize.height = UIScreen.main.bounds.height / 2.5
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.alwaysBounceVertical = true
        
        cv.translatesAutoresizingMaskIntoConstraints = false
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
        navigationItem.title = "Search"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        view.addSubview(collectionView)
        collectionView.frame = view.frame
        collectionView.addSubview(searchBar)
        searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        searchBar.tintColor = .systemPink
        searchBar.delegate = self
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

    @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }

    @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Gönderiler: \(searchText)")
    }

    
}


/*
if searchText.isEmpty {
            fetchPosts()
        } else {
            provider.request(.searchPhotos(text: searchText)) { result in
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
*/
