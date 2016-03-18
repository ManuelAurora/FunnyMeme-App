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
    let topText: String?
    let bottomText: String?
    let image: UIImage?
    
    init(topText: String?, bottomText: String?, image: UIImage?) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
    }
       
}