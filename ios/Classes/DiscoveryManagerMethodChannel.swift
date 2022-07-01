//
//  DiscoveryManager.swift
//  google_cast
//
//  Created by LUIZ FELIPE ALVES LIMA on 30/06/22.
//

import Foundation
import GoogleCast

class FGCDiscoveryManagerMethodChannel : UIResponder, GCKDiscoveryManagerListener, FlutterPlugin{
    
    private override init() {
        
    }
    
    static private let _instance = FGCDiscoveryManagerMethodChannel.init()
    
    static var instance : FGCDiscoveryManagerMethodChannel {
        _instance
    }
    
    private var discoveryManager: GCKDiscoveryManager{
        GCKCastContext.sharedInstance().discoveryManager
    }
    
    var devices : [UInt : GCKDevice] = [:]
    
    var channel : FlutterMethodChannel?
    
    static func register(with registrar: FlutterPluginRegistrar) {
        
        instance.channel = FlutterMethodChannel.init(name: "google_cast.discovery_manager", binaryMessenger: registrar.messenger())
        
        registrar.addMethodCallDelegate(instance, channel: instance.channel!)
        
    }
    
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    
    //MARK: - GCKDiscoveryManagerListener
    
    public func didUpdate(_ device: GCKDevice, at index: UInt) {
        devices[index] = device
    }
    
    public func didInsert(_ device: GCKDevice, at index: UInt) {
        devices[index] = device
    }
    
    public func didRemove(_ device: GCKDevice, at index: UInt) {
        devices.removeValue(forKey: index)
    }
    
    public func didUpdateDeviceList() {
        
        channel!.invokeMethod("onDevicesChanged" , arguments:
                                devices.map{
            deviceMap -> Dictionary<String , Any> in
            let device = deviceMap.value
            var dict =  device.toDict()
            dict["index"] = deviceMap.key
            return dict
        }.sorted{
            a, b in
            let aindex = a["index"] as! Int
            let bIndex = b["index"] as! Int
            return  aindex > bIndex
        })
        
        
        
        
    }
    
}
