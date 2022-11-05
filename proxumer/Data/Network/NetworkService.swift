//
//  NetworkService.swift
//  proxumer
//
//  Created by Macbook-BOIT on 3/11/2565 BE.
//

import Foundation
import SocketIO

public class NetworkServiceHandler: NSObject {
  static let shared = NetworkServiceHandler()
  let manager = SocketManager(socketURL: URL(string: "wss://px-socket-api.herokuapp.com/")!)
  var socket: SocketIOClient!
  
  override init() {
    super.init()
    socket = manager.defaultSocket
  }
  
  func getSocket() -> SocketIOClient {
    return socket
  }
  
  func connect() {
    socket.connect()
  }
}
