#import "FlutterEmbracePlugin.h"
#import <flutter_embrace/flutter_embrace-Swift.h>

@implementation FlutterEmbracePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterEmbracePlugin registerWithRegistrar:registrar];
}
@end
