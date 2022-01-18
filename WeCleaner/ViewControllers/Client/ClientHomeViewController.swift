//
//  HomeViewController.swift
//  WeCleaner
//
//  Created by Rafael Gomes Ferreira Neves on 12/01/22.
//

import UIKit


class ClientHomeViewController: UIViewController {
    
    @IBOutlet weak var stackViewNewTicket: UIStackView!
    var togleMenu: MenuTogleDelegate?
    
    @IBOutlet weak var pageControlCircles: UIPageControl!
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    @IBOutlet weak var sliderInfCollectionView: UICollectionView!
    
    @IBOutlet weak var partnerCollectionView: UICollectionView!
    //  @IBOutlet weak var scrollView: UIScrollView!
    var imgArr = ["https://firebasestorage.googleapis.com/v0/b/wecleaner-87c5e.appspot.com/o/profile%2Fa0e5eabc-ab09-423e-969f-73ca5ff3a0f9?alt=media&token=140ffc80-e636-4c30-9e88-dbe1099e2e69",
                  "https://firebasestorage.googleapis.com/v0/b/wecleaner-87c5e.appspot.com/o/profile%2Fa0e5eabc-ab09-423e-969f-73ca5ff3a0f9?alt=media&token=140ffc80-e636-4c30-9e88-dbe1099e2e69"]

    var timer = Timer()
    var counter = 0
    var timerInf = Timer()
    var counterInf = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sliderCollectionView.dataSource = self
        self.sliderCollectionView.delegate = self
        self.sliderInfCollectionView.dataSource = self
        self.sliderInfCollectionView.delegate = self
        self.partnerCollectionView.dataSource = self
        self.partnerCollectionView.delegate = self
        
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
        timerInf = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(changeImageInf), userInfo: nil, repeats: true)
        
    }
    
    @objc func changeImageInf(){
        if counterInf < imgArr.count{
            let index = IndexPath.init(item: counterInf, section: 0)
            sliderInfCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            counterInf += 1
        }else{
            counterInf = 0
            let index = IndexPath.init(item: counterInf, section: 0)
            sliderInfCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            counterInf += 1
        }
        
    }
    
    @objc func changeImage(){
        if counter < imgArr.count{
            let index = IndexPath.init(item: counter, section: 0)
            sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            counter += 1
        }else{
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            counter += 1
        }
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
   
        self.sliderCollectionView.frame.size.height = view.frame.width*0.47
    
        self.pageControlCircles.frame.origin.y = self.sliderCollectionView.frame.maxY
      
        self.stackViewNewTicket.frame.origin.y = self.pageControlCircles.frame.maxY
       
        self.sliderInfCollectionView.frame.size.height = view.frame.width*0.3
        
        self.sliderInfCollectionView.frame.origin.y = view.frame.maxY - self.sliderInfCollectionView.frame.size.height
        
         self.partnerCollectionView.frame.origin.y = self.stackViewNewTicket.frame.origin.y + self.stackViewNewTicket.frame.height + 5
         self.partnerCollectionView.frame.size.height = self.sliderInfCollectionView.frame.origin.y -  self.partnerCollectionView.frame.origin.y - 10
      
    }
    
    @IBAction func openNewTicket(_ sender: UIButton) {

    }
    @IBAction func togleMenu(_ sender: UIBarButtonItem) {
        togleMenu?.togleMenu()
    }
    

    
}


// MARK: - UICollectionViewDataSource


// Extensão DATASOURCE serve apenas para retornar o número de células e carregar a view com o tipo de cell e dados
extension ClientHomeViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, layout
    collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
    
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControlCircles.numberOfPages = imgArr.count
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if collectionView == sliderCollectionView {
       
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.sd_setImage(with: URL(string: imgArr[indexPath.row]), placeholderImage: nil)
            vc.clipsToBounds = true
        }
            
        }else if collectionView == sliderInfCollectionView{
            
            if let vc = cell.viewWithTag(112) as? UIImageView {
                vc.sd_setImage(with: URL(string: imgArr[indexPath.row]), placeholderImage: nil)
                vc.clipsToBounds = true
            }
            
        }else if collectionView == partnerCollectionView{
            
            if let vc = cell.viewWithTag(113) as? UIImageView {
                vc.sd_setImage(with: URL(string: imgArr[indexPath.row]), placeholderImage: nil)
                vc.clipsToBounds = true
            }
            
        }
        
        return cell
        
        
    }
    
}

extension ClientHomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      //  print(indexPath.row)
        pageControlCircles.currentPage = indexPath.row
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        
        if collectionView == partnerCollectionView{
        let padding: CGFloat =  25
          let collectionViewSize = collectionView.frame.size.width - padding
          return CGSize(width: collectionViewSize/2, height: 115)
        }
        
        return CGSize(width: itemWidth, height: itemHeight)
}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        
    }
    
    
    
    
    
}




