//
//  ClosedDealsViewController.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 13/01/22.
//

import UIKit

class ClosedDealsViewController: UIViewController {
    
    var timer = Timer()
    
    @IBOutlet weak var myClosedDealsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMyClosedDeals()
        
        myClosedDealsCollectionView.delegate = self
        myClosedDealsCollectionView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func closeController(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    @objc func loadMyClosedDeals(){
        
        FirebaseData.sharedData.loadMyClosedDeals() {  error in
            
            if error != nil {
                
                print("Error geting Closed Deals from firebase")
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.loadMyClosedDeals), userInfo: nil, repeats: false)
                
            }else{
                print("----------------- \(FirebaseData.sharedData.myClosedDealsList.count)")
                self.myClosedDealsCollectionView.reloadData()
                
            }
            
        }
        
        
    }
    
    
}


extension ClosedDealsViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FirebaseData.sharedData.myClosedDealsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let item = FirebaseData.sharedData.myClosedDealsList[indexPath.row]
        
        let cell = myClosedDealsCollectionView.dequeueReusableCell(withReuseIdentifier: "MyClosedDealsCollectionViewCell", for: indexPath) as! ClosedDealCollectionViewCell
        
        if item.typeName != "Limpeza"{
            cell.jobDate.isHidden = true
            cell.time.isHidden = true
            cell.status.isHidden = true
            
        }
        
        cell.typeName.text = "Serviço: \(item.typeName ?? "")"
        cell.status.text = getStatus(status: item.status,jobDate:  item.jobDate)
        cell.address.text = "Endereço: \(item.completeAddress ?? "")"
        cell.professionalName.text = "Nome: \(item.professionalName ?? "")"
        
        var price: Float = 0.0
        if let priceTmp = Float(item.pricePayed ?? ""){
            price = priceTmp
        }
        
        cell.pricePayed.text = String(format: "Valor pago: R$ %.2f", price).replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
        
        cell.professionalCellphone.text = "Contato: \(item.professionalCellphone ?? "")"
        cell.jobDate.text = "Data: \(item.jobDate ?? "")"
        cell.discountPrice.text = "Desconto: \(item.discountPrice ?? "")"
        cell.time.text = "Horário: \(item.time ?? "")"
        cell.paymentInfo.text = "Pagamento: \(getPaymentStatus(paymentInfo: item.paymentInfo))"
        
        
        
        //    cell.time.text = "Horário: \(item.time ?? "")"
        
        
        cell.frame.size.width = myClosedDealsCollectionView.bounds.width
        
        
        return cell
    }
    
    func getStatus(status: String?, jobDate: String?) -> String {
        var newStatus = ""
        
        switch status {
            
        case K.ClosedDeals.OPEN:
            
            newStatus = initialStatus(jobDateOptional: jobDate)
            
        case K.ClosedDeals.CANCELLED_PROFESSIONAL_OPEN:
            newStatus = "Cancelado pelo profissional. Disputa aberta"
            
        case K.ClosedDeals.CANCELLED_PROFESSIONAL_CLOSED:
            newStatus = "Cancelado pelo profissional. Disputa concluída"
            
        case K.ClosedDeals.CANCELLED_CUSTOMER_OPEN:
            newStatus = "Cancelado pelo cliente. Disputa aberta"
            
        case K.ClosedDeals.CANCELLED_CUSTOMER_CLOSED:
            newStatus = "Cancelado pelo cliente. Disputa concluída"
            
        case K.ClosedDeals.EXECUTED:
            newStatus = "Trabalho realizado"
            
        case .none:
            newStatus = ""
            
        case .some(_):
            newStatus = ""
            
        }
        
        
        return newStatus
    }
    
    func getPaymentStatus(paymentInfo: String?) -> String {
        
        var newStatus: String = ""
        
        switch paymentInfo {
        case K.ClosedDeals.PAYED_BY_CUSTOMER:
            newStatus = "Pago"
            
        case K.ClosedDeals.WAITING_CONFIRMATION:
            newStatus = "Aguardando confirmação de pagamento"
            
        case K.ClosedDeals.REFUND_COMPLETE:
            newStatus = "Reembolso completo"
            
        case .none:
            newStatus = ""
            
        case .some(_):
            newStatus = ""
            
        }
        
        return newStatus
        
    }
    func initialStatus(jobDateOptional: String?) -> String{
        
        var initialStatus = ""
        
        if let jobDate = jobDateOptional {
            let date = Date.init()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            // let firstDate = formatter.date(from: date as Date)
            let secondDate = formatter.date(from: jobDate)
            
            if date.compare(secondDate!) == .orderedAscending {
                initialStatus = "Aberto"
            }else{
                initialStatus =  "Trabalho realizado"
            }
            
        }
        
        return initialStatus
    }
}

extension ClosedDealsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let itemWidth = myClosedDealsCollectionView.bounds.width
        
        return CGSize(width: itemWidth - 20, height: 180)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    
    
    
    
    
}

