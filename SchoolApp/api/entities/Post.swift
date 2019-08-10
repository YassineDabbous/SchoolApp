//
//  Article.swift
//  MyApp
//
//  Created by X on 4/9/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation
struct Post: Codable {
    let postID, termID, termOrder: Int?
    let postTitle, postContent: String?
    let docURL: String?
    let youtubeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case termID = "term_id"
        case termOrder = "term_order"
        case postTitle = "post_title"
        case postContent = "post_content"
        case docURL = "doc_url"
        case youtubeURL = "youtube_url"
    }
    
    init(){
        postID = 0
        termID = 0
        termOrder =  0
        postTitle = ""
        postContent = ""
        docURL = ""
        youtubeURL = ""
    }
    init(item:File){
        postID = 0
        termID = 0
        termOrder =  0
        postTitle = ""
        postContent = ""
        docURL = ""
        youtubeURL = ""
    }
}
