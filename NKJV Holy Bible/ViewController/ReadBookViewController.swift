//
//  ReadBookViewController.swift
//  NKJV Holy Bible
//
//  Created by ĐINH HUY PHU on 16/11/2021.
//

import UIKit

class ReadBookViewController: UIViewController {
    @IBOutlet weak var ReadCollectionView: UICollectionView!
    @IBOutlet weak var NameBook: UILabel!
    @IBOutlet weak var NameChapter: UILabel!
    var NameSach : String = ""
    var SNamebookLink : String = ""
    var bookIDLink : Int = 0
    var index = 0
    var DataBooks : [verse_nkjv_contentModel] = [verse_nkjv_contentModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NameBook.text = SNamebookLink + " " + String(DataBooks[index].c2chapter_id)
        NameBook.font = .boldSystemFont(ofSize: 24)
        NameBook.textColor = .white
        ReadCollectionView.backgroundColor = UIColor.clear
        ReadCollectionView.register(UINib(nibName: ReadbookCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: ReadbookCollectionViewCell.className)
        NameChapter.text = NameSach + " " + String(DataBooks[index].c2chapter_id)
        NameChapter.textColor = .red
    }
    
    
    
    @IBAction func BtnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSearch(_ sender: Any) {
    }
    @IBAction func btnAddBible(_ sender: Any) {
    }
    @IBAction func btnNext(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("SU_KIEN_THAY_DOI_DATA"), object: nil)
    }
    @IBAction func BackChapter(_ sender: Any) {
    }
    @IBAction func BtnOptions(_ sender: Any) {
    }
    @IBAction func BtnSpeak(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        vc.modalPresentationStyle = .overFullScreen
        if bookIDLink < 10{
            vc.Link = "0\(bookIDLink)"+"_"+SNamebookLink
        }else{
            vc.Link = "\(bookIDLink)"+"_"+SNamebookLink
        }
        if DataBooks[index].c2chapter_id < 10 {
            vc.IntLink = "00\(DataBooks[index].c2chapter_id)"
        }
        if DataBooks[index].c2chapter_id >= 10{
            vc.IntLink = "0\(DataBooks[index].c2chapter_id)"
        }
        if DataBooks[index].c2chapter_id > 99{
            vc.IntLink = "\(DataBooks[index].c2chapter_id)"
        }
        self.present(vc, animated: true, completion: nil)
    }
    
}
extension ReadBookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReadbookCollectionViewCell.className, for: indexPath) as! ReadbookCollectionViewCell
        if DataBooks[indexPath.row].c3verse_id == 0 {
            cell.contentBook.font = .boldSystemFont(ofSize: 26)
            cell.contentBook.text = DataBooks[indexPath.row].c5content_no_comment
        }else{
            cell.contentBook.font = .systemFont(ofSize: 20)
            cell.contentBook.text = "\(DataBooks[indexPath.row].c3verse_id)" + ". " + DataBooks[indexPath.row].c5content_no_comment
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReadBookViewController") as! ReadBookViewController
        //        vc.modalPresentationStyle = .fullScreen
        //        self.present(vc, animated: true, completion: nil)
    }
    
}

extension ReadBookViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: UIScreen.main.bounds.width, height: 150)
        }
        return CGSize(width: UIScreen.main.bounds.width, height: 150)
    }
}


