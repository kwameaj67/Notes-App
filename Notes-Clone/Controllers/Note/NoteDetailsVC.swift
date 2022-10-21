//
//  NoteDetailsVC.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 09/10/2022.
//

import UIKit

class NoteDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.bg
        setupViews()
        setupConstraints()
        configureBackButton()
    }
    
    func setupViews(){
        
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            
        ])
    }
}


extension NoteDetailsVC {
    func configureNavBar(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.semi_bold.rawValue, size: 16.0)!,NSAttributedString.Key.foregroundColor: Color.dark]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Font.bold.rawValue, size: 28.0)!,NSAttributedString.Key.foregroundColor: Color.dark]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
             
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
//        let searchBtn = UIButton(type: .system)
//        let image = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
//        searchBtn.setImage(image, for: .normal)
//        searchBtn.tintColor = Color.dark
//        searchBtn.adjustsImageWhenHighlighted = false
//        searchBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
//        searchBtn.backgroundColor = .clear
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBtn)
//        
//        let rightBarItem = UIBarButtonItem()
//        rightBarItem.customView = searchBtn
//        navigationItem.setRightBarButtonItems([rightBarItem], animated: true)
    }
    func configureBackButton(){
        let backImage =  UIImage(systemName: "arrow.left",withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .medium))
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: .none, action: .none)
        navigationController?.navigationBar.tintColor = Color.dark
    }
}
