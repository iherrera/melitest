import UIKit

//Will use this class to handle the thumb downloads
class DownloadedImage {
    enum ImageStatus{
        case NotInitiated
        case Downloading
        case Downloaded
    }
    var status: ImageStatus = .NotInitiated
    var image: UIImage?
}
