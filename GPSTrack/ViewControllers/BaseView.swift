//
//  BaseView.swift
//  GPSTrack
//
//  Created by Albert Zhang on 3/30/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

class BaseView: UIView {

    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.fromHex("ffffff")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */


    func createLayout(topLayoutGuide topLayoutGuide:UILayoutSupport, bottomLayoutGuide:UILayoutSupport) {

    }

}
