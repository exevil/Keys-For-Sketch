//
//  KeysForSketch
//
//  Created by Vyacheslav Dubovitsky on 12/04/2017.
//  Copyright © 2017 Vyacheslav Dubovitsky. All rights reserved.
//

// Return principal class used to start an initialization process.
function principalClass() {
    return NSClassFromString("KeysForSketch.Keys")
}

// Load framework and start initialization process if needed.
function startKeys(context) {
    if (principalClass() == null || principalClass().isLoaded == false) {
        var mocha = Mocha.sharedRuntime()
        var resourcesFolder = context.scriptPath.stringByDeletingLastPathComponent().stringByDeletingLastPathComponent() + "/Resources"
        if (mocha.loadFrameworkWithName_inDirectory("KeysForSketch", resourcesFolder)) {
            principalClass().start()
        }
    }
}
