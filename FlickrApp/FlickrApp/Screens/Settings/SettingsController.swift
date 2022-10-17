//
//  SettingsController.swift
//  FlickrApp
//
//  Created by utku on 16.10.2022.
//

import UIKit


class SettingsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = sectionOptions[indexPath.row]
        
        return cell
    }
    
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    
    private let reuseIdentifier = "SettingsCell"
    
    private let sectionOptions = [
        "Change Profile Photo", "Change Username", "Change Password",
        "About", "Send Feedback"
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "Settings"
        // left bar button back button

        navigationItem.leftItemsSupplementBackButton = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 64
        tableView.tableFooterView = UIView()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Methods
    

    
    
}
