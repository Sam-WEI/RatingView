//
//  RatingStarView.swift
//  TestRatingStarView
//
//  Created by WeiShengkun on 3/6/17.
//  Copyright © 2017 WeiShengkun. All rights reserved.
//

import UIKit


class RatingStarView: UIView {

    
    fileprivate var starWidth: CGFloat = 0
    fileprivate var gapWidth: CGFloat = 0
    
    fileprivate var progressLayer: CALayer!
    fileprivate var starViewLayer: CALayer!
    
    @IBInspectable
    var starEmptyColor = UIColor(red: 178 / 255, green: 174 / 255, blue: 166 / 255, alpha: 1) {
        didSet {
            starViewLayer.backgroundColor = starEmptyColor.cgColor
        }
    }
    
    @IBInspectable
    var starFillColor = UIColor(red: 245 / 255, green: 166 / 255, blue: 35 / 255, alpha: 1) {
        didSet {
            progressLayer.backgroundColor = starFillColor.cgColor
        }
    }
    
    
    var percentage: Float = 1 {
        didSet {
            if self.percentage > 1 {
                self.percentage = 1
            }
            progressLayer.frame.size.width = progressBarWidth
        }
    }
    
    fileprivate var progressBarWidth: CGFloat {
        let fullStars = floor(percentage * Float(starNum))
        let nonfullStarPercent = percentage - fullStars * (1.0 / Float(starNum))
        let progressBarEndX = fullStars * Float(starWidth + gapWidth) + nonfullStarPercent * Float(starNum) * Float(starWidth)
        return CGFloat(progressBarEndX)
    }
    
    @IBInspectable
    var starNum: Int = 5 {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    var rating: Float = 5 {
        didSet {
            if rating > Float(starNum) {
                rating = Float(starNum)
            }
            percentage = rating / Float(starNum)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        doInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doInit()
    }

    
    
    
    fileprivate func doInit() {
        progressLayer = CALayer()
        progressLayer.contentsScale = UIScreen.main.scale
        starViewLayer = CALayer()
        starViewLayer.contentsScale = UIScreen.main.scale
        
        starViewLayer.backgroundColor = starEmptyColor.cgColor
        progressLayer.backgroundColor = starFillColor.cgColor
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let viewWidth = bounds.width
        let viewHeight = bounds.height
        
        let unitWidth = viewWidth / CGFloat(starNum)
        
        let starImage = UIImage(named: "greyStar")!
        let imageSize = starImage.size
        
        let starTop: CGFloat
        let starHeight: CGFloat
        
        
        if imageSize.width / imageSize.height < unitWidth / viewHeight {
            starTop = 0
            starHeight = viewHeight
            starWidth = starHeight * imageSize.width / imageSize.height
            gapWidth = (viewWidth - starWidth * CGFloat(starNum)) / CGFloat(starNum - 1)
        }
        else {
            gapWidth = 0
            starWidth = unitWidth
            starHeight = starWidth * imageSize.height / imageSize.width
            starTop = (viewHeight - starHeight) / CGFloat(2)
        }
        
        print("star T: \(starTop)  H:\(starHeight)  W:\(starWidth)  gap:\(gapWidth)")
        
        
        
        starViewLayer.frame = bounds
        starViewLayer.addSublayer(progressLayer)
        progressLayer.frame = CGRect(x: 0, y: 0, width: progressBarWidth, height: bounds.height)
        
        let maskLayer = CALayer()
        maskLayer.contentsScale = UIScreen.main.scale

        
        for i in 0..<starNum {
            let l = CALayer()
            l.contentsScale = UIScreen.main.scale
            l.contents = starImage.cgImage
            let x = CGFloat(i) * (starWidth + gapWidth)
            l.frame = CGRect(x: x, y: starTop, width: starWidth, height: starHeight)
            
            maskLayer.addSublayer(l)
            
        }
        
        
        starViewLayer.mask = maskLayer
        self.layer.addSublayer(starViewLayer)
        
    }
    

    
    
}
