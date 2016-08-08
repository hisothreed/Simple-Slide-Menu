//
//  VC1.swift
//  SlideMenu
//
//  Created by Hiso3d on 8/8/16.
//  Copyright © 2016 Hiso3d. All rights reserved.
//

import UIKit

class VC1: UIViewController, MenuTransitionManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    let toMenuTransition = ToMenuTransitionClass()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ToMenu" {
            
            let menuVC = segue.destinationViewController as! MenuVC
            
            menuVC.transitioningDelegate = toMenuTransition
            
            toMenuTransition.delegate = self
            
        }
    }

}
