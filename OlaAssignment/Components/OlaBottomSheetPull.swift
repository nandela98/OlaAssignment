//
//  OlaBottomSheetPull.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/12/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import UIKit
import Foundation

protocol OlaBottomSheetProtocol {
    var tableVw: UITableView? { get }
    func dismissPullView()
}
/**
      Bottom sheet/Puley design for any other controller to inherit and use it byt just passing tableview reference
 */
public class OlaBottomSheetPull: UIViewController, OlaBottomSheetProtocol {
    
    internal weak var tableVw: UITableView?
    private let fullView: CGFloat = OlaConstants.fullVisibleView
    private var partialView: CGFloat {
        return OlaConstants.partialVisibleView
    }
    private weak var gestureRecognizer: UIPanGestureRecognizer?
    
    public override func viewDidLoad() {
        addGestureRecognizer()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
        
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateBottomViewOnViewAppear()
    }
    
    /**
        dismiss sheet view to  half frame state
     */
    public func dismissPullView() {
        if let gesture = gestureRecognizer {
            gesture.state = .ended
            panGesture(gesture)
        }
    }
    
}

// MARK: fileprivate (setUp gesture and initial setup)

fileprivate extension OlaBottomSheetPull {
    
    func addGestureRecognizer() {
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
        gestureRecognizer = gesture
    }
    
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .light)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        view.insertSubview(bluredView, at: 0)
    }
    
    func animateBottomViewOnViewAppear() {
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            if let frame = self?.view.frame, let yComponent = self?.partialView {
                self?.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height - 100)
            }
        })
    }
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        
        let y = self.view.frame.minY
        if (y + translation.y >= fullView) && (y + translation.y <= partialView) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        recognizerStateEnded(recognizer, velocity, y)
    }
    
    func recognizerStateEnded(_ recognizer: UIPanGestureRecognizer, _ velocity: CGPoint, _ y: CGFloat) {
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            duration = duration > 1.3 ? 1 : duration
            animateBasedOnVelocity(duration, velocity)
        }
    }
    
    func animateBasedOnVelocity(_ duration: Double, _ velocity: CGPoint) {
        UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
            if  velocity.y >= 0 {
                self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
            } else {
                self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
            }
        }, completion: { [weak self] _ in
            if ( velocity.y < 0 ) {
                self?.tableVw?.isScrollEnabled = true
            }
        })
    }
    
}


// MARK: UIGestureRecognizerDelegate

extension OlaBottomSheetPull: UIGestureRecognizerDelegate {

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
        let direction = gesture.velocity(in: view).y
        let y = view.frame.minY
        if (y == fullView && tableVw?.contentOffset.y == 0 && direction > 0) || (y == partialView) {
            tableVw?.isScrollEnabled = false
        } else {
            tableVw?.isScrollEnabled = true
        }
        return false
    }
    
}
