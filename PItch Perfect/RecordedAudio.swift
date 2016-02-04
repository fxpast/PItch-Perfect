//
//  RecordedAudio.swift
//  PItch Perfect
//
//  Created by MacbookPRV on 16/11/2015.
//  Copyright © 2015 Pastouret Roger. All rights reserved.
//

import Foundation

class RecordedAudio:NSObject {
    var filePathUrl: NSURL!
    var title:String!
    
    
    init(filePathUrl:NSURL, title:String){
        self.filePathUrl=filePathUrl
        self.title=title
        
    }
    
    
}
