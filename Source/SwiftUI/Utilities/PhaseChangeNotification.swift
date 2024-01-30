import Foundation
import SwiftUI

public extension Notification.Name {
    static let phaseChangeNotification = Notification.Name("phaseChangeNotification")
}

public extension View {
    /// Wraps a listener to centralice all change of phases.
    ///  You need to add to the main .onChange() the post of the notification `phaseChangeNotification` into `NotificationCenter`.
    ///  ```
    ///  .onChange(of: scenePhase) { phase in
    ///     NotificationCenter.default.post(
    ///        name: .phaseChangeNotification,
    ///        object: phase
    ///     )
    ///  }
    ///  ```
    func onPhaseChange(_ action: @escaping (ScenePhase) -> Void) -> some View {
        onReceive(NotificationCenter.default.publisher(for: .phaseChangeNotification)) { notification in
            if let phase = notification.object as? ScenePhase {
                action(phase)
            } else {
                fatalError("You need to pass the phase object with the notification.")
            }
        }
    }
}
