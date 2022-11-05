//
//  ViewModel.swift
//  proxumer
//
//  Created by Macbook-BOIT on 3/11/2565 BE.
//

import Foundation
import RxSwift

protocol ViewProtocolInput {
  func fetchData()
}

protocol ViewProtocolOutput {
  var didSuccess: PublishSubject<Void> { get set }
}

protocol ViewProtocol: ViewProtocolInput, ViewProtocolOutput {
  var input: ViewProtocolInput { get }
  var output: ViewProtocolOutput { get }
}

class ViewModel: ViewProtocol {
  var input: ViewProtocolInput { return self }
  var output: ViewProtocolOutput { return self }
  
  var didSuccess: PublishSubject<Void> = PublishSubject<Void>()
  var socket = NetworkServiceHandler.shared.getSocket()
  
  init() {
  }
}

extension ViewModel : ViewProtocolInput {
  func fetchData() {
    NetworkServiceHandler.shared.connect()
    socket.on("new-notification") {(data, ack) -> Void in
      print("data received")
      self.didSuccess.onNext(())
    }
  }
}
