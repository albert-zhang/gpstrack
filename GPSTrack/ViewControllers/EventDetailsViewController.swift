//
//  EventDetailsViewController.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/28/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

class EventDetailsViewController: BaseViewController {

    var event:Event?

    override init() {
        super.init()

        title = "Event Details"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let v = EventDetailsView()
        self.view = v
    }

    var view2:EventDetailsView? {
        return self.view as? EventDetailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        view2?.event = event

        view2?.addToolBarItem(title: "Export") {
            self.exportKML()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func exportKML() {
        do {
            try GoogleEarthHelper.exportKML(event!)
            UIAlertController.showAlert(title: "KML saved", message: "Check your files")
        } catch let ex {
            print("exportKML exception: \(ex)")
            UIAlertController.showAlert(title: "KML save failed", message: "\(ex)")
        }
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
