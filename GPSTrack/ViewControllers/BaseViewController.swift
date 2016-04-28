//
//  BaseViewController.swift
//  GPSTrack
//
//  Created by Albert Zhang on 3/30/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var viewHadWillAppear:Bool
    var viewHadDidAppear:Bool
    var viewHadDidLayoutSubviews:Bool

    init() {
        viewHadWillAppear = false
        viewHadDidAppear = false
        viewHadDidLayoutSubviews = false
        super.init(nibName: nil, bundle: nil)
        printInit(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        printDeinit(self)
    }


    var baseView:BaseView? {
        get {
            return self.view as? BaseView
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if !viewHadWillAppear {
            viewHadWillAppear = true
            self.viewWillFirstAppear(animated)
        }
    }

    func viewWillFirstAppear(animated: Bool) {

    }


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !viewHadDidAppear{
            viewHadDidAppear = true
            self.viewDidFirstAppear(animated)
        }
    }

    func viewDidFirstAppear(animated: Bool){

    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if !viewHadDidLayoutSubviews {
            viewHadDidLayoutSubviews = true
            self.baseView?.createLayout(topLayoutGuide: self.topLayoutGuide,
                                        bottomLayoutGuide: self.bottomLayoutGuide)
        }
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
