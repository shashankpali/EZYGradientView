// EZYGradientView.swift
//
// Copyright (c) 2016 Shashank Pali
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

@IBDesignable

public class EZYGradientView: UIView
{
  /// Select color to create gradients
  @IBInspectable public var firstColor: UIColor = UIColor.whiteColor()
  @IBInspectable public var secondColor: UIColor = UIColor.whiteColor()
  
  /// Angle will decide tilt of gradient line
  @IBInspectable public var angleº: Float = 45.0
    {
    didSet
    {
      // handle negative angles
      if angleº < 0.0 {
        angleº = 360.0 + angleº
      }
      
      // offset of 45 is needed to make logic work
      angleº = angleº + 45
      
      let multiplier = Int(angleº / 360)
      if (multiplier > 0)
      {
        angleº = angleº - Float(360 * multiplier)
      }
    }
  }
  
  /// Color ratio will decide the proportion of colors
  @IBInspectable public var colorRatio: Float = 0.5
    {
    didSet
    {
      assert(colorRatio >= 0 || colorRatio <= 1, "Color Ratio: Valid range is from 0.0 to 1.0")
    }
  }
  
  /// Fade intensity will allow colors to get dispersed
  @IBInspectable public var fadeIntensity: Float = 0.0
    {
    didSet
    {
      assert(colorRatio >= 0 || colorRatio <= 1, "Fade Intensity: Valid range is from 0.0 to 1.0")
    }
  }
  
  private var gradientLayer: CAGradientLayer?
  
  override public func drawRect(rect: CGRect)
  {
    if gradientLayer == nil
    {
      gradientLayer = CAGradientLayer()
      gradientLayer!.frame = self.bounds
      layer.insertSublayer(gradientLayer!, atIndex: 0)
    }
    gradientLayer!.colors = [firstColor.CGColor, secondColor.CGColor]
    
    let points = startEndPoints()
    gradientLayer!.startPoint = points.0
    gradientLayer!.endPoint = points.1
    
    let colorLoc = locations()
    gradientLayer!.locations = [colorLoc.0, colorLoc.1]
  }
  
  //MARK: - Start and end point calculator
  private func startEndPoints() -> (CGPoint, CGPoint)
  {
    var rotCalX: Float = 0.0
    var rotCalY: Float = 0.0
    
    // to convert from 0...360 range to 0...4
    let rotate = angleº / 90
    
    // 1...4 can be understood to denote the four quadrants
    if rotate <= 1
    {
      rotCalY = rotate
    }
    else if rotate <= 2
    {
      rotCalY = 1
      rotCalX = rotate - 1
    }
    else if rotate <= 3
    {
      rotCalX = 1
      rotCalY = 1 - (rotate - 2)
    }
    else if rotate <= 4
    {
      rotCalX = 1 - (rotate - 3)
    }
    
    let start = CGPointMake(1 - CGFloat(rotCalY), 0 + CGFloat(rotCalX))
    let end = CGPointMake(0 + CGFloat(rotCalY), 1 - CGFloat(rotCalX))
    
    return (start, end)
  }
  
  //MARK: - Calculate the colors' location
  private func locations() -> (Float, Float)
  {
    let divider = fadeIntensity / self.divider()
    return(colorRatio - divider, colorRatio + divider)
  }
  
  private func divider() -> Float
  {
    if colorRatio == 0.1
    {
      return 10
    }
    if colorRatio < 0.5
    {
      let value = 0.5 - colorRatio + 0.5
      return 1 / (1 - value)
    }
    return 1 / (1 - colorRatio)
  }
}
