import SwiftUI
import UIKit

struct ContentView: View {
    @State private var isShowingCamera = false
    @State private var image: UIImage?
    
    var body: some View {
        NavigationView() {
            ZStack {
                Color("BackgroundFix")
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    Text("GliderPal")
                        .font(.largeTitle)
                        .foregroundColor(Color("ColorTitle"))
                        .font(.system(size: 45))
                        .fontWeight(.semibold)
                    Text("Get to know your baby better")
                        .foregroundColor(Color("ColorTitle"))
                        .font(.subheadline)
                    Image("SugarGlider1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 286, height: 197)
                        .padding(EdgeInsets(top: 16, leading: 0, bottom: 75, trailing: 0))
                    
                    Button(action: {
                        isShowingCamera = true
                    }) {
                        Text("Start Scan")
                            .font(.headline)
                            .foregroundColor(Color("BackgroundFix"))
                            .padding()
                            .background(Color("ColorTitle"))
                            .cornerRadius(10)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    
                    NavigationLink(destination: GlidePediaView()) {
                        Text("Glide Pedia")
                            .font(.headline)
                            .foregroundColor(Color("BackgroundFix"))
                            .padding()
                            .background(Color("ColorTitle"))
                            .cornerRadius(10)
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingCamera) {
            ImagePicker(image: $image, sourceType: .camera)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = sourceType
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No need to update the view controller
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

