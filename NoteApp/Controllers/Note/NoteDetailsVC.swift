//
//  NoteDetailsVC.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 09/10/2022.
//

import UIKit

protocol SaveNoteDelegate: AnyObject {
    func saveNote(isSaved: Bool)
}

class NoteDetailsVC: UIViewController {
    var scrollViewHeight:  NSLayoutConstraint?
    let dateFormatter = DateFormatter()
    let starredBtn = UIButton(type: .system)
    var isStarredNote: Bool = false {
        didSet{
            toggleStarredBtn()
        }
    }
    var headingTextHeightConstraint: NSLayoutConstraint!
    var bodyTextHeightConstraint: NSLayoutConstraint!
    var folder: Folder? {
        didSet{
           
            dateFormatter.dateFormat = "dd/MM/YYYY"
            guard let category = folder?.category else { return }
            guard let date = folder?.createdAt else { return }
            
            categoryLabel.text = category
            dateLabel.text = "\(dateFormatter.string(from: date))"
        }
    }
    var note: Note? {
        didSet{
            guard let noteObject = note else { return }
            guard let date = noteObject.createdAt else { return }
            
            dateLabel.text = "Created \(date.timeAgoDisplayNative())"
            headingTextView.text = note?.heading ?? ""
            bodyTextView.text = note?.body ?? ""
        }
    }
    
    var viewModel = NoteViewModel()
    var delegate: SaveNoteDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        headingTextView.delegate = self
        bodyTextView.delegate = self
        setupViews()
        setupConstraints()
        configureBackButton()
        configureNavBar()
        disableButton()
        headingTextView.becomeFirstResponder()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        headingTextView.text = ""
        bodyTextView.text = ""
        note = nil
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    var mainScrollView : UIScrollView = {
        var sv = UIScrollView()
        sv.showsVerticalScrollIndicator = true
        sv.bounces = true
        sv.alwaysBounceVertical = true
        sv.backgroundColor = .clear
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    // MARK: Properties -
    let categoryLabel: UILabel = {
        let lb = UILabel()
        lb.text = "💰 Savings"
        lb.font = UIFont(name: Font.semi_bold.rawValue, size: 15)
        lb.textColor = .systemGray2
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let dateLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: Font.semi_bold.rawValue, size: 15)
        lb.textColor = .systemGray2
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let dotIcon : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(systemName: "circle.fill")
        iv.tintColor = .systemGray2
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let headingTextView: UITextView = {
        var tf = UITextView()
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.backgroundColor = .clear
        tf.isScrollEnabled = false
        tf.showsVerticalScrollIndicator = false
        tf.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue, .font:  UIFont(name: Font.semi_bold.rawValue, size: 30)!]
        tf.textColor = Color.dark.withAlphaComponent(0.8)
        tf.font = UIFont(name: Font.semi_bold.rawValue, size: 40)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let bodyTextView: UITextView = {
        var tf = UITextView()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        let attributes = [
            NSAttributedString.Key.paragraphStyle: style,
            NSAttributedString.Key.foregroundColor: Color.dark.withAlphaComponent(0.8),
            NSAttributedString.Key.font: UIFont(name: Font.medium.rawValue, size: 15)!
        ]
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.backgroundColor = .clear
        tf.isScrollEnabled = false
        tf.showsVerticalScrollIndicator = false
        tf.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue, .font:  UIFont(name: Font.medium.rawValue, size: 15)!]
        tf.textColor = Color.text_color_normal
            .withAlphaComponent(0.8)
        tf.typingAttributes = attributes
        tf.font = UIFont(name: Font.medium.rawValue, size: 15)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let saveBtn: UIButton = {
        var btn = NButton()
        btn.layer.cornerRadius = 52/2
        btn.titleLabel?.textColor = .white
        btn.setTitle("Save", for: .normal)
        btn.backgroundColor = Color.cell_dark_bg
        btn.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
   
   // MARK: Functions -
    @objc func saveNote(){
        guard let folder = folder else { return }
        if note != nil {
            updateNote()  // if note exists, update it
        }
        else {
            viewModel.addNote(folder: folder, heading: headingTextView.text, body: bodyTextView.text)
            delegate?.saveNote(isSaved: true)
            navigationController?.popViewController(animated: true)
        }
       
    }
   
    func updateNote(){
        guard let note = note else { return }
        viewModel.updateNote(note: note, heading: headingTextView.text, body: bodyTextView.text, lastUpdated: Date())
        delegate?.saveNote(isSaved: true)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func starFavoriteNote(){
        guard let _ = folder else { return }
        isStarredNote = !isStarredNote
    }
    
    func setupViews(){
        view.addSubview(mainScrollView)
        view.addSubview(saveBtn)
        mainScrollView.addSubview(container)
        [categoryLabel,dotIcon,dateLabel,headingTextView,bodyTextView].forEach{
            container.addSubview($0)
        }
    }
    
    func setupConstraints(){
        mainScrollView.pin(to: view)
        container.pinToEdges(to: mainScrollView)
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor),
            container.heightAnchor.constraint(equalTo: mainScrollView.heightAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            categoryLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            
            dotIcon.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
            dotIcon.leadingAnchor.constraint(equalTo: categoryLabel.trailingAnchor, constant: 12),
            dotIcon.widthAnchor.constraint(equalToConstant: 7),
            dotIcon.heightAnchor.constraint(equalToConstant: 7),
            
            dateLabel.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: dotIcon.leadingAnchor, constant: 20),
            
            headingTextView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20),
            headingTextView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            headingTextView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            
            bodyTextView.topAnchor.constraint(equalTo: headingTextView.bottomAnchor, constant: 5),
            bodyTextView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            bodyTextView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            bodyTextView.heightAnchor.constraint(equalTo: container.heightAnchor),
            
            saveBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            saveBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            saveBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            saveBtn.heightAnchor.constraint(equalToConstant: 52),
            
        ])
        guard let headingText = headingTextView.text else { return }
        guard let _ = bodyTextView.text else { return }
        let headingItemSize = headingText.size(withAttributes: [NSAttributedString.Key.font:UIFont(name: Font.semi_bold.rawValue, size: 100)!])
        self.headingTextHeightConstraint = headingTextView.heightAnchor.constraint(equalToConstant: headingItemSize.height)
        self.headingTextHeightConstraint.isActive = true
        
//        let bodyItemSize = bodyText.size(withAttributes: [NSAttributedString.Key.font:UIFont(name: Font.medium.rawValue, size: 20)!])
//        self.bodyTextHeightConstraint = bodyTextView.heightAnchor.constraint(equalToConstant: bodyItemSize.height)
//        self.bodyTextHeightConstraint.isActive = true
    }
    
    func disableButton(){
        guard let heading = headingTextView.text else { return }
        guard let body = bodyTextView.text else { return }
        if !heading.isEmpty || !body.isEmpty{
            saveBtn.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.2) {
                self.saveBtn.alpha = 1
            }
        } else {
            saveBtn.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.2) {
                self.saveBtn.alpha = 0.8
            }
        }
    }
}
        

extension NoteDetailsVC {
    func configureNavBar(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.semi_bold.rawValue, size: 16.0)!,NSAttributedString.Key.foregroundColor: Color.dark]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.bold.rawValue, size: 28.0)!,NSAttributedString.Key.foregroundColor: Color.dark]
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
             
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
       
        let image = UIImage(named: "save-outline")?.withRenderingMode(.alwaysTemplate)
        starredBtn.setImage(image, for: .normal)
        starredBtn.tintColor = Color.dark
        starredBtn.adjustsImageWhenHighlighted = false
        starredBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
        starredBtn.addTarget(self, action: #selector(starFavoriteNote), for: .touchUpInside)
        starredBtn.backgroundColor = .clear
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: starredBtn)
        
        let rightBarItem = UIBarButtonItem()
        rightBarItem.customView = starredBtn
        navigationItem.setRightBarButtonItems([rightBarItem], animated: true)
    }
    func configureBackButton(){
        let backImage =  UIImage(systemName: "arrow.left",withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .medium))
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: .none, action: .none)
        navigationController?.navigationBar.tintColor = Color.dark
    }
}

extension NoteDetailsVC: UITextViewDelegate {
    func adjustHeadingTextViewHeight() {
        let fixedWidth = headingTextView.frame.size.width
        let newSize = headingTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        self.headingTextHeightConstraint.constant = newSize.height
        self.view.layoutIfNeeded()
    }
    func adjustBodyTextViewHeight() {
        let fixedWidth = bodyTextView.frame.size.width
        let newSize = bodyTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        self.bodyTextHeightConstraint.constant = newSize.height
        self.view.layoutIfNeeded()
    }
    func textViewDidChange(_ textView: UITextView) {
        self.adjustHeadingTextViewHeight()
//        self.adjustBodyTextViewHeight()
    }
}

extension NoteDetailsVC {
    func textViewDidChangeSelection(_ textView: UITextView) {
        guard let headingText = headingTextView.text else { return }
        if headingText.isEmpty {
            saveBtn.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.2) {
                self.saveBtn.alpha = 0.8
            }
        }
        else {
            saveBtn.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.2) {
                self.saveBtn.alpha = 1
            }
        }
    }
}
extension NoteDetailsVC {
    func toggleStarredBtn(){
        if isStarredNote{
            starredBtn.setImage(UIImage(named: "save-bold")?.withRenderingMode(.alwaysTemplate), for: .normal)
            starredBtn.tintColor = Color.red
            animateButton(btn: starredBtn)
        }else{
            starredBtn.setImage(UIImage(named: "save-outline")?.withRenderingMode(.alwaysTemplate), for: .normal)
            starredBtn.tintColor = Color.dark
            animateButton(btn: starredBtn)
        }
    }
    private func animateButton(btn: UIButton){
        btn.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, options: .curveEaseIn, animations: {
            btn.transform = .identity
        }, completion: nil)
    }
}
