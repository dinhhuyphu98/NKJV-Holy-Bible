//
//  HomeBooks2CollectionViewCell.swift
//  NKJV Holy Bible
//
//  Created by ĐINH HUY PHU on 09/11/2021.
//

import UIKit

class HomeBooks2CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var SeeAllbtn: UIButton!
    @IBOutlet weak var ColorView: UIView!
    var DataBooksContent2 : [verse_nkjv_contentModel] = [verse_nkjv_contentModel]()
    var listDataVerse : [verse_nkjv_contentModel] = [verse_nkjv_contentModel]()
    var List2Books:[BooksModel] = [BooksModel]()
    var listCount: [Int] = [Int]()
    var S2name = ["Mat","Mar","Luk","Joh","Act","Rom","1Co","2Co","Gal","Eph","Php","Col","1Th","2Th","1Ti","2Ti","Tts","Phm","Heb","Jam","1Pe","2Pe","1Jo","2Jo","3Jo","Jde","Rev"]
    @IBOutlet weak var Categorybook: UILabel!
    @IBOutlet weak var  itembookCollectionView : UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        itembookCollectionView.register(UINib(nibName: bookitem2CollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: bookitem2CollectionViewCell.className)
        ColorView.layer.cornerRadius = 24
        SeeAllbtn.setTitle("See All", for: .normal)
        SeeAllbtn.setTitleColor(.systemOrange, for: .normal)


    }
    func getVersesByBookNumber(listData: [BooksModel], index: Int) -> [verse_nkjv_contentModel] {
        var listVerseByBook: [verse_nkjv_contentModel] = [verse_nkjv_contentModel]()
        for item in DataBooksContent2 {
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
            vc.Name = "New testament"
            vc.ImageColor = UIImage.init(named: "iconbook2")
            vc.DataBooksContentSeeAll = DataBooksContent2
            vc.ArrayNameBook = S2name
            vc.IntSeeall1 = 40
            vc.modalPresentationStyle = .fullScreen
            parentVC.present(vc, animated: true)
            
        }
    }
}

extension HomeBooks2CollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return List2Books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bookitem2CollectionViewCell.className, for: indexPath) as! bookitem2CollectionViewCell
        cell.NameBook.text = List2Books[indexPath.row].EnName + " (\(List2Books[indexPath.row].ChapterCount))"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let parentVC = self.parentViewController  as? MainViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ListchapterViewController") as! ListchapterViewController
            vc.NumberChapter = List2Books[indexPath.row].ChapterCount
            let listVersesByBook = getVersesByBookNumber(listData: List2Books, index: indexPath.item)
            vc.listDataVerse = listVersesByBook
            vc.Name = List2Books[indexPath.row].EnName
            vc.SNamebook = S2name[indexPath.item]
            vc.bookID = List2Books[indexPath.row].BookID
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

extension HomeBooks2CollectionViewCell: UICollectionViewDelegateFlowLayout {
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
        return CGSize(width: 150, height: 100)
    }
}

