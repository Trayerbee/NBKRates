//
//  RSSItem.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 28/09/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class RSSItem: NSObject, NSCoding {
    var title: String?
    var link: URL?
    
    var guid: String?
    var pubDate: Date{
        get{
            return self.pubDate
        }
        set(newDate){
            self.pubDate = newDate
        }
    }
    
    func setStringDate(_ dateString: String!)
    {
        pubDate = Date.dateFromInternetDateTimeString(dateString)!
    }
    
    var itemDescription: String?
    var content: String?
    
    
    var commentsCount: Int?
    
    var commentRSSLink: URL?
    
    var author: String?
    
    var categories: [String]! = [String]()
    
    var imagesFromItemDescription: [URL]! {
        if let itemDescription = self.itemDescription
        {
            return itemDescription.imageLinksFromHTMLString as [URL]
        }
        
        return [URL]()
    }
    
    var imagesFromContent: [URL]! {
        if let content = self.content
        {
            return content.imageLinksFromHTMLString as [URL]
        }
        
        return [URL]()
    }
    
    override init()
    {
        super.init()
    }
    
    // MARK: NSCoding
    required init(coder aDecoder: NSCoder)
    {
        super.init()
        
        title = aDecoder.decodeObject(forKey: "title") as? String
        link = aDecoder.decodeObject(forKey: "link") as? URL
        guid = aDecoder.decodeObject(forKey: "guid") as? String
        pubDate = (aDecoder.decodeObject(forKey: "pubDate") as? Date)!
        itemDescription = aDecoder.decodeObject(forKey: "description") as? String
        content = aDecoder.decodeObject(forKey: "content") as? String
        commentsCount = aDecoder.decodeObject(forKey: "commentsCount") as? Int
        commentRSSLink = aDecoder.decodeObject(forKey: "commentRSSLink") as? URL
        author = aDecoder.decodeObject(forKey: "author") as? String
        categories = aDecoder.decodeObject(forKey: "categories") as? [String]
    }
    
    func encode(with aCoder: NSCoder)
    {
        if let title = self.title
        {
            aCoder.encode(title, forKey: "title")
        }
        
        if let link = self.link
        {
            aCoder.encode(link, forKey: "link")
        }
        
        if let guid = self.guid
        {
            aCoder.encode(guid, forKey: "guid")
        }
        aCoder.encode(pubDate, forKey: "pubDate")
        if let itemDescription = self.itemDescription
        {
            aCoder.encode(itemDescription, forKey: "description")
        }
        
        if let content = self.content
        {
            aCoder.encode(content, forKey: "content")
        }
        
        if let commentsLink = self.commentRSSLink
        {
            aCoder.encode(commentsLink, forKey: "commentsLink")
        }
        
        if let commentsCount = self.commentsCount
        {
            aCoder.encode(commentsCount, forKey: "commentsCount")
        }
        
        if let commentRSSLink = self.commentRSSLink
        {
            aCoder.encode(commentRSSLink, forKey: "commentRSSLink")
        }
        
        if let author = self.author
        {
            aCoder.encode(author, forKey: "author")
        }
        
        aCoder.encode(categories, forKey: "categories")
    }
}
