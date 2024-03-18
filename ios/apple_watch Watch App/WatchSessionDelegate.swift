//
//  WatchSessionDelegate.swift
//  apple_watch Watch App
//
//  Created by Han Gyi on 13/03/2024.
//

import Foundation
import WatchConnectivity

class WatchSessionDelegate : NSObject, ObservableObject, WCSessionDelegate{
   
    
    private let session = WCSession.default
    @Published var log = [String]()
    @Published var receivedContext = [String: Any]()
    
    override init() {
        super.init()
        session.delegate = self
        session.activate()
    }
   
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        refresh()
    }
   
    //send message
    func sendMessage(_ message:String){
        let _sendMessage = ["data": message]
        session.sendMessage(_sendMessage, replyHandler: nil)
        log.append("<-: \(_sendMessage)")
        
    }
    
    //receive message
    //refresh
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.log.append(" Message: \(message)")
        }
    }
    
    func refresh(){
        receivedContext = session.receivedApplicationContext
    }
    
    
}
