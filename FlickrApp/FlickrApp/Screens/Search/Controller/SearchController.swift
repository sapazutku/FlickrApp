//
//  SearchController.swift
//  FlickrApp
//
//  Created by utku on 12.10.2022.
//

import UIKit

class SearchController: UIViewController {
    
    // MARK: - Properties
    private let label : UILabel = {
        let label = UILabel()
        label.text = "Search"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Search"
        view.addSubview(label)
    }
}
