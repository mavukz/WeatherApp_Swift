import SwiftUI

extension Image {
    init(imageName: ImageName) {
        self.init(imageName.rawValue)
    }
}

enum ImageName: String {
    case rain
    case clear
    case partlySunny
}
