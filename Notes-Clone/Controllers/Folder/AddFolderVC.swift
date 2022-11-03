//
//  AddFolderVC.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 09/10/2022.
//

import UIKit

protocol SaveFolderDelegate: AnyObject {
    func saveFolder(isSaved: Bool)
}
class AddFolderVC: UIViewController, UINavigationBarDelegate, UITextFieldDelegate {
    let categories = CategoryType.data
    var delegate : SaveFolderDelegate?
    
    private let viewModel = FolderViewModel()
    private var isShowingKeyboard:Bool = false
    private var bottomButtonConstraint = NSLayoutConstraint()
    private var selectedCategory: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        setupViews()
        setupContraints()
        folderTextField.delegate = self
        handleButtonOnKeyboardShow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        folderTextField.becomeFirstResponder()
        folderTextField.selectedTextRange = folderTextField.textRange(from: folderTextField.beginningOfDocument, to: folderTextField.endOfDocument)
    }
    // MARK: Properties -
    let folderTextField: UITextField = {
        var tf = NTextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Enter name of folder", attributes: [NSAttributedString.Key.foregroundColor: Color.text_color_normal,NSAttributedString.Key.font: UIFont(name: Font.regular.rawValue, size: 14)!])
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
        btn.addTarget(self, action: #selector(saveFolder), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    lazy var categoryCollectionView: UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 15, right: 20)
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.setCollectionViewLayout(layout, animated: false)
        cv.register(CategoryTypeCell.self, forCellWithReuseIdentifier: CategoryTypeCell.reusableId)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = true
        cv.allowsSelection = true
        cv.allowsMultipleSelection = false
        cv.isUserInteractionEnabled = true
        cv.bounces = true
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    @objc func saveFolder(){
        viewModel.addFolder(category: selectedCategory, heading: folderTextField.text!) {
           
        }
        dismiss(animated: true, completion: nil)
        delegate?.saveFolder(isSaved: true)
    }
    func setupViews(){
        view.addSubview(folderTextField)
        view.addSubview(saveBtn)
        view.addSubview(titleLabel)
        view.addSubview(categoryCollectionView)
        
        titleLabel.attributedText = setupAttributedText("Suggested Categories", "You'll see categories when you create a new \nfolder or a note")
        titleLabel.setLineHeight(lineHeight: 1)
    }
    func setupContraints(){
        bottomButtonConstraint =  saveBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        bottomButtonConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: folderTextField.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            
            categoryCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 175),
            
            saveBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            saveBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            saveBtn.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
}


extension AddFolderVC {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isShowingKeyboard = true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if !text.isEmpty{
            saveBtn.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.2) {
                self.saveBtn.alpha = 1
            }
        } else {
            saveBtn.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.2) {
                self.saveBtn.alpha = 0.6
            }
           
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        saveBtn.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.2) {
            self.saveBtn.alpha = 0.6
        }
        return true
    }
    
    // handle saveButton when keyboard shows
    func handleButtonOnKeyboardShow(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func keyboardWillShow(notification: Notification){
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if isShowingKeyboard{
                self.bottomButtonConstraint.constant = -280
            }
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }

    }
    @objc private func keyboardWillHide(notification: Notification){
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if isShowingKeyboard{
                self.bottomButtonConstraint.constant = -20
            }
            UIView.animate(withDuration: 0.5,animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
          
        }
    }
}

extension AddFolderVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryTypeCell.reusableId, for: indexPath) as! CategoryTypeCell
        cell.data = categories[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = categories[indexPath.row]
//        let width = self.estimatedFrame(text: item.title, font: UIFont(name: Font.medium.rawValue, size: 14)!).width
        let itemSize = item.title.size(withAttributes: [NSAttributedString.Key.font:UIFont(name: Font.medium.rawValue, size: 14)!])
        return CGSize(width: itemSize.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: IndexPath(item: indexPath.row, section: 0), at: [.centeredHorizontally,.centeredVertically], animated: true)
        collectionView.layoutSubviews()
        let item = categories[indexPath.row]
        selectedCategory = item.title
        print(item.title)

    }
//    func estimatedFrame(text: String, font: UIFont) -> CGRect {
//        let size = CGSize(width: 200, height: 1000) // temporary size
//        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: font], context: nil)
//    }
    func setupAttributedText(_ title: String,_ subTitle: String) -> NSAttributedString{
        let text = NSMutableAttributedString(string: title, attributes: [.foregroundColor: Color.text_color_heading,.font: UIFont(name: Font.semi_bold.rawValue, size: 20)!])
        text.append(NSAttributedString(string: "\n\n\(subTitle)", attributes: [.foregroundColor: Color.text_color_normal,.font: UIFont(name: Font.medium.rawValue, size: 15)!]))
        return text
    }
}

extension AddFolderVC {
    func configureNavBar(){
        let height: CGFloat = 90.0
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: height))
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Color.bg
        appearance.titleTextAttributes =  [NSAttributedString.Key.foregroundColor: Color.dark, NSAttributedString.Key.font: UIFont(name: Font.semi_bold.rawValue, size: 17)!]
        navbar.standardAppearance = appearance
        navbar.scrollEdgeAppearance = appearance
        
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.isTranslucent = true
        navbar.translatesAutoresizingMaskIntoConstraints = false

        navbar.delegate = self
        let navbarItem = UINavigationItem()
        navbarItem.title = "Create a folder"
        
        let exitButton = UIButton(frame: .zero)
        exitButton.setBackgroundImage(UIImage(systemName: "xmark",withConfiguration: UIImage.SymbolConfiguration(pointSize: 8,weight: .bold)), for: .normal)
        exitButton.tintColor = Color.dark
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        exitButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        navbarItem.leftBarButtonItem = UIBarButtonItem(customView: exitButton)
        
        
        navbar.items = [navbarItem]
        view.addSubview(navbar)

        
        NSLayoutConstraint.activate([
            exitButton.heightAnchor.constraint(equalToConstant: 24.0),
            exitButton.widthAnchor.constraint(equalToConstant: 24.0),
            
            navbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0),
            navbar.heightAnchor.constraint(equalToConstant: 50.0),
            navbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            folderTextField.topAnchor.constraint(equalTo: navbar.bottomAnchor, constant: 30),
            folderTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            folderTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            folderTextField.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    @objc func closeVC(){
        dismiss(animated: true, completion: nil)
    }
}
