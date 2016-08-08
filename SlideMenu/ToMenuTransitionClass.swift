//
//  ToMenuTransitionController.swift
//  SlideMenu
//
//  Created by Hiso3d on 8/8/16.
//  Copyright © 2016 Hiso3d. All rights reserved.
//

import UIKit

@objc protocol MenuTransitionManagerDelegate {
    func dismiss()
}

class ToMenuTransitionClass: NSObject, UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning{
    
    
    let duration = 0.8
    var isPresenting = false
    
    
    
    //// uiview that holds the origin view snapshot
    
    var snapshot:UIView? {
        didSet {
            if let delegate = delegate {
                let tapGestureRecognizer = UITapGestureRecognizer(target: delegate, action: #selector(MenuTransitionManagerDelegate.dismiss))
                snapshot?.addGestureRecognizer(tapGestureRecognizer)
            }
        }
    }
    
    var delegate: MenuTransitionManagerDelegate?
    
    /// set the transition duration
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // make instances of the origin view and the destination view
        
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        
        
        
        //// setting up the container
        
        guard let container = transitionContext.containerView() else {return}
        
        // setting up the animations
        
        
        /// getting the screen size
        
        let screenBounds = UIScreen.mainScreen().bounds
        
        let moveLeft = CGAffineTransformMakeTranslation(-screenBounds.width, 0)
        
        
        /// you can specify y-axis as you like
        let moveRight = CGAffineTransformMakeTranslation(0, 0)
        
        /// extra frame (UIView) setting

        let backgroundColor = toView?.backgroundColor
        
        let frameToAdd = screenBounds
        
        let BackView = UIView(frame: frameToAdd)
        
        BackView.backgroundColor = backgroundColor
        
        
        if isPresenting {
            
            
            /// move the menu to left and hide it for now
            toView?.transform = moveLeft
            
            /// take and set the snapshot
            
            snapshot = fromView?.snapshotViewAfterScreenUpdates(true)
            snapshot!.layer.shadowOpacity = 0.5
            snapshot!.layer.shadowOffset = CGSizeMake(-8.0, -1.0)
            snapshot!.layer.shadowColor = UIColor.blackColor().CGColor
            
            ///hide the origin view
            
            fromView?.hidden = true
            
            // add the views to the container
            
            container.addSubview(BackView)
            container.addSubview(toView!)
            container.addSubview(snapshot!)
        }
        
        
        //// here the real work begins
        
        UIView.animateWithDuration(duration, animations: {
            
            if self.isPresenting {
                
                self.snapshot!.frame = CGRectMake(screenBounds.width/1.2, (screenBounds.height)/12, (screenBounds.width)/0.9, (fromView?.frame.height)!/0.9)
                
                
                self.snapshot!.backgroundColor = UIColor(red: 71, green: 69, blue: 86, alpha: 91)
                
                toView?.transform = moveRight
                
            }else{
                //// for dismiss
                
                toView?.hidden = false
                
                self.snapshot!.frame = CGRectMake(0, 0, (screenBounds.width), (screenBounds.height))
                
                fromView?.transform = moveLeft
                
            }
            
        }) { (finished) -> Void in
            
            transitionContext.completeTransition(true)
            
            
        }
        
    }
    
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    
}
