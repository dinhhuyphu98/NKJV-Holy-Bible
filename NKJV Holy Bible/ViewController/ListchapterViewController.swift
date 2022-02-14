//
//  ListchapterViewController.swift
//  NKJV Holy Bible
//
//  Created by ĐINH HUY PHU on 09/11/2021.
//

import UIKit

class ListchapterViewController: UIViewController {
    @IBOutlet weak var NameCategory: UILabel!
    @IBOutlet weak var NameBook: UILabel!
    @IBOutlet weak var NameChapter: UILabel!
    var listDataVerse : [verse_nkjv_contentModel] = [verse_nkjv_contentModel]()
    var NumberChapter : Int = 0
    var indexNext = 0
    var Name : String = ""
    var listCount: [Int] = [Int]()
    var SNamebook : String = "''"
    var bookID : Int = 0

    @IBOutlet weak var  ListchapterCollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListchapterCollectionView.register(UINib(nibName: ListChapterCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: ListChapterCollectionViewCell.className)
        NameBook.text = Name
        NameChapter.text = "\(NumberChapter)"
        NameCategory.text = Name
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReloadDataAll(notification:)), name: Notification.Name("SU_KIEN_THAY_DOI_DATA"), object: nil)
    }
    @objc func ReloadDataAll(notification: Notification) {
        indexNext = indexNext+1
    }
    func dupplicateRemove() {
        listCount.removeAll()
        for item in listDataVerse {
            var isDupplicate = false
            for countItem in listCount {
                if item.c2chapter_id == countItem {
                    isDupplicate = true
                    break
                }
            }
            if !isDupplicate {
                listCount.append(item.c2chapter_id)
            }
            isDupplicate = false
        }
    }
    
    func getVersesByChapter(index: Int) -> [verse_nkjv_contentModel] {
        var listVerseByChapter: [verse_nkjv_contentModel] = [verse_nkjv_contentModel]()
        for item in listDataVerse {
            if index + 1 == item.c2chapter_id {
                listVerseByChapter.append(item)
            }
        }
        return listVerseByChapter
    }
    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension ListchapterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dupplicateRemove()
        return listCount.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListChapterCollectionViewCell.className, for: indexPath) as! ListChapterCollectionViewCell
        cell.ColorView.layer.cornerRadius = 10
        cell.NumberChapter.text = String(listCount[indexPath.item])

        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReadBookViewController") as! ReadBookViewController
        vc.NameSach = Name
        let listVerseByChapter = getVersesByChapter(index: indexPath.item + indexNext)
        vc.DataBooks = listVerseByChapter
        vc.SNamebookLink = SNamebook
        vc.bookIDLink = bookID
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension ListchapterViewController: UICollectionViewDelegateFlowLayout {
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
            return CGSize(width: UIScreen.main.bounds.width/5-30, height: 50)
        }
        return CGSize(width: UIScreen.main.bounds.width/5-30, height: 50)
    }
}

