//
//  ViewController.swift
//  SideMenuSFuentes
//
//  Created by MacBookMBA1 on 14/11/22.
//

import UIKit

class ContainerViewController: UIViewController {

    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    var navVC: UINavigationController?
    lazy var infoVC = InfoViewController()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        addChildVCs()
    }

    private func addChildVCs(){
        
        //Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        //Home
        homeVC.delegate = self
        let navVc = UINavigationController(rootViewController: homeVC)
        addChild(navVc)
        view.addSubview(navVc.view)
        navVc.didMove(toParent: self)
        
        
    }

}

extension ContainerViewController: HomeViewControllerDelegate{
    func didTapMenuButton() {
        toggleMenu(completion: nil)
        
    }
    
    func toggleMenu(completion: (() -> Void)?){
        //animate menu
        switch menuState{
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut){
                
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
            } completion: {  [weak self] done in
                if done{
                    self?.menuState = .opened

                }
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut){
                
                self.navVC?.view.frame.origin.x = 0
            } completion: {  [weak self] done in
                if done{
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}



extension ContainerViewController: MenuViewControllerDelegate{
    
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        
        toggleMenu (completion: nil)
        switch menuItem{
        case .home:
            self.restToHome()
        case .info:
            self.addInfo()
            
        case .appRating:
            break
        case .shareApp:
            break
        case .settings:
            break
        }
    }
    
    func addInfo(){
        let vc = infoVC
        
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        homeVC.didMove(toParent: self)
        homeVC.title = vc.title
    }
    
    func restToHome(){
        let vc = infoVC
        
        
        infoVC.view.removeFromSuperview()
        infoVC.didMove(toParent: nil)
        homeVC.title = "Home"
        
    }
}
