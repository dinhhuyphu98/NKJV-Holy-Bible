//
//  HomeBooksCollectionViewCell.swift
//  NKJV Holy Bible
//
//  Created by ĐINH HUY PHU on 09/11/2021.
//

import UIKit

class HomeBooksCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var BtnSeeAll: UIButton!
    var List1Books:[BooksModel] = [BooksModel]()
    var DataBooksContent1 : [verse_nkjv_contentModel] = [verse_nkjv_contentModel]()
    @IBOutlet weak var ColorView: UIView!
    @IBOutlet weak var Categorybook: UILabel!
    var S1name = ["Gen","Exo","Lev","Num","Deu","Jos","Jdg","Rth","1Sa","2Sa","1Ki","2Ki","1Ch","2Ch","Ezr","Neh","Est","Job","Psa","Pro","Ecc","Son","Isa","Jer","Lam","Eze","Dan","Hos","Joe","Amo","Oba","Jon","Mic","Nah","Hab","Zep","Hag","Zec","Mal"]
    var listCount: [Int] = [Int]()
    @IBOutlet weak var  itembookCollectionView : UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        itembookCollectionView.register(UINib(nibName: bookitemCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: bookitemCollectionViewCell.className)
        ColorView.layer.cornerRadius = 20
        BtnSeeAll.setTitle("SeeAll", for: .normal)
        BtnSeeAll.setTitleColor(.init(red: 0, green: 197, blue: 211, alpha: 1), for: .normal)
    }
    func getVersesByBookNumber(listData: [BooksModel], index: Int) -> [verse_nkjv_contentModel] {
        var listVerseByBook: [verse_nkjv_contentModel] = [verse_nkjv_contentModel]()
        for item in DataBooksContent1 {
            if item.c1book_id == listData[index].BookID {
                listVerseByBook.append(item)
            }
        }
        return listVerseByBook
    }
    @IBAction func Next(_ sender: Any) {
        if let parentVC = self.parentViewController  as? MainViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SeeAllViewController") as! SeeAllViewController
            vc.Name = "Old testament"
            vc.DataBooksContentSeeAll = DataBooksContent1
            vc.ImageColor = UIImage.init(named: "iconbook")
            vc.ArrayNameBook = S1name
            vc.IntSeeall1 = 39
//            vc.bookIDSeAll = List1Books[indexPath.row].BookID
            vc.modalPresentationStyle = .fullScreen
            parentVC.present(vc, animated: true)
            
        }

    }
}
extension HomeBooksCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return List1Books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bookitemCollectionViewCell.className, for: indexPath) as! bookitemCollectionViewCell
        cell.Namebook.text = List1Books[indexPath.row].EnName + " (\(List1Books[indexPath.row].ChapterCount))"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let parentVC = self.parentViewController  as? MainViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ListchapterViewController") as! ListchapterViewController
            vc.NumberChapter = List1Books[indexPath.row].ChapterCount
            vc.Name = List1Books[indexPath.row].EnName
            let listVersesByBook = getVersesByBookNumber(listData: List1Books, index: indexPath.item)
            vc.listDataVerse = listVersesByBook
            vc.SNamebook = S1name[indexPath.item]
            vc.bookID = List1Books[indexPath.row].BookID
            vc.modalPresentationStyle = .fullScreen
            parentVC.present(vc, animated: true)
            
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        return UICollectionReusableView()
    }
    
}

extension HomeBooksCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: 150, height: 100)
        }
        return CGSize(width:  150, height: 100)
    }
}
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
