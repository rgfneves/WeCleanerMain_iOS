//
//  ContainerViewController.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 13/01/22.
//

import UIKit

class ContainerClientViewController: UIViewController {
    

    
    
    var menuController: MenuClientController!
    var centerController: UIViewController!
    var isExpanded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
      
       

        // Do any additional setup after loading the view.
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.view.addGestureRecognizer(gesture)

    
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        if(isExpanded){
            configMenuController()
            isExpanded = false
            showMenuController(shouldExpand: isExpanded)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func configureHomeController(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let homeController = storyboard.instantiateViewController(identifier: "ClientHomeViewController")
                                            as? ClientHomeViewController {
  
        homeController.togleMenu = self
        centerController = UINavigationController(rootViewController: homeController)
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
            
        }
        
 
    }
    
    func setNewController(controllerId: String){
        
       // menuController = nil
        isExpanded = !isExpanded
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0,options: .curveEaseInOut, animations: {
            self.centerController.view.frame.origin.x = 0
        }, completion: {(success: Bool) -> Void in
            self.presentNewController(controllerId: controllerId)
            
        })
        
        
    }
    func presentNewController(controllerId: String){
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        if let homeController = storyboard.instantiateViewController(identifier: controllerId)
                                            as? UIViewController {
            
         let newController = UINavigationController(rootViewController: homeController)
            newController.modalPresentationStyle = .fullScreen
            self.present(newController, animated: true, completion: nil)


        }
    }



    
    
    func configMenuController(){
        if menuController == nil{
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            if let menuController2 = storyboard.instantiateViewController(identifier: "MenuClientController")
                                                as? MenuClientController {
            menuController = menuController2
            menuController.newControllerDelegate = self
                menuController.menuTogleDelegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
                
            }
        }
    }
    
    
    func showMenuController(shouldExpand: Bool){
        if shouldExpand {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0,options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 100
            }, completion: nil)
        }else{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0,options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }, completion: nil)
        }
    }

}

extension ContainerClientViewController: MenuTogleDelegate {
    
    func togleMenu() {
  
        configMenuController()
        isExpanded = !isExpanded
        showMenuController(shouldExpand: isExpanded)
    }
    

}
extension ContainerClientViewController: NewControllerFromMenu {
    
    func loadNewController(controllerId: String) {

        setNewController(controllerId: controllerId)
 
        
    }
    

}
