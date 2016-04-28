//
//  EventDetailsViewController.swift
//  GPSTrack
//
//  Created by Albert Zhang on 4/8/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import UIKit

class EventEditViewController: BaseViewController, UIViewControllerTransitioningDelegate {

    var event:Event?

    override init() {
        super.init()
        self.modalPresentationStyle = .Custom
        self.transitioningDelegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EventEditViewController.onKeyboardWillShow(_:)),
                                                         name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EventEditViewController.onKeyboardDidHide(_:)),
                                                         name: UIKeyboardDidHideNotification, object: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let v = EventEditView()
        self.view = v
    }

    var view2:EventEditView? {
        get {
            return self.view as? EventEditView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        if let evt = event {
            view2?.eventTitleField.text = evt.title
            view2?.eventDescField.text = evt.desc
            if let r = evt.isRunning {
                view2?.runningSwitch.on = r.boolValue
            } else {
                view2?.runningSwitch.on = false
            }

        } else {
            view2?.runningSwitch.on = true
            view2?.runningSwitch.enabled = false
        }

        view2?.dismissBtn.addTarget(self, action: #selector(EventEditViewController.onDisimss))
        view2?.okBtn.addTarget(self, action: #selector(EventEditViewController.onOK))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onDisimss(){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    func onOK() {
        if let evtTitle = view2?.eventTitleField.text, let evtDesc = view2?.eventDescField.text {
            if let passedEvt = event {
                passedEvt.title = evtTitle
                passedEvt.desc = evtDesc
                passedEvt.isRunning = NSNumber(bool: (view2?.runningSwitch.on)!)
            } else {
                DataManager.manager().insertEvent(title: evtTitle, desc: evtDesc)
            }
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
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


    // MARK: -

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        let transition = EventEditTransitionAnimator(isPresenting: true)
        return transition
    }

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = EventEditTransitionAnimator(isPresenting: false)
        return transition
    }


    // MARK: -

    var viewRectBeforeKeyboard:CGRect?
    func onKeyboardWillShow(n:NSNotification) {
        var rect = self.view.frame
        viewRectBeforeKeyboard = rect
        rect.origin.y = UIApplication.sharedApplication().statusBarFrame.size.height
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = rect
        }) { (completed) in

        }
    }

    func onKeyboardDidHide(n:NSNotification) {
        guard let rect = viewRectBeforeKeyboard else { return }
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = rect
        }) { (completed) in

        }
    }

}
