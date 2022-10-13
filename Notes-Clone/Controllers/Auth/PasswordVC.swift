//
//  PasswordVC.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 09/10/2022.
//

import UIKit

class PasswordVC: UIViewController {

    let numberPadData = NumberPad.data
    var limitCount: Int = 0
    private var passCode: String = "" {
        didSet{
            showDoneButton()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        setupViews()
        setupContraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    // MARK: Properties -
    let backButton: UIButton = {
        var btn = UIButton()
        let image = UIImage(systemName: "arrow.left",withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold))
        btn.setBackgroundImage(image, for: .normal)
        btn.tintColor = Color.dark
        btn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let heading: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.text = "what's your password"
        l.font = UIFont(name: Font.bold.rawValue, size: 36)
        l.textColor = Color.dark
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    let avatarView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 60/2
        v.backgroundColor = Color.dark
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let avatarTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(name: Font.semi_bold.rawValue, size: 20)
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "ea".uppercased()
        return lb
    }()
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.spacing = 10
        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let image1: UIImageView = {
        let iv = PinImage(frame: .zero)
        return iv
    }()
    let image2: UIImageView = {
        let iv = PinImage(frame: .zero)
        return iv
    }()
    let image3: UIImageView = {
        let iv = PinImage(frame: .zero)
        return iv
    }()
    let image4: UIImageView = {
        let iv = PinImage(frame: .zero)
        return iv
    }()
  
    let doneButton: UIButton = {
        var btn = NButton()
        btn.setTitle("Done", for: .normal)
        btn.setTitleColor(Color.dark, for: .normal)
        btn.backgroundColor = .none
        btn.isHidden = true
        btn.alpha = 0
        btn.addTarget(self, action: #selector(didDoneTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var numPadCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 120, height: 90)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.setCollectionViewLayout(layout, animated: true)
        cv.register(NumberPadCell.self, forCellWithReuseIdentifier: NumberPadCell.reusableId)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = Color.pad_bg
        cv.allowsMultipleSelection = false
        cv.allowsSelection = true
        cv.bounces = false
        cv.layer.cornerRadius = 50
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
    @objc func didDoneTapped(){
        moveToFolderScreen(passcode: passCode)
    }
    func setupViews(){
        view.addSubview(backButton)
        view.addSubview(heading)
        view.addSubview(avatarView)
        avatarView.addSubview(avatarTitle)
        view.addSubview(numPadCollectionView)
        view.addSubview(stackView)
        view.addSubview(doneButton)
       
        for item in [image1,image2,image3,image4]{
            stackView.addArrangedSubview(item)
        }
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 25),
            backButton.widthAnchor.constraint(equalToConstant: 25),
            
            avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarView.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            avatarView.heightAnchor.constraint(equalToConstant: 60),
            avatarView.widthAnchor.constraint(equalToConstant: 60),

            avatarTitle.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarTitle.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            
            doneButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            doneButton.heightAnchor.constraint(equalToConstant: 20),
            doneButton.widthAnchor.constraint(equalToConstant: 50),

            heading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heading.topAnchor.constraint(equalTo: avatarView.bottomAnchor,constant: 50),
            heading.widthAnchor.constraint(equalToConstant: 300),
            
            stackView.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 50),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 160),
            stackView.heightAnchor.constraint(equalToConstant: 20),
           
            numPadCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            numPadCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            numPadCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            numPadCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func addNumber(number: String){
        passCode = passCode + number
    }
    private func moveToFolderScreen(passcode: String){
        let userDefaults = UserDefaults.standard
        if passcode.count == 4{
            userDefaults.setValue(true, forKey: "isLoggedIn")
            let vc = FolderVC()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    private func styleActivePasscode(){
        switch limitCount {
        case 1:
            image1.tintColor = Color.dark.withAlphaComponent(0.8)
            animateImage(imageView: image1)
        case 2:
            image2.tintColor = Color.dark.withAlphaComponent(0.8)
            animateImage(imageView: image2)
        case 3:
            image3.tintColor = Color.dark.withAlphaComponent(0.8)
            animateImage(imageView: image3)
        case 4:
            image4.tintColor = Color.dark.withAlphaComponent(0.8)
            animateImage(imageView: image4)
        default: break
        }
    }
    private func styleInActivePasscode(){
        switch limitCount {
        case 0:
            image1.tintColor = .systemGray4
            animateImage(imageView: image1)
        case 1:
            image2.tintColor = .systemGray4
            animateImage(imageView: image2)
        case 2:
            image3.tintColor = .systemGray4
            animateImage(imageView: image3)
        case 3:
            image4.tintColor = .systemGray4
            animateImage(imageView: image4)
        default: break
        }
    }
    private func animateImage(imageView: UIImageView){
        imageView.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
            imageView.transform = .identity
        }, completion: nil)
    }
    private func didTapBack(){
        if !passCode.isEmpty{
            passCode.removeLast()
            limitCount = limitCount - 1
            styleInActivePasscode()
        }
    }
    private func showDoneButton(){
        if passCode.count == 4{
            UIView.animate(withDuration: 0.5) {
                self.doneButton.isHidden = false
                self.doneButton.alpha = 1
            }
        }else {
            UIView.animate(withDuration: 0.2) {
                self.doneButton.alpha = 0
            }
        }
    }
}

extension PasswordVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberPadData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberPadCell.reusableId, for: indexPath) as! NumberPadCell
        cell.setupCell(for: numberPadData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 90)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = numberPadData[indexPath.row]
        switch indexPath.row {
        case 0,1,2,3,4,5,6,7,8,10:
            if limitCount < 4 {
                limitCount = limitCount + 1
                if let number = item.name{
                    addNumber(number: number)
                    print("Passcode: \(passCode)  LimitCount: \(limitCount)")
                    styleActivePasscode()
                }
            }
        case 11:
            didTapBack()
           
        default: break
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView.indexPathsForSelectedItems!.count <=  4 {
            return true
        }
        return false
    }
    
}
