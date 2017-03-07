//
//  ViewController.swift
//  TestRatingStarView
//
//  Created by WeiShengkun on 3/6/17.
//  Copyright © 2017 WeiShengkun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var starView: RatingStarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        
        starView = RatingStarView(frame: CGRect(x: 20, y: 150, width: 300, height: 40))
        self.view.addSubview(starView)
        
//        starView.rating = 4.3
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        starView.rating = 2.5
    }

}

