//
//  SwiftQRCodeVC.swift
//
//  Created by Freddy Mendez on 20/02/08.
//  Copyright © 2020 Freddy Mendez. All rights reserved.
//

import UIKit
import AVFoundation

private let scanAnimationDuration = 3.0
private let needSound = true
private let scanWidth : CGFloat = 300
private let scanHeight : CGFloat = 300
private let isRecoScanSize = true
private let scanBoxImagePath = "QRCode_ScanBox" //Scan frame picture
private let scanLineImagePath = "QRCode_ScanLine" //Scan line picture
private let soundFilePath = "noticeMusic.caf" //sound file

class SwiftQRCodeVC: UIViewController{
    
    var scanPane: UIImageView!///Scan frame
    var scanPreviewLayer : AVCaptureVideoPreviewLayer! //Preview layer
    var output : AVCaptureMetadataOutput!
    var scanSession :  AVCaptureSession?
    
    lazy var scanLine : UIImageView = {
            let scanLine = UIImageView()
            scanLine.frame = CGRect(x: 0, y: 0, width: scanWidth, height: 3)
            scanLine.image = UIImage(named: scanLineImagePath)
            return scanLine
            
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //Initialization interface
        self.initView()
        
        //Initialize ScanSession
        setupScanSession()
    }
    
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        startScan()
    }
    
    //Initialization interface
    func initView()  {
        scanPane = UIImageView()
        scanPane.frame = CGRect(x: 300, y: 100, width: 400, height: 400)
        scanPane.image = UIImage(named: scanBoxImagePath)
        self.view.addSubview(scanPane)
        
        //Increase constraints
        addConstraint()
        
        scanPane.addSubview(scanLine)
    }
    
    //Scan completion callback
    func qrCodeCallBack(_ codeString : String?) {
        self.confirm(title: "Scan results", message: codeString, controller: self,handler: { (_) in
            //Continue scanning
            self.startScan()
        })
    }
    
    func addConstraint() {
        scanPane.translatesAutoresizingMaskIntoConstraints = false
        //Create constraints
        
        let widthConstraint = NSLayoutConstraint(item: scanPane, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: scanWidth)
        let heightConstraint = NSLayoutConstraint(item: scanPane, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: scanHeight)
        let centerX = NSLayoutConstraint(item: scanPane, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0)
        let centerY = NSLayoutConstraint(item: scanPane, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        //Add multiple constraints
        view.addConstraints([widthConstraint,heightConstraint,centerX,centerY])
    }
    
    
    func setupScanSession(){
        
        do{
            //Set up capture device
            let device = AVCaptureDevice.default(for: AVMediaType.video)!
            //Set device input and output
            let input = try AVCaptureDeviceInput(device: device)
            
            let output = AVCaptureMetadataOutput()
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            self.output = output
            
            //Set up a session
            let  scanSession = AVCaptureSession()
            scanSession.canSetSessionPreset(.high)
            
            if scanSession.canAddInput(input){
                scanSession.addInput(input)
            }
            
            if scanSession.canAddOutput(output){
                scanSession.addOutput(output)
            }
            
            //Set scan type (QR code and barcode)
            output.metadataObjectTypes = [
                .qr,
                .code39,
                .code128,
                .code39Mod43,
                .ean13,
                .ean8,
                .code93
            ]
            //Preview layer
            let scanPreviewLayer = AVCaptureVideoPreviewLayer(session:scanSession)
            scanPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            scanPreviewLayer.frame = view.layer.bounds
            self.scanPreviewLayer = scanPreviewLayer
            
            setLayerOrientationByDeviceOritation()
            
            //Save session
            self.scanSession = scanSession
            
        }catch{
            //Camera is unavailable
            self.confirm(title: "Tips", message: "Camera is unavailable", controller: self)
            return
        }
        
    }
    
    func setLayerOrientationByDeviceOritation() {
        if(scanPreviewLayer == nil){
            return
        }
        scanPreviewLayer.frame = view.layer.bounds
        view.layer.insertSublayer(scanPreviewLayer, at: 0)
        let screenOrientation = UIDevice.current.orientation
        if(screenOrientation == .portrait){
            scanPreviewLayer.connection?.videoOrientation = .portrait
        }else if(screenOrientation == .landscapeLeft){
            scanPreviewLayer.connection?.videoOrientation = .landscapeRight
        }else if(screenOrientation == .landscapeRight){
            scanPreviewLayer.connection?.videoOrientation = .landscapeLeft
        }else if(screenOrientation == .portraitUpsideDown){
            scanPreviewLayer.connection?.videoOrientation = .portraitUpsideDown
        }else{
            scanPreviewLayer.connection?.videoOrientation = .portrait
        }
        
        //Set the scan area
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil, queue: nil, using: { (noti) in
            if(isRecoScanSize){
                self.output.rectOfInterest = self.scanPreviewLayer.metadataOutputRectConverted(fromLayerRect: self.scanPane.frame)
            }else{
                self.output.rectOfInterest = CGRect(x: 0, y: 0, width: 1, height: 1)
            }
        })
    }

    //Re-layout after device rotation
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setLayerOrientationByDeviceOritation()
    }
    
    //Start scanning
    fileprivate func startScan(){
        
        scanLine.layer.add(scanAnimation(), forKey: "scan")
        guard let scanSession = scanSession else { return }
        if !scanSession.isRunning
        {
            scanSession.startRunning()
        }
    }
    
    //Scan animation
    private func scanAnimation() -> CABasicAnimation{
        
        let startPoint = CGPoint(x: scanLine .center.x  , y: 1)
        let endPoint = CGPoint(x: scanLine.center.x, y: scanHeight - 2)
        
        let translation = CABasicAnimation(keyPath: "position")
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        translation.fromValue = NSValue(cgPoint: startPoint)
        translation.toValue = NSValue(cgPoint: endPoint)
        translation.duration = scanAnimationDuration
        translation.repeatCount = MAXFLOAT
        translation.autoreverses = true
        
        return translation
    }
    
    //MARK: -
    //MARK: Dealloc
    deinit{
        ///Remove notification
        NotificationCenter.default.removeObserver(self)
    }
    
}


//MARK: -
//MARK: AVCaptureMetadataOutputObjects Delegate
extension SwiftQRCodeVC : AVCaptureMetadataOutputObjectsDelegate
{
    
    
    //Capture scan results
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        //Stop scanning
        self.scanLine.layer.removeAllAnimations()
        self.scanSession!.stopRunning()
        
        //Play sound
        if(needSound){
            self.playAlertSound()
        }
        
        //Scan completed
        if metadataObjects.count > 0 {
            if let resultObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject{
                self.qrCodeCallBack(resultObj.stringValue)
            }
        }
    }
    
    //Confirmation box pops up
    func confirm(title:String?,message:String?,controller:UIViewController,handler: ( (UIAlertAction) -> Swift.Void)? = nil){
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let entureAction = UIAlertAction(title: "determine", style: .destructive, handler: handler)
        alertVC.addAction(entureAction)
        controller.present(alertVC, animated: true, completion: nil)
        
    }
    
    //Play sound
    func playAlertSound(){
        guard let soundPath = Bundle.main.path(forResource: soundFilePath, ofType: nil)  else { return }
        guard let soundUrl = NSURL(string: soundPath) else { return }
        var soundID:SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundUrl, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
}



