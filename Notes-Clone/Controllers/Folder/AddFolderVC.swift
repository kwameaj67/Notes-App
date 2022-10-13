//
//  AddFolderVC.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 09/10/2022.
//

import UIKit

class AddFolderVC: UIViewController, UINavigationBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.dark
        setupViews()
        setupContraints()
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing)))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
    }
    // MARK: Properties -
    let textField: UITextField = {
        var tf = NTextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Enter name of folder", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4,NSAttributedString.Key.font: UIFont(name: Font.regular.rawValue, size: 14)!])
        tf.text = "New Folder"
        tf.textAlignment = .left
        tf.isHighlighted = true
        return tf
    }()
    let saveBtn: UIButton = {
        var btn = NButton()
        btn.layer.cornerRadius = 52/2
        btn.titleLabel?.textColor = .white
        btn.setTitle("Save", for: .normal)
        btn.backgroundColor = Color.cell_dark_bg
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    @objc func buttonTapped(){
        
    }
    func setupViews(){
        view.addSubview(textField)
        view.addSubview(saveBtn)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            saveBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            saveBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            saveBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            saveBtn.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    func configureNavBar(){
        let height: CGFloat = 90.0
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: height))
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Color.dark
        appearance.titleTextAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: Font.semi_bold.rawValue, size: 17)!]
        navbar.standardAppearance = appearance
        navbar.scrollEdgeAppearance = appearance
        
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.isTranslucent = true
        navbar.translatesAutoresizingMaskIntoConstraints = false

        navbar.delegate = self
        let navbarItem = UINavigationItem()
        navbarItem.title = "Create a folder"
        
        let exitButton = UIButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        exitButton.setBackgroundImage(UIImage(systemName: "xmark",withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), for: .normal)
        exitButton.tintColor = .white
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        exitButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        navbarItem.leftBarButtonItem = UIBarButtonItem(customView: exitButton)
        
        
        navbar.items = [navbarItem]
        view.addSubview(navbar)
        self.view.frame = CGRect(x: 0, y: height, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - height))
        
        NSLayoutConstraint.activate([
            exitButton.heightAnchor.constraint(equalToConstant: 24.0),
            exitButton.widthAnchor.constraint(equalToConstant: 24.0),
            
            navbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0),
            navbar.heightAnchor.constraint(equalToConstant: 50.0),
            navbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: navbar.bottomAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textField.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    @objc func closeVC(){
        dismiss(animated: true, completion: nil)
    }
}


extension AddFolderVC {
    
}
