//
//  UserNameVC.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 09/10/2022.
//

import UIKit

class NameVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        setupViews()
        setupContraints()
//        configureBackButton()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        addToolBarToFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Properties -
    let scrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        sv.bounces = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let heading: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.text = "what's your name"
        l.font = UIFont(name: Font.bold.rawValue, size: 36)
        l.textColor = Color.dark
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    let inputStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 15
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let firstNameField: UITextField = {
        var tf = NTextField()
        tf.attributedPlaceholder = NSAttributedString(string: "First name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4,NSAttributedString.Key.font: UIFont(name: Font.regular.rawValue, size: 14)!])
        return tf
    }()
    let lastNameField: UITextField = {
        var tf = NTextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Last name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4,NSAttributedString.Key.font: UIFont(name: Font.regular.rawValue, size: 14)!])
        return tf
    }()
    func createToolBar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let space1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let space2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: nil, action: #selector(onDone))
        done.tintColor = Color.dark
        toolbar.setItems([space1,space2,done], animated: true)
        return toolbar
    }
    func addToolBarToFields(){
        [firstNameField,lastNameField].forEach {
            $0.inputAccessoryView = createToolBar()
        }
    }
    let continueButton: UIButton = {
        var btn = NButton()
        let image = UIImage(systemName: "arrowtriangle.right.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 10, weight: .semibold))
        btn.setTitle("Continue", for: .normal)
        btn.layer.cornerRadius = 52/2
        btn.setImage(image, for: .normal)
        btn.tintColor = .white
        btn.semanticContentAttribute = .forceRightToLeft
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    @objc func buttonTapped(){
        let vc = PasswordVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func onDone(){
        if firstNameField.isEditing{
            firstNameField.resignFirstResponder()
        }
        if lastNameField.isEditing{
            lastNameField.resignFirstResponder()
        }
    }
    
    func configureBackButton(){
        let backImage =  UIImage(systemName: "arrow.left",withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold))
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: .none, action: .none)
        navigationController?.navigationBar.tintColor = Color.dark
    }
    func setupViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(container)
        container.addSubview(heading)
        container.addSubview(inputStack)
        [firstNameField,lastNameField].forEach{
            inputStack.addArrangedSubview($0)
        }
        container.addSubview(continueButton)
    }
    
    func setupContraints(){
        scrollView.pin(to: view)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: scrollView.topAnchor),
            container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            container.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            container.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            
            heading.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            heading.topAnchor.constraint(equalTo: container.topAnchor,constant: 80),
            heading.widthAnchor.constraint(equalToConstant: 300),
            
            inputStack.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 50),
            inputStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 50),
            inputStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -50),
            
            firstNameField.heightAnchor.constraint(equalToConstant: 52),
            lastNameField.heightAnchor.constraint(equalToConstant: 52),
            
            continueButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            continueButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30),
            continueButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -30),
            continueButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
}
