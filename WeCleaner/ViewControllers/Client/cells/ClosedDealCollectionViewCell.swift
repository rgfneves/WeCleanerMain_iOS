//
//  ClosedDealCollectionViewCell.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 18/01/22.
//

import UIKit




class ClosedDealCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var typeName: UILabel!
    
    @IBOutlet weak var outsideView: UIView!
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var paymentInfo: UILabel!
    @IBOutlet weak var professionalCellphone: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var pricePayed: UILabel!
    @IBOutlet weak var professionalName: UILabel!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var jobDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        outsideView = MyTransformations.makeCardFromView(myViewR: outsideView)
        

       
    }
    
    
}
