//
//  UserControlller.swift
//  FlickrApp
//
//  Created by utku on 12.10.2022.
//

import UIKit
import FirebaseAuth
class UserController: UIViewController {
    
    // MARK: - Properties
    var user: User?

    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
    
        iv.backgroundColor = .lightGray
        return iv
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .systemPink
        
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()

    // likes Button
    private let likesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Likes", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        // set button width to half of the screen
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        button.addTarget(self, action: #selector(handleShowLikes), for: .touchUpInside)


        return button
    }()

    // saves Button

    private let savesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Saves", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        button.addTarget(self, action: #selector(handleShowSaves), for: .touchUpInside)
        return button
    }()

    
    

    // Likes and Saves CollectionView
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()


    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getUser()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "User Page"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain , target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem?.tintColor = .systemPink
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain , target: self, action: #selector(handleSettings))
        navigationItem.leftBarButtonItem?.tintColor = .systemPink
        
        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalTo(view.snp.left).offset(16)
            make.width.height.equalTo(100)
        }
        profileImageView.layer.cornerRadius = 100 / 2

        view.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.left.equalTo(profileImageView.snp.right).offset(16)
        }
        
        
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.left.equalTo(profileImageView.snp.right).offset(16)
        }
        
        
       

        view.addSubview(likesButton)
        likesButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.left.equalTo(view.snp.left).offset(16)
        }

        view.addSubview(savesButton)
        savesButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.left.equalTo(likesButton.snp.right).offset(16)
        }

        view.addSubview(collectionView)
       collectionView.snp.makeConstraints { make in
           make.top.equalTo(profileImageView.snp.bottom).offset(16)
           make.left.right.equalTo(view)
           make.height.equalTo(200)
       }

        

    }
    
    // MARK: -Methods
    
    func getUser(){
        usernameLabel.text = FirebaseAuth.Auth.auth().currentUser?.displayName
        emailLabel.text = FirebaseAuth.Auth.auth().currentUser?.email
    }
    
    @objc func handleLogout(){
        do {
            try Auth.auth().signOut()
            let nav = UINavigationController(rootViewController: LoginController())
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true, completion: nil)
        } catch {
            print(error.localizedDescription)
        }
    }

    @objc func handleSettings(){
        let controller = SettingsController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleShowLikes(){
        print("likes")
        likesButton.setTitleColor(.systemPink, for: .normal)
        savesButton.setTitleColor(.black, for: .normal)
    }
    
    @objc func handleShowSaves(){
        print("saves")
        likesButton.setTitleColor(.black, for: .normal)
        savesButton.setTitleColor(.systemPink, for: .normal)
    }
}
