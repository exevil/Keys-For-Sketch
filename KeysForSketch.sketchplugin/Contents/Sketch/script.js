//
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 12/04/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

function startKeys(context) {
    if (NSClassFromString("VDKeys") == null) {
        var mocha = Mocha.sharedRuntime()
        var resourcesFolder = context.scriptPath.stringByDeletingLastPathComponent().stringByDeletingLastPathComponent() + "/Resources"
        if (mocha.loadFrameworkWithName_inDirectory("KeysForSketch", resourcesFolder)) {
            VDKeys.start()
        }
    }
}

