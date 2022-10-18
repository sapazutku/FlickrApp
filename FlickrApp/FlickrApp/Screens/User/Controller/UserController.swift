//
//  UserControlller.swift
//  FlickrApp
//
//  Created by utku on 12.10.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
class UserController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data == false {
            return user?.likes.count ?? .zero
        } else {
            return user?.saves.count ?? .zero
        }
        
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = user?.likes[indexPath.row]
        
        if data == false{
            cell.imageView?.downloadImage(from: URL(string: user?.likes[indexPath.row] ?? "https://via.placeholder.com/150")!)
        }
        else{
            cell.imageView?.downloadImage(from: URL(string: user?.saves[indexPath.row] ?? "https://via.placeholder.com/150")!)
        }
        
        return cell
    }
    
    
        
   
    
    
    // MARK: - Properties
    var user: User?
    var data: Bool = false
    


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
        button.setTitleColor(.systemPink, for: .normal)
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


    // table view
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
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
        
        // likes button and save button in a line
        let stack = UIStackView(arrangedSubviews: [likesButton, savesButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(50)
        }

        // table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(16)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }


    }
    
    // MARK: -Methods
    
    func getUser(){   
        // get user info from Firestore
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: Failed to fetch user with error \(error.localizedDescription)")
                return
            }
            guard let dictionary = snapshot?.data() else { return }
            self.user = User(username: dictionary["username"] as! String, email: dictionary["email"] as! String, likes: dictionary["likes"] as! [String], saves: dictionary["saves"] as! [String])
            self.usernameLabel.text = self.user?.username
            self.emailLabel.text = self.user?.email
            
            self.getUserPhoto(uid: uid)
            self.tableView.reloadData()
            
        }
    }
    
    func getUserPhoto(uid:String){
        // get profile image from firebase storage
        Storage.storage().reference().child("images/\(uid).png").getData(maxSize: 15 * 1024 * 1024) { data, error in
            if error != nil  {
                print("DEBUG: Failed to fetch user photo with error \(error!.localizedDescription)")
                return
            }
            guard let data = data else { return }
            let image = UIImage(data: data)
            self.profileImageView.image = image
        }
    }

    func getLikes(){
        // get current user likes array from firestore
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: Error getting likes \(error.localizedDescription)")
            }
            guard let data = snapshot?.data() else { return }
            // print likes array
            print("DEBUG: Likes array \(data["likes"] as? [String])")
        }
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
        data = false
        tableView.reloadData()
    }
    
    @objc func handleShowSaves(){
        print("saves")
        likesButton.setTitleColor(.black, for: .normal)
        savesButton.setTitleColor(.systemPink, for: .normal)
        data = true
        tableView.reloadData()
    }
}


/*
let storage = Storage.storage().reference(forURL: "gs://flickrapp-22b24.appspot.com")
        let profileImageRef = storage.child("/images/\(uid).png")
        profileImageRef.getData(maxSize: 1 * 240 * 240) { data, error in
            if let error = error {
                print("DEBUG: Failed to fetch profile image with error \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            let image = UIImage(data: data)
            self.profileImageView.image = image
        }
*/
