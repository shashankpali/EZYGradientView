//
//  ViewController.swift
//  EZYGradientView
//
//  Created by Shashank on 21/07/16.
//  Copyright © 2016 Shashank. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
  @IBOutlet weak var gradientView: EZYGradientView!
  @IBOutlet weak var refView: UIView!
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    customizeGradientView()
  }
  
  override func viewDidAppear(animated: Bool)
  {
    super.viewDidAppear(animated)
    addline()
  }
  
  override func prefersStatusBarHidden() -> Bool
  {
    return true
  }
  
  func addline()
  {
    let aPath = UIBezierPath()
    
    aPath.moveToPoint(CGPointMake(CGRectGetMinX(gradientView.layer.bounds), CGRectGetMidY(gradientView.layer.bounds)))
    aPath.addLineToPoint(CGPointMake(CGRectGetMaxX(gradientView.layer.bounds), CGRectGetMidY(gradientView.layer.bounds)))
    aPath.moveToPoint(CGPointMake(CGRectGetMidX(gradientView.layer.bounds), CGRectGetMidY(gradientView.layer.bounds) - 10))
    aPath.addLineToPoint(CGPointMake(CGRectGetMidX(gradientView.layer.bounds), CGRectGetMidY(gradientView.layer.bounds) + 10))
    
    let shape = CAShapeLayer()
    shape.path = aPath.CGPath
    shape.strokeColor = UIColor.redColor().CGColor
    shape.lineWidth = 1.5
    gradientView.layer.addSublayer(shape)
  }
  
  func customizeGradientView()
  {
    let secondGradientView = EZYGradientView()
    secondGradientView.frame = refView.bounds
    
    secondGradientView.firstColor = UIColor(red: 0.5, green: 0.0, blue: 1.0, alpha: 1.0)
    secondGradientView.secondColor = UIColor(red: 0.4, green: 1.0, blue: 0.8, alpha: 1.0)
    secondGradientView.angleº = 185.0
    secondGradientView.colorRatio = 0.5
    secondGradientView.fadeIntensity = 1
    secondGradientView.isBlur = true
    secondGradientView.blurOpacity = 0.5
    
    refView.insertSubview(secondGradientView, atIndex: 0)
  }
  
}
