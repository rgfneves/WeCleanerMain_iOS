//
//  MenuClientController.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 13/01/22.
//

import UIKit

class MenuClientController: UIViewController {
    
    var newControllerDelegate: NewControllerFromMenu?
    var menuTogleDelegate:MenuTogleDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.view.addGestureRecognizer(gesture)

    
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        menuTogleDelegate?.togleMenu()
    }
    
    @IBAction func showClosedDeals(_ sender: UIButton) {
        newControllerDelegate?.loadNewController(controllerId: "ClosedDealsViewController")
    }
    
    @IBAction func showNewController(_ sender: UIButton) {
        newControllerDelegate?.loadNewController(controllerId: "MyTicketsViewController")
     // 
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
