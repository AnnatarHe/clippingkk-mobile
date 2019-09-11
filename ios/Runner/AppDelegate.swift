import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    
    let rootController = window.rootViewController as! FlutterViewController
    let clippingkkChannel = FlutterMethodChannel(name: "com.annatarhe.clippingkk/channel", binaryMessenger: rootController.binaryMessenger)
    
    clippingkkChannel.setMethodCallHandler(self.flutterMethodHandler)
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func flutterMethodHandler(call: FlutterMethodCall, result: FlutterResult) {
        guard call.method == "saveImage" else {
            result(FlutterMethodNotImplemented)
            return
        }
        
        let arg: NSDictionary = call.arguments as! NSDictionary
        
        let image: FlutterStandardTypedData = arg.object(forKey: "image") as! FlutterStandardTypedData
        
        let imgContainer = UIImage(data: image.data)
        
        UIImageWriteToSavedPhotosAlbum(imgContainer!, self, nil, nil)
        
        result(true)
        return
    }
    
    
    
    
 
    
}
