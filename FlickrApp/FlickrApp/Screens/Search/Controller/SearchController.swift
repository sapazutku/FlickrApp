//
//  SearchController.swift
//  FlickrApp
//
//  Created by utku on 12.10.2022.
//

import UIKit
import Moya

class SearchController: UIViewController {
    
    // MARK: - Properties

    private let provider = MoyaProvider<FlickrAPI>()


    // MARK: - Components


       private let label : UILabel = {
        let label = UILabel()
        label.text = "Search"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        // search bar 
        
        
        return searchBar
    }()



    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }


    
    // MARK: - Helpers
    

    // add SearchView
    func configureUI() {

        view.backgroundColor = .white
        //view.addSubview(label)
        navigationItem.title = "Search"
        view.addSubview(searchBar)

        label.frame = CGRect(x: 20, y: 20, width: 100, height: 20)
        searchBar.frame = CGRect(x: 10, y: 100, width: view.frame.width - 20, height: 50)
    }

    // MARK: - Methods

   // func fetchPopular

}
