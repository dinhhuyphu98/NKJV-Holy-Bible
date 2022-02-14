//
//  timing_nkjvModel.swift
//  NKJV Holy Bible
//
//  Created by ĐINH HUY PHU on 16/11/2021.
//

import Foundation
import SQLite

class timing_nkjvModel: NSObject {
    var id : Int
    var book_id : Int
    var chapter_id : Int
    var verse_id : Int
    var start : Int
    var end : Int
    
    init(id: Int,book_id : Int,chapter_id : Int,verse_id : Int,start : Int,end : Int) {
        self.id = id
        self.book_id = book_id
        self.chapter_id = chapter_id
        self.verse_id = verse_id
        self.start = start
        self.end = end
    }
}
