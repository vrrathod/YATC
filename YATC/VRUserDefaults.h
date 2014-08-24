//
//  VRViewControllerProtocol.h
//  YATC
//
//  Created by personal on 8/23/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import <Foundation/Foundation.h>
/*! 
 Defines methods to check serialization of the last tip amount
 */

@protocol VRUserDefaults <NSObject>
// ---- Methods
- (BOOL) shouldSaveTip ;
- (void) saveLastTipValue ;
- (void) removeLastTipeValue ;
- (void) checkAndCreateLastTipKey;
- (Float32) lastTipValue;

@end
