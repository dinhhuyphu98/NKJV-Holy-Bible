//
//  verse_nkjv_contentModel.swift
//  NKJV Holy Bible
//
//  Created by ĐINH HUY PHU on 16/11/2021.
//

import Foundation
import SQLite

class verse_nkjv_contentModel: NSObject {
    var docid : Int
    var c0id : Int
    var c1book_id : Int
    var c2chapter_id : Int
    var c3verse_id : Int
    var c4content : String
    var c5content_no_comment : String
    init(docid: Int,c0id : Int,c1book_id : Int,c2chapter_id : Int,c3verse_id : Int,c4content : String,c5content_no_comment : String) {
        self.docid = docid
        self.c0id = c0id
        self.c1book_id = c1book_id
        self.c2chapter_id = c2chapter_id
        self.c3verse_id = c3verse_id
        self.c4content = c4content
        self.c5content_no_comment = c5content_no_comment
    }
}
