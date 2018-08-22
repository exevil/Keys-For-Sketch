//
//  SketchAPI.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 07/09/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

public class SketchAPITools: NSObject {
    
    /// Array of protocols that represents Sketch Classes.
    /// - important: Please strictly use `VDKSketch` prefix and `Protocol` suffix in protocol naming to correctly determine original name of the class that protocol should belongs to.
    @objc public static let protocols: [Protocol] = [
        VDKSketchAppControllerProtocol.self,
        VDKSketchMSPreferencesControllerProtocol.self,
        VDKSketchMSKeyBindingsProtocol.self,
        // Document
        VDKSketchMSDocumentControllerProtocol.self,
        VDKSketchMSDocumentProtocol.self,
        VDKSketchMSDocumentDataProtocol.self,
        VDKSketchMSActionControllerProtocol.self,
        // Layers
        VDKSketchMSLayerArrayProtocol.self,
        VDKSketchMSPageProtocol.self,
        VDKSketchMSArtboardGroupProtocol.self,
        VDKSketchMSLayerGroupProtocol.self,
        VDKSketchMSLayerProtocol.self,
    ];
    
    /// Inject API protocols to its corresponding Sketch classes at runtime to allow an easy casting to API protocols in Swift.
    /// - important: Protocol injections should be used only after API testing to avoid unexpected behaviours.
    @objc public static func injectAPIProtocols() throws {
        for prt in protocols {
            do {
                let cls: AnyClass = try sketchClass(from: prt)
                try add(protocol: prt, to: cls)
            } catch {
                throw error
            }
        }
    }
    
    /// Add protocol to class at runtime.
    @objc public static func add(`protocol` prt: Protocol, to cls: AnyClass) throws {
        guard class_addProtocol(cls, prt) else {
            throw Error.cantAdd(protocol: prt, toClass: cls)
        }
    }
    
    /// Define Sketch class name based on its corresponding API protocol.
    @objc public static func sketchClass(from prt:Protocol) throws -> AnyClass {
        let prtName = String(cString: protocol_getName(prt))

        // Check and remove suffix and prefix of protocol name to define a class name
        let prtNamePrefix = "VDKSketch"
        let prtNameSuffix = "Protocol"
        assert(prtName.hasPrefix(prtNamePrefix) && prtName.hasSuffix(prtNameSuffix), "")
        let clsName = String(prtName.dropFirst(prtNamePrefix.count).dropLast(prtNameSuffix.count))

        // Define and return a class itself
        guard let cls = NSClassFromString(clsName) else {
            throw Error.cantDetermineClassFrom(protocol: prt)
        }
        return cls
    }
    
    /// Sketch API errors.
    enum Error: LocalizedError {
        
        case cantDetermineClassFrom(protocol: Protocol)
        case cantAdd(protocol: Protocol, toClass: AnyClass)
        
        var errorDescription: String? {
            switch self {
            case .cantDetermineClassFrom(let prt):
                return "Can't determine class from protocol: \"\(prt)\"."
            case .cantAdd(let prt, let cls):
                return "Can't add API protocol: \"\(prt)\" to its corresponding class: \"\(cls)\"."
            }
        }
    }
}
