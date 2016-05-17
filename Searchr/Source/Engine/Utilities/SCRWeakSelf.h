//
//  SCRWeakSelf.h
//  Searchr
//
//  Created by Merrick Sapsford on 02/04/2016.
//  Copyright © 2016 Merrick Sapsford. All rights reserved.
//

#define SCRWeakSelfCreate __typeof__(self) __weak weakSelf = self

#define SCRStrongSelfStart if (self) {__typeof__(weakSelf) __strong strongSelf = weakSelf;
#define SCRStrongSelfEnd }
