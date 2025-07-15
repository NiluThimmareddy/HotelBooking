//
//  BookingConformationVC.swift
//  HotelBooking
//
//  Created by toqsoft on 19/06/25.
//

import UIKit
 
class BookingConformationVC: UIViewController {
 
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var bookingDetailsView: UIView!
    @IBOutlet weak var confirmationEmailLabel: UILabel!
    @IBOutlet weak var gotoHomeButton: UIButton!
    
    @IBOutlet weak var transitionImageView: UIImageView!
    @IBOutlet weak var animationImageView: UIImageView!
    
    @IBOutlet weak var transitionImageViewCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var transitionImageViewCenterYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookingDetailsView.applyCardStyle()
        mainView.alpha = 0
        hotelImageView.clipsToBounds = true
        hotelImageView.layer.cornerRadius = 100
        hotelImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            self.startReverseBloomAnimation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideNavigationBar(animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.showNavigationBar(animated: false)
    }

 
    @IBAction func gotoHomeButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
        self.showNavigationBar(animated: false)
        self.navigationController?.setViewControllers([homeVC], animated: true)
    }
    
    private func startReverseBloomAnimation() {
            let maskLayer = CAShapeLayer()
            animationImageView.layer.mask = maskLayer
 
            let maxDim = max(animationImageView.bounds.width, animationImageView.bounds.height)
            let initialRadius = maxDim / 2 * 1.2
            let finalRadius: CGFloat = 0.0
            let center = CGPoint(x: animationImageView.bounds.midX, y: animationImageView.bounds.midY)
            let initialPath = UIBezierPath(arcCenter: center,
                                           radius: initialRadius,
                                           startAngle: 0,
                                           endAngle: .pi * 2,
                                           clockwise: true).cgPath
 
            let finalPath = UIBezierPath(arcCenter: center,
                                         radius: finalRadius,
                                         startAngle: 0,
                                         endAngle: .pi * 2,
                                         clockwise: true).cgPath
 
            maskLayer.path = initialPath
 
            let pathAnimation = CABasicAnimation(keyPath: "path")
            pathAnimation.fromValue = initialPath
            pathAnimation.toValue = finalPath
        
           pathAnimation.duration = 1.0
        animationImageView.contentMode = .center
            pathAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            pathAnimation.fillMode = .forwards
            pathAnimation.isRemovedOnCompletion = false
            pathAnimation.delegate = self
        pathAnimation.setValue("reverseBloomAnimation", forKey: "animationKey")
            maskLayer.add(pathAnimation, forKey: "reverseBloomAnimation")
        }
    
    private func animateTransitionImageView() {
        self.view.layoutIfNeeded()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.transitionImageViewCenterYConstraint.constant = -130
        } else {
            self.transitionImageViewCenterYConstraint.constant = -162
        }
        UIView.animate(withDuration: 1.5,
                       delay: 0.1,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseOut],
                       animations: {
            
            self.mainView.alpha = 1
            self.transitionImageView.alpha = 1.0
            self.view.layoutIfNeeded()
        }) { _ in
        }
    }
}

extension BookingConformationVC: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            if let animationKey = anim.value(forKey: "animationKey") as? String,
               animationKey == "reverseBloomAnimation" {
                animationImageView.isHidden = true
                animationImageView.layer.mask = nil
                animateTransitionImageView()
                
            }
        }
    }
}
