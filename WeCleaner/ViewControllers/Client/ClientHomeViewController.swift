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
    
    
  //  @IBOutlet weak var scrollView: UIScrollView!
    var imgArr = ["https://firebasestorage.googleapis.com/v0/b/wecleaner-87c5e.appspot.com/o/profile%2Fa0e5eabc-ab09-423e-969f-73ca5ff3a0f9?alt=media&token=140ffc80-e636-4c30-9e88-dbe1099e2e69",
                  "https://firebasestorage.googleapis.com/v0/b/wecleaner-87c5e.appspot.com/o/profile%2Fa0e5eabc-ab09-423e-969f-73ca5ff3a0f9?alt=media&token=140ffc80-e636-4c30-9e88-dbe1099e2e69"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sliderCollectionView.dataSource = self
        self.sliderCollectionView.delegate = self
        
       
        
        //        sliderSup.sd_imageTransition = .fade
        //        sliderSup.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/wecleaner-87c5e.appspot.com/o/profile%2Fa0e5eabc-ab09-423e-969f-73ca5ff3a0f9?alt=media&token=140ffc80-e636-4c30-9e88-dbe1099e2e69"), placeholderImage: nil)
        //        sliderSup.clipsToBounds = true
        //  sliderSup.frame = CGRect(x: sliderSup.frame.origin.x, y: sliderSup.frame.origin.y, width: sliderSup.frame.size.width, height: view.frame.width*0.45);
        //
        //        var rect = sliderSup.frame
        //        rect.size.height = view.frame.width*0.45
        //        sliderSup.frame = rect
        
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
   
        self.sliderCollectionView.frame.size.height = view.frame.width*0.47
    
        self.pageControlCircles.frame.origin.y = self.sliderCollectionView.frame.maxY
      
        self.stackViewNewTicket.frame.origin.y = self.pageControlCircles.frame.maxY
      
   //     self.scrollView.frame.origin.y = self.pageControlCircles.frame.maxY
        
      //  self.scrollView.frame.size.y = view.frame.
      
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
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControlCircles.numberOfPages = imgArr.count
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.sd_setImage(with: URL(string: imgArr[indexPath.row]), placeholderImage: nil)
            vc.clipsToBounds = true
     
            
        }
        
        return cell
        
        
    }
    
}

extension ClientHomeViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(
//        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//
//            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//
//        }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      //  print(indexPath.row)
        pageControlCircles.currentPage = indexPath.row
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        
    }
    
    
    
    
    
}




