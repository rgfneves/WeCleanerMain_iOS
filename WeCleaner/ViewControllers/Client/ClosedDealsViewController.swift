//
//  ClosedDealsViewController.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 13/01/22.
//

import UIKit

class ClosedDealsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func closeController(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        //togleMenu?.togleMenu()
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
