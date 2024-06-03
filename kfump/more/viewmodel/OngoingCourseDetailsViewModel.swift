//
//  OngoingCourseDetailsViewModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 25/5/24.
//

import Foundation
import Combine
import SwiftUI


class OngoingCourseDetailsViewModel : ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    private let networkClient : NetworkClientForMultipart
    
    @Published var isLoading = false
    @Published var isFileLoading = false
    @Published var isGetCourseActualData = false
    @Published var isLoadingBySearchKey = false
    @Published var error: Error?
    @Published var showingDialogAlert = false
    @Published var dialogMessage = ""
    @Published var isSucess = false
    
    private let courseService: CourseService
    
    @Published var ongoingCourse : OngoingCourseDetailsResponseModel?
    @Published var quizeList: [TraineeSubmission] = []
    @Published var answers: [String] = []
    @Published var filePath: String = ""
    
    init(courseService: CourseService = CourseService(),networkClient: NetworkClientForMultipart = NetworkClientForMultipart()) {
        self.networkClient = networkClient
        self.courseService = courseService
    }
    
    deinit {
        cancellables.removeAll()
    }
    
//    func createReportedIssue(body: ReportedAnIssueRequestModel, completion: @escaping (Bool) -> Void) {
//        isLoading = true
//        courseService.createReportedIssue(body)
//            .handleEvents(receiveCompletion: { [weak self] value in
//                self?.isLoading = false
//            })
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print("error \(error)")
//                    self.error = error
//                    self.showingDialogAlert = true
//                    self.dialogMessage = error.localizedDescription
//                }
//            }, receiveValue: { [weak self] user in
//                self?.isLoading = false
//                if user.details != nil && ((user.details?.count ?? 0) > 0) {
//                    self?.dialogMessage = (user.details?[0].path == "Password") ? ("\(user.details?[0].path ?? "") : " + (user.details?[0].message ?? "")) : (user.details?[0].message ?? "")
//                } else {
//                    self?.dialogMessage = user.message ?? ""
//                }
//                completion(user.success ?? false)
//            })
//            .store(in: &cancellables)
//        
//        
//    }
    
    
    func getOngoingCourseDetails(courseId: Int) {
        isLoading = true
        courseService.ongoingCourseDetails(courseId: courseId)
            .handleEvents(receiveCompletion: { [weak self] value in
                self?.isLoading = false
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error \(error)")
                    self.error = error
                    self.showingDialogAlert = true
                    self.dialogMessage = error.localizedDescription
                    
                }
            }, receiveValue: { [weak self] data in
                self?.ongoingCourse = data
                self?.isLoading = true
            })
            .store(in: &cancellables)
        
        
    }    
    
    func readLecture(lectureId: Int) {
        isLoading = true
        courseService.readLecture(lectureId)
            .handleEvents(receiveCompletion: { [weak self] value in
                self?.isLoading = false
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error \(error)")
                    self.error = error
                    self.showingDialogAlert = true
                    self.dialogMessage = error.localizedDescription
                    
                }
            }, receiveValue: { [weak self] data in
                self?.isLoading = true
            })
            .store(in: &cancellables)
        
    }    
    
    func getQuizeList(quiseId: Int) {
        isLoading = true
        courseService.getQuizeList(quiseId)
            .handleEvents(receiveCompletion: { [weak self] value in
                self?.isLoading = false
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error \(error)")
                    self.error = error
                    self.showingDialogAlert = true
                    self.dialogMessage = error.localizedDescription
                    
                }
            }, receiveValue: { [weak self] data in
                self?.isLoading = false
                self?.quizeList = data.data
                self?.answers = Array(repeating: "", count: data.data.count)
            })
            .store(in: &cancellables)
        
    }    
    
    func submitQuizeAnswer(_ body : QuizeSubmitRequestModel) {
        isLoading = true
        courseService.submitQuizeAnswer(body)
            .handleEvents(receiveCompletion: { [weak self] value in
                self?.isLoading = false
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error \(error)")
                    self.error = error
                    self.showingDialogAlert = true
                    self.dialogMessage = error.localizedDescription
                    
                }
            }, receiveValue: { [weak self] data in
                self?.isLoading = false
                self?.showingDialogAlert = true
                self?.dialogMessage = data.message ?? ""
            })
            .store(in: &cancellables)
        
    }    
    
    func submitAssignment(_ body : AssignmentSubmitRequestModel,completion: @escaping (Bool) -> Void) {
        isLoading = true
        courseService.submitAssignment(body)
            .handleEvents(receiveCompletion: { [weak self] value in
                self?.isLoading = false
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error \(error)")
                    self.error = error
                    self.showingDialogAlert = true
                    self.dialogMessage = error.localizedDescription
                    
                }
            }, receiveValue: { [weak self] data in
                self?.isLoading = false
                self?.showingDialogAlert = true
                self?.dialogMessage = data.message ?? ""
                completion(data.success ?? false)
            })
            .store(in: &cancellables)
        
    }
    
    func fileUpload(parameter : [String : Any]) {
        
        isFileLoading = true
        guard let url = URL(string: URL.uploadFile) else {
            fatalError("URl was incorrect")
        }
        
        print(url)
        
        networkClient.postMultipartData(url: url, parameter: parameter, httpMethod:  HttpMethod.post.rawValue) { (result) in
        
            DispatchQueue.main.async {
                self.isLoading = false
            }
            switch result {
            
            case .success(let data, let status):
                
                switch status {
                case HTTPStatusCodes.OK:
                    self.successWith(data: data)
                    break
                   
                case HTTPStatusCodes.Accepted:
                    self.successWith(data: data)
                    break
                   
                
                case HTTPStatusCodes.Created:
                    self.successWith(data: data)
                    
                    break
                    
                case HTTPStatusCodes.BadRequest:
                    self.badRequestWith(data: data)
                    break
                    
                default:
                    break
                }
                break
                
            case .failure(let error):
                print(error)
                break
            }
            
        }
    }
    
    func successWith(data: Data ) {
        JSONDecoder.decodeData(model: CommonSuccessResponseModel.self, data) {(result) in
            switch result {
            case .success(let model):
                self.isFileLoading = model.success ?? false
                self.filePath = model.file ?? ""
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    func badRequestWith(data: Data ) {
        JSONDecoder.decodeData(model: BadRequest.self, data) {(result) in
            switch result {
            case .success(let model):
                self.isFileLoading =  false
                self.dialogMessage = model.message ?? ""
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
