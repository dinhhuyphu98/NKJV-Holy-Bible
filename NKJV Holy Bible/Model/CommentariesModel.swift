//
//  CommentariesModel.swift
//  NKJV Holy Bible
//
//  Created by ĐINH HUY PHU on 09/11/2021.
//

import Foundation
import SQLite

class CommentariesModel: NSObject {
    var chapter_id_from : Int
    var verse_id_from : Int
    var chapter_id_to : Int
    var verse_id_to : Int
    var market : String
    var text : String
    var book_id : Int
    
    init(chapter_id_from: Int,verse_id_from : Int,chapter_id_to : Int,verse_id_to : Int,market : String,text : String,book_id : Int) {
        self.chapter_id_from = chapter_id_from
        self.verse_id_from = verse_id_from
        self.chapter_id_to = chapter_id_to
        self.verse_id_to = verse_id_to
        self.market = market
        self.text = text
        self.book_id = book_id
    }
}
