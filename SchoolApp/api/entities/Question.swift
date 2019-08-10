//
//  Question.swift
//  SchoolApp
//
//  Created by X on 7/16/19.
//  Copyright © 2019 X. All rights reserved.
//

import Foundation
struct Question: Codable {
    let id, postAuthor: Int?
    let postDate, postDateGmt, postContent, postTitle: String?
    let postExcerpt, postStatus, commentStatus, pingStatus: String?
    let postPassword, postName, toPing, pinged: String?
    let postModified, postModifiedGmt, postContentFiltered: String?
    let postParent: Int?
    let guid: String?
    let menuOrder: Int?
    let postType, postMIMEType: String?
    let commentCount: Int?
    
    init(id:Int){
        self.id = id
        postAuthor = 0
        postDate = ""
        postDateGmt = ""
        postContent = ""
        postTitle = ""
        postExcerpt = ""
        postStatus = ""
        commentStatus = ""
        pingStatus = ""
        postPassword = ""
        postName = ""
        toPing = ""
        pinged = ""
        postModified = ""
        postModifiedGmt = ""
        postContentFiltered = ""
        postParent = 0
        guid = ""
        menuOrder = 0
        postType = ""
        postMIMEType = ""
        commentCount = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case postAuthor = "post_author"
        case postDate = "post_date"
        case postDateGmt = "post_date_gmt"
        case postContent = "post_content"
        case postTitle = "post_title"
        case postExcerpt = "post_excerpt"
        case postStatus = "post_status"
        case commentStatus = "comment_status"
        case pingStatus = "ping_status"
        case postPassword = "post_password"
        case postName = "post_name"
        case toPing = "to_ping"
        case pinged
        case postModified = "post_modified"
        case postModifiedGmt = "post_modified_gmt"
        case postContentFiltered = "post_content_filtered"
        case postParent = "post_parent"
        case guid
        case menuOrder = "menu_order"
        case postType = "post_type"
        case postMIMEType = "post_mime_type"
        case commentCount = "comment_count"
    }
}
