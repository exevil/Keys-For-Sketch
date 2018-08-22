//
//  SketchAPI.swift
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 06/08/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

/// Runtime test Sketch classes for conformance to corresponding Keys API protocols.
public class SketchAPIProtocolsTest: NSObject {
    
    /// Array of protocols that represents Sketch Classes.
    static let protocols: [Protocol] = VDKSketchAPI.protocols
    
    /// Runtime test Sketch classes for conformance to corresponding Keys API protocols.
    @objc public static func testProtocols() throws {
        for prt in protocols {
            let cls: AnyClass
            do { cls = try SketchAPITools.sketchClass(from: prt) }
            catch { throw error }

            // Test that class responds to protocol instance methods
            var methodsCount: UInt32 = 0;
            if let instanceMethods = protocol_copyMethodDescriptionList(prt, true, true, &methodsCount) {
                for i in 0..<Int(methodsCount) {
                    let methodDescription = instanceMethods[i]
                    guard let sel = methodDescription.name else { throw Error.cantGetSelectorFrom(methodDescription) }
                    guard class_respondsToSelector(cls, sel) else { throw Error.instance(of: cls, notRespondsTo: sel) }
                }
                free(instanceMethods)
            }
            
            // Test that class responds to protocol class methods
            methodsCount = 0;
            if let classMethods = protocol_copyMethodDescriptionList(prt, true, false, &methodsCount) {
                for i in 0..<Int(methodsCount) {
                    let methodDescription = classMethods[i]
                    guard let sel = methodDescription.name else { throw Error.cantGetSelectorFrom(methodDescription) }
                    guard class_getClassMethod(cls, sel) != nil else { throw Error.class(cls, notRespondsTo: sel) }
                }
                free(classMethods)
            }
        }
    }
    
    /// Test Error types.
    enum Error: LocalizedError {
        
        case cantGetSelectorFrom(objc_method_description)
        case instance(of: AnyClass, notRespondsTo: Selector)
        case `class`(AnyClass, notRespondsTo: Selector)
        
        var errorDescription: String? {
            switch self {
            case .cantGetSelectorFrom(let methodDescription):
                return "Can't get selector from method description: \"\(methodDescription)\"."
            case .instance(let cls, let sel):
                return "Instance of \"\(cls)\" is not responding to selector: \"\(sel)\"."
            case .`class`(let cls, let sel):
                return "Class \"\(cls)\" is not responding to selector: \"\(sel)\"."
            }
        }
    }
}
