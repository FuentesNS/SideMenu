//
//  HomeViewController.swift
//  SideMenuSFuentes
//
//  Created by MacBookMBA1 on 14/11/22.
//

import UIKit


protocol HomeViewControllerDelegate: AnyObject{
    func didTapMenuButton()
}

class HomeViewController: UIViewController {

    weak var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Home"
        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(didTapMenuButton))
    }
    

    @objc func didTapMenuButton(){
        delegate?.didTapMenuButton()
    }

}
