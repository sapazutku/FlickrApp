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
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor    
       
        cell.data = CellData(id: "1", title: "DENEME", url: "https://live.staticflickr.com//65535//52423185568_35e14b54b0_m.jpg", owner: "UTKU")
        

        return cell
    }
    
    // MARK: - Properties
    
    private let provider = MoyaProvider<FlickrAPI>()

    var responseArray = [Post]()
    var sizeArray = [Size]()
    
    var dataCellArray = [CellData]()

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
                    //let json = try JSONSerialization.jsonObject(with: response.data, options: [])
                    //print(json)

                    let posts = try JSONDecoder().decode(Post.self, from: response.data)
                    self.responseArray.append(posts)
                    self.collectionView.reloadData()
                    
                    // fetch size of the image

                    for i in 0..<posts.photos.photo.count {
                        let id = posts.photos.photo[i].id
                        self.provider.request(.getSize(id: id)) { result in
                            switch result {
                            case .success(let response):
                                do {
                                    let size = try JSONDecoder().decode(Size.self, from: response.data)
                                    self.sizeArray.append(size)
                                    self.collectionView.reloadData()
                                    
                                    // create cell data
                                    let cellData = CellData(id: id, title: posts.photos.photo[i].title, url:size.sizes.size[0].url , owner: posts.photos.photo[i].owner )
                                    print(cellData)
                                    self.dataCellArray.append(cellData)
                                    print(self.dataCellArray.count)
                                    
                                } catch let error {
                                    print("DEBUG: Error is \(error.localizedDescription)")
                                }
                            case .failure(let error):
                                print("DEBUG: Error is \(error.localizedDescription)")
                            }
                        }
                    }
                    
                    self.collectionView.reloadData()
                
                    
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchImage(photo_id: String){
        provider.request(.getSize(id:  photo_id)) { result in
            switch result {
            case .success(let response):
                do {
                    // print response json
                    //let json = try JSONSerialization.jsonObject(with: response.data, options: [])
                    //print(json)

                    let sizes = try JSONDecoder().decode(Size.self, from: response.data)
                    self.sizeArray.append(sizes)
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
