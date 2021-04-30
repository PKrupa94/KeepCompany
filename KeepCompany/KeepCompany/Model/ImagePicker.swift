
import SwiftUI
import Firebase
import Combine

struct ImagePicker : UIViewControllerRepresentable {
    
    @Binding var picker : Bool
    @Binding var imagedata : Data
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        
        return ImagePicker.Coordinator(parent1: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    class Coordinator : NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        
        var parent : ImagePicker
        
        init(parent1 : ImagePicker) {
            
            parent = parent1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            self.parent.picker.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            
            let image = info[.originalImage] as! UIImage
            
            let data = image.jpegData(compressionQuality: 0.45)
            
            self.parent.imagedata = data!
            
            self.parent.picker.toggle()
        }
    }
}



//class ImagePicker: ObservableObject {
//    static let shared: ImagePicker = ImagePicker()
//    private init() {}
//
//    let view = ImagePicker.View()
//    let coordinator = ImagePicker.Coordinator()
//
//    let willChange = PassthroughSubject<Image?, Never>()
//    @Published var image:Image? = nil {
//
//        didSet{ if image != nil {
//            willChange.send(image)
//        }
//        }
//    }
//
//}
//
//extension ImagePicker {
//
//    class Coordinator: NSObject, UINavigationControllerDelegate,
//                       UIImagePickerControllerDelegate {
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            picker.dismiss(animated: true)
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController,
//                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
//        {
//            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//
//            ImagePicker.shared.image = Image(uiImage: image)
//            picker.dismiss(animated: true)
//
//
//        }
//
//    }
//}
//
//
//
//extension ImagePicker {
//    struct View: UIViewControllerRepresentable {
//
//        func makeCoordinator() -> Coordinator {
//            return ImagePicker.shared.coordinator
//        }
//
//
//
//        func makeUIViewController(context:
//                                    UIViewControllerRepresentableContext<ImagePicker.View>) ->
//        UIImagePickerController {
//            let imagePickerController = UIImagePickerController()
//            imagePickerController.delegate = context.coordinator
//            return imagePickerController
//        }
//
//        func updateUIViewController(_ uiViewController: UIImagePickerController,
//                                    context: UIViewControllerRepresentableContext<ImagePicker.View>) {
//
//        }
//    }
//}







