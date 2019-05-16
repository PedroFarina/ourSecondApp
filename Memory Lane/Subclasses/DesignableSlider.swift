//
//  DesignableSlider.swift
//  Memory Lane
//
//  Created by Pedro Giuliano Farina on 16/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

@IBDesignable class DesignableSlider:UISlider{
    
    @IBInspectable var thumbImage:UIImage?{
        didSet{
            setThumbImage(thumbImage, for: .normal)
        }
    }
}
