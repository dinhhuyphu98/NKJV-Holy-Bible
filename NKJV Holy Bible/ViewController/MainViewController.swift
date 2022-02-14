//
//  MainViewController.swift
//  NKJV Holy Bible
//
//  Created by ĐINH HUY PHU on 09/11/2021.
//

import UIKit

class MainViewController: UIViewController {
    var ListDataBooks:[BooksModel] = [BooksModel]()
    var DataBooksContent : [verse_nkjv_contentModel] = [verse_nkjv_contentModel]()
    var ListDataBooksOldtestament:[BooksModel] = [BooksModel]()
    var ListDataBooksNewtestament:[BooksModel] = [BooksModel]()
    @IBOutlet weak var  BookCollectionView : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        BookCollectionView.register(UINib(nibName: HomeBooksCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: HomeBooksCollectionViewCell.className)
        BookCollectionView.register(UINib(nibName: HomeBooks2CollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: HomeBooks2CollectionViewCell.className)
        BookCollectionView.backgroundColor = UIColor.clear
        
        SqliteService.shared.getDataHome(){ datarepond,error in
            if let datarepond = datarepond{
                self.ListDataBooks = datarepond
            }
        }
        SqliteService.shared.getDataContent(){ data,error in
            if let data = data{
                self.DataBooksContent = data
            }
        }
        for item in self.ListDataBooks {
            if item.BookID <= 39 {
                self.ListDataBooksOldtestament.append(item)
            }
        }
        for item in self.ListDataBooks {
            if item.BookID > 39 {
                self.ListDataBooksNewtestament.append(item)
            }
        }
    }
    @IBAction func BtnOptions(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OptionsViewController") as! OptionsViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBooksCollectionViewCell.className, for: indexPath) as! HomeBooksCollectionViewCell
            cell.Categorybook.text = "Old testament (39)"
            cell.List1Books = ListDataBooksOldtestament
            cell.DataBooksContent1 = DataBooksContent
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBooks2CollectionViewCell.className, for: indexPath) as! HomeBooks2CollectionViewCell
            cell.List2Books = ListDataBooksNewtestament
            cell.Categorybook.text = "New testament (27)"
            cell.DataBooksContent2 = DataBooksContent
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        return UICollectionReusableView()
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
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
            return CGSize(width: UIScreen.main.bounds.width, height: 600)
        }
        return CGSize(width: UIScreen.main.bounds.width, height: 400)
    }
}


