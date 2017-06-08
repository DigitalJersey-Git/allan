//
//  touchExample.swift
//  JerseyWweather
//
//  Created by Allan Pister on 08/06/2017.
//  Copyright © 2017 MulgaKittyProductions. All rights reserved.
//

import UIKit

class touchExample: UIViewController {

    @IBOutlet weak var monsterImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monsterImage.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapSelect(_:)))
        monsterImage.addGestureRecognizer(tapGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action:#selector(self.pinchRecognized(_:)))
        monsterImage.addGestureRecognizer(pinchGesture)
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(self.rotateRecognized(_:)))
        monsterImage.addGestureRecognizer(rotateGesture)
    }
    
    func rotateRecognized(_ sender: UIRotationGestureRecognizer) {
        var lastRotation = CGFloat()
        //self.view.bringSubview(toFront: viewRotate)
        if(sender.state == UIGestureRecognizerState.ended){
            lastRotation = 0.0;
        }
        let rotation = 0.0 - (lastRotation - sender.rotation)
        // var point = rotateGesture.location(in: viewRotate)
        let currentTrans = monsterImage.transform
        let newTrans = currentTrans.rotated(by: rotation)
        
        monsterImage.transform = newTrans
        //lastRotation = sender.rotation
    }

    func tapSelect(_ sender: UITapGestureRecognizer) {
        self.bounce(view: monsterImage)
    }
    
    func pinchRecognized(_ sender: UIPinchGestureRecognizer) {
        monsterImage.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }
    
    func bounce(view: UIView) {
        view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 3.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        view.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }  )
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
