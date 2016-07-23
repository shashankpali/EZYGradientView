// EZYGradientView.m
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

#import "EZYGradientView.h"

struct EZYPoints
{
  CGPoint start;
  CGPoint end;
};

struct EZYPoints EZYPointsMake(CGPoint start, CGPoint end)
{
  struct EZYPoints e;
  e.start = start;
  e.end = end;
  return e;
}

struct EZYLocations
{
  CGFloat firstColor;
  CGFloat secondColor;
};

struct EZYLocations EZYLocationsMake(CGFloat firstColor, CGFloat secondColor)
{
  struct EZYLocations l;
  l.firstColor = firstColor;
  l.secondColor = secondColor;
  return l;
}

@interface EZYGradientView ()

@property (strong, nonatomic) CAGradientLayer *gradientLayer;

@end

@implementation EZYGradientView

- (void)drawRect:(CGRect)rect
{
  if (_gradientLayer == nil)
  {
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.frame = self.bounds;
    [self.layer insertSublayer:_gradientLayer atIndex:0];
  }
  
  _gradientLayer.colors = @[(id)_firstColor.CGColor, (id)_secondColor.CGColor];
  struct EZYPoints points = [self startEndPoints];
  _gradientLayer.startPoint = points.start;
  _gradientLayer.endPoint = points.end;
  struct EZYLocations locations = [self locations];
  _gradientLayer.locations = @[@(locations.firstColor), @(locations.secondColor)];
}

- (struct EZYPoints)startEndPoints
{
  CGFloat rotCalX = 0.0, rotCalY = 0.0;
  CGFloat rotate = _angleº / 90;
  
  if (rotate <= 1)
  {
    rotCalY = rotate;
  }
  else if (rotate <= 2)
  {
    rotCalY = 1;
    rotCalX = rotate - 1;
  }
  else if (rotate <= 3)
  {
    rotCalX = 1;
    rotCalY = 1 - (rotate - 2);
  }
  else if (rotate <= 4)
  {
    rotCalX = 1 - (rotate - 3);
  }
  
  CGPoint start = CGPointMake(1 - rotCalY, 0 + rotCalX);
  CGPoint end = CGPointMake(0 + rotCalY, 1 - rotCalX);
  
  return EZYPointsMake(start, end);
}

- (struct EZYLocations)locations
{
  CGFloat divider = _fadeIntensity / [self divider];
  return EZYLocationsMake(_colorRatio - divider, _colorRatio + divider);
}

- (CGFloat)divider
{
  if (_colorRatio == 0.1)
  {
    return 10;
  }
  if (_colorRatio < 0.5)
  {
    CGFloat value = 0.5 - _colorRatio + 0.5;
    return 1 / (1 - value);
  }
  return 1 / (1 - _colorRatio);
}

#pragma mark - Properties

- (void)setAngleº:(CGFloat)angleº
{
  _angleº = angleº;
  
  // handle negative angleºs
  if (_angleº < 0.0)
  {
    _angleº = 360.0 + _angleº;
  }
  
  // offset of 45 is needed to make logic work
  _angleº = _angleº + 45;
  
  NSInteger multiplier = _angleº / 360;
  if (multiplier > 0)
  {
    _angleº = _angleº - 360 * multiplier;
  }
}

@end
