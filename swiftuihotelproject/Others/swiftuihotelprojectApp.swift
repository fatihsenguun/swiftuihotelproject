import SwiftUI
import FirebaseCore

@main
struct swiftuihotelprojectApp: App {
    init() {
        FirebaseApp.configure()   
    }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
