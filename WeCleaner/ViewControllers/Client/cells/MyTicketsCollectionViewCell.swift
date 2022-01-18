//
//  MyTicketsCollectionViewCell.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 17/01/22.
//

import UIKit

class MyTicketsCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var closedDealImage: UIButton!
    @IBOutlet weak var seeMoreImage: UIButton!
    @IBOutlet weak var delButtonImage: UIButton!
    
    
    @IBOutlet weak var outsideViewForCard3: UIView!
    
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var date: UILabel!

    @IBOutlet weak var typeName: UILabel!
    
    @IBOutlet weak var offers: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    weak var delegate : MyTicketsButtonsDelegate?
    
    var item = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        outsideViewForCard3 = MyTransformations.makeCardFromView(myViewR: outsideViewForCard3)
        
        outsideViewForCard3.clipsToBounds = false
       
        self.contentView.isUserInteractionEnabled = false
        

        seeMoreImage.addTarget(self, action: #selector(self.seeMoreImageAction(_:)), for: .touchUpInside)
        
        
        delButtonImage.addTarget(self, action: #selector(self.delButtonImageAction(_:)), for: .touchUpInside)

        
    }
    
    @IBAction func seeMoreImageAction(_ sender: UIButton) {
        print("actionOK")
        self.delegate?.myTicketsListTableViewCell(self, seeMoreImageActionFor: item )
    }
    

    @IBAction func delButtonImageAction(_ sender: UIButton) {
        self.delegate?.myTicketsListTableViewCell(self, delButtonImageActionFor: item )
    }

    
}

// Only class object can conform to this protocol (struct/enum can't)
protocol MyTicketsButtonsDelegate: AnyObject {
    
    func myTicketsListTableViewCell(_ myTicketsListTableViewCell: MyTicketsCollectionViewCell, seeMoreImageActionFor item: String)
    
    func myTicketsListTableViewCell(_ myTicketsListTableViewCell: MyTicketsCollectionViewCell, delButtonImageActionFor item: String)
    
}
