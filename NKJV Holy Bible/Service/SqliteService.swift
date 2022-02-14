//
//  SqliteService.swift
//  NKJV Holy Bible
//
//  Created by ĐINH HUY PHU on 09/11/2021.
//

import UIKit
import SQLite

class SqliteService:NSObject {
    static let shared: SqliteService = SqliteService()
    var DatabaseRoot:Connection?
    var BooksData:[BooksModel] = [BooksModel]()
    var ContentData : [verse_nkjv_contentModel] = [verse_nkjv_contentModel]()
    func loadInit(){
        let dbURL = Bundle.main.url(forResource: "nkjv_2019062_NKJV", withExtension: "db")!
        
        var newURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        newURL.appendPathComponent("nkjv_2019062_NKJV.db")
        do {
            if FileManager.default.fileExists(atPath: newURL.path) {
                print("sss")
            }
            try FileManager.default.copyItem(atPath: dbURL.path, toPath: newURL.path)
            print(newURL.path)
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            DatabaseRoot = try Connection(newURL.path)
        } catch {
            DatabaseRoot = nil
            let nserr = error as NSError
            print("Cannot connect to Database. Error is: \(nserr), \(nserr.userInfo)")
        }
    }
    
    func getDataHome(closure: @escaping (_ response: [BooksModel]?, _ error: Error?) -> Void) {
        let users1 = Table("Books")
        let BookID = Expression<Int64>("BookID")
        let EnName = Expression<String?>("EnName")
        let PartCode = Expression<String?>("PartCode")
        let ChapterCount = Expression<Int64>("ChapterCount")
        BooksData.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users1) {
                    BooksData.append(BooksModel(BookID: Int(user[BookID])
                                                ,EnName: user[EnName] ?? ""
                                                ,PartCode: user[PartCode] ?? ""
                                                ,ChapterCount: Int(user[ChapterCount])
                                               ))

                    
                }
            } catch  {             }
        }
        closure(BooksData, nil)
        
    }
    func getDataContent(closure: @escaping (_ response: [verse_nkjv_contentModel]?, _ error: Error?) -> Void) {
        let table1 = Table("verse_nkjv_content")
        let docid = Expression<Int64>("docid")
        let c0id = Expression<Int64>("c0id")
        let c1book_id = Expression<Int64>("c1book_id")
        let c2chapter_id = Expression<Int64>("c2chapter_id")
        let c3verse_id = Expression<Int64>("c3verse_id")
        let c4content = Expression<String?>("c4content")
        let c5content_no_comment = Expression<String?>("c5content_no_comment")
        ContentData.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for table in try DatabaseRoot.prepare(table1) {
                    ContentData.append(verse_nkjv_contentModel(docid: Int(table[docid])
                                                               ,c0id: Int(table[c0id]),
                                                               c1book_id: Int(table[c1book_id]),
                                                               c2chapter_id: Int(table[c2chapter_id]),
                                                               c3verse_id: Int(table[c3verse_id]),
                                                               c4content: table[c4content] ?? "",
                                                               c5content_no_comment: table[c5content_no_comment] ?? ""
                                                              )
                    )
                    
                }
            } catch  {
            }
        }
        closure(ContentData, nil)
        
    }
}





