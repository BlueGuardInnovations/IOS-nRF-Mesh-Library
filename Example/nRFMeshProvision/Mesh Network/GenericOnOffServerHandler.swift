//
//  GenericOnOffServerHandler.swift
//  nRFMeshProvision_Example
//
//  Created by Aleksander Nowakowski on 01/10/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import nRFMeshProvision

class GenericOnOffServerHandler: ModelHandler {
    let messageTypes: [UInt32 : MeshMessage.Type]
    
    private(set) var isOn: Bool = false
    
    init() {
        let types: [GenericMessage.Type] = [
            GenericOnOffGet.self,
            GenericOnOffSet.self,
            GenericOnOffSetUnacknowledged.self
        ]
        messageTypes = types.toMap()
    }
    
    // MARK: - Message handlers
    
    func handle(acknowledgedMessage request: AcknowledgedMeshMessage,
                sentFrom source: Address, to model: Model) -> MeshMessage {
        switch request {
        case let request as GenericOnOffSet:
            isOn = request.isOn
            fallthrough
        default:
            return GenericOnOffStatus(isOn)
        }
    }
    
    func handle(unacknowledgedMessage message: MeshMessage,
                sentFrom source: Address, to model: Model) {
        switch message {
        case let request as GenericOnOffSetUnacknowledged:
            isOn = request.isOn
        default:
            break
        }
    }
    
    func handle(response: MeshMessage, toAcknowledgedMessage request: AcknowledgedMeshMessage,
                sentFrom source: Address, to model: Model) {
        // Not possible.
    }
    
}
