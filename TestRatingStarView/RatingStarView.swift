//
//  RatingStarView.swift
//  TestRatingStarView
//
//  Created by WeiShengkun on 3/6/17.
//  Copyright © 2017 WeiShengkun. All rights reserved.
//

import UIKit


class RatingStarView: UIView {

//    var maskLayer: CALayer = CALayer()
    
    var starWidth: CGFloat = 0
    var gapWidth: CGFloat = 0
    
    let progressBar = UIView()
    
    
    var starEmptyColor = UIColor(red: 178 / 255, green: 174 / 255, blue: 166 / 255, alpha: 1) {
        didSet {
            self.backgroundColor = starEmptyColor
        }
    }
    
    var starFillColor = UIColor(red: 245 / 255, green: 166 / 255, blue: 35 / 255, alpha: 1) {
        didSet {
            progressBar.backgroundColor = starFillColor
        }
    }
    
    var percentage: Float = 1 {
        didSet {
            if self.percentage > 1 {
                self.percentage = 1
            }
            
            progressBar.frame.size.width = progressBarWidth
            print("endx \(progressBarWidth)   frame: \(progressBar.frame)")
        }
    }
    
    var progressBarWidth: CGFloat {
        let fullStars = floor(percentage * Float(starNum))
        let nonfullStarPercent = percentage - fullStars * (1.0 / Float(starNum))
        let progressBarEndX = fullStars * Float(starWidth + gapWidth) + nonfullStarPercent * Float(starNum) * Float(starWidth)
        return CGFloat(progressBarEndX)
    }
    
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
        backgroundColor = starEmptyColor
        progressBar.backgroundColor = starFillColor
        addSubview(progressBar)
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let viewWidth = bounds.width
        let viewHeight = bounds.height
        
        let unitWidth = viewWidth / CGFloat(starNum)
        
        let starImage = UIImage(named: "star")!
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
        
        let maskLayer = CALayer()
        
        for i in 0..<starNum {
            let l = CALayer()
            l.contentsScale = UIScreen.main.scale
            l.contents = starImage.cgImage
            l.allowsEdgeAntialiasing = true
            l.edgeAntialiasingMask = .layerTopEdge
            let x = CGFloat(i) * (starWidth + gapWidth)
            l.frame = CGRect(x: x, y: starTop, width: starWidth, height: starHeight)
            
            maskLayer.addSublayer(l)
        }
        
        self.layer.mask = maskLayer
        
        progressBar.frame = CGRect(x: 0, y: 0, width: progressBarWidth, height: bounds.height)
        
    }
    

    
    
}
