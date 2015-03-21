//
//   RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Benjamin Johnston on 3/14/15.
//  Copyright (c) 2015 Ben Johnston. All rights reserved.
//  Class that stores and NSURL pointing to an audio file and a title

import Foundation
class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    init(filePathUrl: NSURL!, title: String!){
        self.filePathUrl = filePathUrl
        self.title = title
    }
}