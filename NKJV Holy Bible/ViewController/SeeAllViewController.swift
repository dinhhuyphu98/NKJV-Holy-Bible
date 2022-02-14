//
//  SeeAllViewController.swift
//  NKJV Holy Bible
//
//  Created by ĐINH HUY PHU on 10/11/2021.
//

import UIKit

class SeeAllViewController: UIViewController {
    var ListDataBooksSeeAll : [BooksModel] = [BooksModel]()
    var ListDataBooksSeeAll1 : [BooksModel] = [BooksModel]()
    var ListDataBooksSeeAll2 : [BooksModel] = [BooksModel]()
    var ListDataBooks2:[BooksModel] = [BooksModel]()
    var IntSeeall1: Int = 0
    var ImageColor : UIImage!
    var DataBooksContentSeeAll : [verse_nkjv_contentModel] = [verse_nkjv_contentModel]()
    @IBOutlet weak var  BookCollectionView2 : UICollectionView!
    @IBOutlet weak var NameCategory: UILabel!
    var ArrayNameBook : [String] = []
    var Name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BookCollectionView2.register(UINib(nibName: SeeallCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: SeeallCollectionViewCell.className)
        NameCategory.text = Name
        BookCollectionView2.layer.cornerRadius = 20
        SqliteService.shared.getDataHome(){ datarepond,error in
            if let datarepond = datarepond{
                self.ListDataBooksSeeAll = datarepond
            }
        }
        for item in self.ListDataBooksSeeAll {
            if item.BookID <= 39 {
                self.ListDataBooksSeeAll1.append(item)
            }
        }
        for item in self.ListDataBooksSeeAll {
            if item.BookID > 39 {
                self.ListDataBooksSeeAll2.append(item)
            }
        }
        
    }
    func getVersesByBookNumber(listData: [BooksModel], index: Int) -> [verse_nkjv_contentModel] {
        var listVerseByBook: [verse_nkjv_contentModel] = [verse_nkjv_contentModel]()
        for item in DataBooksContentSeeAll {
            if item.c1book_id == listData[index].BookID {
                listVerseByBook.append(item)
            }
        }
        return listVerseByBook
    }
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func BtnOption(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OptionsViewController") as! OptionsViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
extension SeeAllViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if IntSeeall1 <= 39 {
            return ListDataBooksSeeAll1.count
        }
        return ListDataBooksSeeAll2.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeeallCollectionViewCell.className, for: indexPath) as! SeeallCollectionViewCell
        
        if IntSeeall1 <= 39 {
            cell.ImageBook.image = ImageColor
            cell.NameBook.text = ListDataBooksSeeAll1[indexPath.row].EnName
            cell.QuantityBook.text = "\(ListDataBooksSeeAll1[indexPath.row].ChapterCount)"
        }else{
            cell.ImageBook.image = ImageColor
            cell.NameBook.text = ListDataBooksSeeAll2[indexPath.row].EnName
            cell.QuantityBook.text = "\(ListDataBooksSeeAll2[indexPath.row].ChapterCount)"
        }
        
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if IntSeeall1 <= 39 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListchapterViewController") as! ListchapterViewController
            vc.modalPresentationStyle = .fullScreen
            vc.Name = ListDataBooksSeeAll1[indexPath.row].EnName
            let listVersesByBook = getVersesByBookNumber(listData: ListDataBooksSeeAll1, index: indexPath.item)
            vc.listDataVerse = listVersesByBook
            vc.NumberChapter = ListDataBooksSeeAll1[indexPath.row].ChapterCount
            vc.SNamebook = ArrayNameBook[indexPath.row]
            vc.bookID = ListDataBooksSeeAll1[indexPath.row].BookID
            self.present(vc, animated: true, completion: nil)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListchapterViewController") as! ListchapterViewController
            vc.modalPresentationStyle = .fullScreen
            vc.Name = ListDataBooksSeeAll2[indexPath.row].EnName
            let listVersesByBook = getVersesByBookNumber(listData: ListDataBooksSeeAll2, index: indexPath.item)
            vc.listDataVerse = listVersesByBook
            vc.NumberChapter = ListDataBooksSeeAll2[indexPath.row].ChapterCount
            vc.SNamebook = ArrayNameBook[indexPath.row]
            vc.bookID = ListDataBooksSeeAll2[indexPath.row].BookID
            self.present(vc, animated: true, completion: nil)
        }

        
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        return UICollectionReusableView()
    }
    
}

extension SeeAllViewController: UICollectionViewDelegateFlowLayout {
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
            return CGSize(width: UIScreen.main.bounds.width/2, height: 400)
        }
        return CGSize(width: UIScreen.main.bounds.width/2, height: 150)
        
    }
}

