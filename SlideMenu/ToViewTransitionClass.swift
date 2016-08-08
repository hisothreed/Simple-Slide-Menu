//
//  ToViewTransitionClass.swift
//  SlideMenu
//
//  Created by Hiso3d on 8/8/16.
//  Copyright © 2016 Hiso3d. All rights reserved.
//

import UIKit

class ToViewTransitionClass: NSObject ,UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate {
    
    let duration = 2.0
    var ispresenting = false
    var snapShot :UIView?
    
    let screenBounds = UIScreen.mainScreen().bounds
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 4.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        
        guard let container = transitionContext.containerView() else { return }
        
        let moveleft = CGAffineTransformMakeTranslation(-UIScreen.mainScreen().bounds.width ,0)
        
        if ispresenting {
            
            toView?.frame = CGRectMake(screenBounds.width/1.2, (screenBounds.height)/12, (screenBounds.width)/0.9, (fromView?.frame.height)!/0.9)
            
            
            
            container.addSubview(fromView!)
            container.addSubview(toView!)
            
        }
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 4.0, options: [], animations: { () -> Void in
            
            if self.ispresenting {
                
                
                toView?.frame = CGRectMake(0, 0, (fromView?.frame.width)!, (fromView?.frame.height)!)
                
                fromView?.transform = moveleft
                
                
            }
            
        }) { (finished) -> Void in
            
            transitionContext.completeTransition(true)
            
        }
        
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        ispresenting = true
        return self
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        ispresenting = false
        return self
    }
}
