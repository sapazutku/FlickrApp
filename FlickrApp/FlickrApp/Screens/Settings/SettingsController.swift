//
//  SettingsController.swift
//  FlickrApp
//
//  Created by utku on 16.10.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class SettingsController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionOptions.count ?? .zero
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = sectionOptions[indexPath.row]
        // addTarget for cell
        cell.accessoryType = .none

        // add cell to button

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleSettings(row: indexPath.row)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else {
            return
        }

        // get user id
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        storage.child("images/\(uid).png").putData(imageData, metadata: nil) { _, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
            self.storage.child("images/\(uid).png").downloadURL { url, error in
                guard let url = url, error == nil else {
                    return
                }
                let urlString = url.absoluteString
                print("Download URL: \(urlString)")
                UserDefaults.standard.set(urlString, forKey: "profile_picture_url")
            }
        }

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    var imagePicker = UIImagePickerController()
    private let storage = Storage.storage().reference()

    private let reuseIdentifier = "SettingsCell"
    
    private let sectionOptions = [
        "Change Profile Photo", "Change Username", "Change Password",
        "About"
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
    
    @objc func handleSettings(row: Int) {
        switch row {
        case 0:
            changeProfilePhoto()
        case 1:
            changeUsername()
        case 2:
            changePassword()
        case 3:
            about()
        default:
            print("Error")
        }
    }
    

    func changeProfilePhoto() {
        let alert = UIAlertController(title: "Change Profile Photo", message: "Choose a photo", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }

    func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }


    func changeUsername() {
        let alert = UIAlertController(title: "Change Username", message: "Enter a new username", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "New Username"
        }
        
        alert.addAction(UIAlertAction(title: "Change", style: .default, handler: { _ in
            let username = alert.textFields![0].text
            let db = Firestore.firestore()
            db.collection("users").document(Auth.auth().currentUser!.uid).updateData(["username": username!]) { error in
                if error != nil {
                    print("Error")
                } else {
                    print("Success")
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    func changePassword() {
        let alert = UIAlertController(title: "Change Password", message: "Enter a new password", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Password"
        }
        
        alert.addAction(UIAlertAction(title: "Change", style: .default, handler: { _ in
            let passwword = alert.textFields![0].text
            let db = Firestore.firestore()
            db.collection("users").document(Auth.auth().currentUser!.uid).updateData(["password": passwword!]) { error in
                if error != nil {
                    print("Error")
                } else {
                    print("Success")
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    func about() {
        let alert = UIAlertController(title: "About", message: "FlickrApp is the weekly project of the Pazarama iOS Bootcamp.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }


    
}
