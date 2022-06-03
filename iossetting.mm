#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>
#include "iossetting.h"

    void setTimerDisabled() {
        [UIApplication sharedApplication].idleTimerDisabled = YES;
    }
