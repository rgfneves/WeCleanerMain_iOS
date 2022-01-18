//
//  NewTicketViewController.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 13/01/22.
//

import UIKit

class MyTicketsViewController: UIViewController {
    
  //  var togleMenu: MenuTogleDelegate?
    var timer = Timer()
    var timer2 = Timer()

    @IBOutlet weak var myTicketsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMyTickets()
        loadOfferWithId()
        self.myTicketsCollectionView.delegate = self
        self.myTicketsCollectionView.dataSource = self
        
//        self.myTicketsCollectionView.register(UINib(nibName: "MyTicketsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyTicketsCollectionViewCell")
  
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func loadMyTickets(){
        
        FirebaseData.sharedData.loadMyTickets() {  error in
            
            if error != nil {
                
                print("Error geting Tickets from firebase")
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.loadMyTickets), userInfo: nil, repeats: false)
                
                
            }else{
                self.myTicketsCollectionView.reloadData()
               
            }
            
        }
        
        
    }
    
 
    @objc func loadOfferWithId(){
        
        FirebaseData.sharedData.loadMyOffersWithId() {  error in
            
            if error != nil{
                
                print("Error geting Offers from firebase")
                
                self.timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.loadOfferWithId), userInfo: nil, repeats: false)
                
                
            }else {
                self.timer2.invalidate()
                
                    
            }
        }
        
        
    }
    
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
   //     myTicketsCollectionView.frame.size.width = view.width
        
    }
    
    
    
    
}

// MARK: - UICollectionViewDataSource


// Extensão DATASOURCE serve apenas para retornar o número de células e carregar a view com o tipo de cell e dados
extension MyTicketsViewController: UICollectionViewDataSource {
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FirebaseData.sharedData.ticketList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let item = FirebaseData.sharedData.ticketList[indexPath.row]
        
        let cell = myTicketsCollectionView.dequeueReusableCell(withReuseIdentifier: "MyTicketsCollectionViewCell", for: indexPath) as! MyTicketsCollectionViewCell
        
        cell.contentView.isUserInteractionEnabled = false
        cell.delegate = self
        
        if item.typeName != "Limpeza"{
            cell.date.isHidden = true
            cell.time.isHidden = true

        }
        
        let curStatus = item.status
     
        if (curStatus == "FECHADO"){

            cell.offers.isHidden = true
            cell.status.textColor  = UIColor.gray
            cell.status.text = "Fechado"
            cell.delButtonImage.isHidden = true
            cell.seeMoreImage.isHidden = true
            cell.closedDealImage.isHidden = false


        } else if (curStatus == "CANCELADO"){

            cell.offers.isHidden = true
            cell.status.textColor  = UIColor.gray
            cell.status.text = "Cancelado"
            cell.delButtonImage.isHidden = true
            cell.seeMoreImage.isHidden = true
            cell.closedDealImage.isHidden = true


        }else if (curStatus == "EXPIRADO"){

            cell.offers.isHidden = true
            cell.status.textColor  = UIColor.gray
            cell.status.text = "Expirado"
            cell.delButtonImage.isHidden = true
            cell.seeMoreImage.isHidden = true
            cell.closedDealImage.isHidden = true

        }else {

            cell.offers.isHidden = false
            cell.status.textColor  = UIColor.blue
            cell.status.text = "Aberto"
            cell.delButtonImage.isHidden = false
            cell.seeMoreImage.isHidden = false
            cell.closedDealImage.isHidden = true


        }

        var offersQuant = 0
        
        FirebaseData.sharedData.myOfferList.forEach{ offer in
            
            if offer.ticketId == item.id {
                offersQuant += 1
            }
            
            
        }
        
        
        if offersQuant > 0 {
            cell.seeMoreImage.isHidden = true
        }

       
        cell.time.text = "Horário: \(item.time ?? "")"
        cell.adress.text = "Endereço: \(item.address ?? "")"
        cell.offers.text = "Ofertas: \(offersQuant)"
        cell.date.text = "Data: \(item.jobDate ?? "")"
        cell.typeName.text = "Serviço: \(item.typeName ?? "")"
        cell.status.text = "\(item.status ?? "")"
        cell.frame.size.width = myTicketsCollectionView.bounds.width
    
        
        return cell
    }
    
}

extension MyTicketsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let itemWidth = myTicketsCollectionView.bounds.width
        let itemHeight = myTicketsCollectionView.bounds.height
        
       
        return CGSize(width: itemWidth - 20, height: 180)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    


    
    
}

extension MyTicketsViewController : MyTicketsButtonsDelegate {
    
    
    func myTicketsListTableViewCell(_ myTicketsListTableViewCell: MyTicketsCollectionViewCell, seeMoreImageActionFor item: String){
        print("se more")
        
    }
    
    func myTicketsListTableViewCell(_ myTicketsListTableViewCell: MyTicketsCollectionViewCell, delButtonImageActionFor item: String){
        print("del bt")
    }
    
    
    
}
