//
//  SlideInPresentationController.swift
//  TaskPlanner
//
//  Created by Bhavesh Agrawal on 07/06/2019.
//  Copyright © 2019 Bhavesh Agrawal. All rights reserved.
//

import Foundation
import UIKit

class SlideInPresentationController: UIPresentationController {
    
    fileprivate let newViewControllerHeight: CGFloat = 281
    fileprivate var dimmingView: UIView!
    fileprivate let dimmingViewColor = UIColor(red: 0.14, green: 0.14, blue: 0.37, alpha: 0.2)
    
    override init(presentedViewController: UIViewController,
                  presenting presentingViewController: UIViewController?) {
        
        super.init(presentedViewController: presentedViewController,
                   presenting: presentingViewController)
        
        setupDimmingView()
    }
    
    override func presentationTransitionWillBegin() {
        containerView?.insertSubview(dimmingView, at: 0)
        
        if let container = containerView {
            dimmingView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
            dimmingView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
            dimmingView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
            dimmingView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        }
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController,
                          withParentContainerSize: containerView!.bounds.size)
        
        frame.origin.y = containerView!.frame.height - presentedViewController.view.frame.height
        return frame
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer,
                       withParentContainerSize parentSize: CGSize) -> CGSize {
        
        return CGSize(width: parentSize.width, height: newViewControllerHeight)
    }
}

private extension SlideInPresentationController {
    
    @objc dynamic func handleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }

    func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = dimmingViewColor
        dimmingView.alpha = 0.0
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
    }
}
