//
//  BooksModel.swift
//  NKJV Holy Bible
//
//  Created by ĐINH HUY PHU on 09/11/2021.
//

import Foundation
import SQLite

class BooksModel: NSObject {
    var BookID : Int = 0
    var EnName : String = ""
    var PartCode : String = ""
    var ChapterCount : Int = 0
    init(BookID: Int,EnName : String,PartCode : String,ChapterCount : Int) {
        self.BookID = BookID
        self.EnName = EnName
        self.PartCode = PartCode
        self.ChapterCount = ChapterCount
    }
}
