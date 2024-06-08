//
//  PDFSubmitView.swift
//  kfump
//
//  Created by Mehedi Hasan on 2/6/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct PDFSubmitView: View {
    
    @State private var isHovered = false
    @StateObject var courseDetailsViewModel = OngoingCourseDetailsViewModel()
    @State private var isActionSheetPresented = false
    @State private var isDocumentPickerPresented = false
    @State private var isImagePickerPresented = false
    @State private var selectedFileURL: URL? = nil
    @State private var selectedImage = UIImage()
    @State private var showTost = false
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var nextPosition : Int
    
    let url: String!
    let lectureId: Int!
    
    var body: some View {
        
        ZStack {
            VStack {
                PDFViewWrapper(url: URL(string: url)!)
                    .edgesIgnoringSafeArea(.all)
                
                
                uploadView
                    .onTapGesture {
                        isActionSheetPresented = true
                    }
                    .sheet(isPresented: $isActionSheetPresented) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$selectedImage)
                    }
                    .onChange(of: selectedImage) { newData in
                        uploadProfileImage()
                    }
//                    .actionSheet(isPresented: $isActionSheetPresented) {
//                        ActionSheet(
//                            title: Text("Select a file"),
//                            buttons: [
//                                .default(Text("Select Document")) {
//                                    isDocumentPickerPresented = true
//                                },
//                                .default(Text("Select Image or Video")) {
//                                    isImagePickerPresented = true
//                                },
//                                .cancel()
//                            ]
//                        )
//                    }
//                    .sheet(isPresented: $isDocumentPickerPresented) {
//                        DocumentPickerView(selectedFileURL: $selectedFileURL)
//                    }
//                    .sheet(isPresented: $isImagePickerPresented) {
//                        ImagePickerView(selectedFileURL: $selectedFileURL)
//                    }
//                    .onChange(of: selectedFileURL) { newData in
//                        uploadProfileImage()
//                    }
                
                submitButtonView
                    .padding(.top,10)
                    .padding(.bottom,20)
            }
            
            if courseDetailsViewModel.isLoading {
                CustomProgressView()
            }
            
            ToastView(isPresented: $showTost, duration: 2.0) {
                CustomTost(message: "Please upload a File")
            }
            
        }
        
        .background(isHovered ? Color.gray.opacity(0.1) : Color.clear)
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .navigationBarItems(leading: CustomTitleBarItems(title: "Assignment Submit"))
        .navigationBarColor(backgroundColor: hexToColor(hex: "#F9F9F7"), titleColor: .white)
        
    }
    
    var uploadView: some View {
        VStack {
            Text("Submit Assignment")
                .font(.custom(FONT_SEMIBOLD, size: 18))
                .frame(maxWidth: .infinity,alignment: .leading)
                .foregroundColor(.black)
                .padding(.horizontal,20)
            
            
            VStack {
                Image("ic_file_upload")
                    .font(.system(size: 50))
                    .foregroundColor(.yellow)
                    .padding(.bottom, 10)
                
                Text("Select a file to upload")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text("or drag and drop it here")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 165)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
                    .foregroundColor(hexToColor(hex: "#E5E5D9"))
            )
            .onHover { hovering in
                isHovered = hovering
            }
            .padding(.horizontal)
            .padding(.top,10)
        }
        
    }
    
    var submitButtonView: some View {
        
        HStack {
            
            Button(action: {
                
                var vm = AssignmentSubmitRequestModel(lecture_id: lectureId,
                                                      assignment_submit_info: AssignmentSubmitInfo(file: courseDetailsViewModel.filePath))
                
                if courseDetailsViewModel.filePath == "" {
                    showTost = true
                    return
                }
                
                print("vm")
                courseDetailsViewModel.submitAssignment(vm) { result in
                    if result {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                    }
                }
                
            }) {
                HStack {
                    Text("Submit")
                        .padding(.vertical,10)
                        .font(.custom(FONT_SEMIBOLD, size: 16))
                        .foregroundColor(hexToColor(hex: "#007D40"))
                    
                }
                
            }
            .frame(width: 100, height: 45)
            .background(.white)
            .cornerRadius(22)
            .overlay {
                RoundedRectangle(cornerRadius: 22)
                    .stroke(hexToColor(hex: "#007D40"), lineWidth: 2)
            }
            .padding(.leading,25)
            
            Spacer()
            
            HStack {
                Text("Next")
                    .font(.custom(FONT_SEMIBOLD, size: 16))
                    .foregroundColor(hexToColor(hex: "#007D40"))
                
                Image(isRTL ? "ic_next_ar"  : "ic_next")
                    .resizable()
                    .frame(width: 20,height: 20)
            }
            .onTapGesture {
                nextPosition = nextPosition + 1
                presentationMode.wrappedValue.dismiss()
            }
            .padding(.trailing,25)
        }
        .padding(.top)
    }
    
    func uploadProfileImage() {
        
        do {
//            let fileData = try Data(contentsOf: selectedFileURL!)
            let parameter : [String : Any] = [
                "file"          :  selectedImage
            ]
            
            print("parameter \(parameter)")
            courseDetailsViewModel.fileUpload(parameter: parameter)
            
            print("File parameter set: \(parameter)")
        } catch {
            print("Failed to read file data: \(error.localizedDescription)")
        }
        
    }
    
}

//#Preview {
//    PDFSubmitView()
//}

//struct FileUploadView_Previews: PreviewProvider {
//    static var previews: some View {
//        PDFSubmitView()
//            .frame(width: 300, height: 200)
//    }
//}

//
//struct DocumentPickerView: UIViewControllerRepresentable {
//    @Binding var selectedFileURL: URL?
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
//        let supportedTypes: [UTType] = [.pdf, .png, .log, .mpeg4Movie]
//        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
//        documentPicker.delegate = context.coordinator
//        return documentPicker
//    }
//    
//    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
//    
//    class Coordinator: NSObject, UIDocumentPickerDelegate {
//        var parent: DocumentPickerView
//        
//        init(_ parent: DocumentPickerView) {
//            self.parent = parent
//        }
//        
//        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//            parent.selectedFileURL = urls.first
//        }
//    }
//}

