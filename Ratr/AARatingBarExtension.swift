//
//  AARatingBarExtension.swift
//  Ratr
//
//  Created by Michael Smith on 10/11/17.
//  Copyright © 2017 Soundcloud. All rights reserved.
//

import AARatingBar

extension AARatingBar {
    func updateRating(_ rating: Float) {
        
        self.value = CGFloat(rating)
        self.setNeedsDisplay()
        
    }
}


