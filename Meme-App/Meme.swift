//
//  Meme.swift
//  Meme-App
//
//  Created by Мануэль on 18.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var image: UIImage?
    var topText: String?
    var bottomText: String?
    
    init(topText: String, bottomText: String, image: UIImage) {
        self.image      = image
        self.topText    = topText
        self.bottomText = bottomText
    }    
}