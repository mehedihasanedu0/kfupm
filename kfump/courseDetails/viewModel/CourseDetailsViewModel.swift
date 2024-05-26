//
//  CourseDetailsViewModel.swift
//  kfump
//
//  Created by Mehedi Hasan on 29/4/24.
//

import Foundation
import Combine
import SwiftUI

class CourseDetailsViewModel : ObservableObject {
    
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isLoading = false
    @Published var isLoadingForCreateReview = false
    @Published var isLoadingEnrollment = false
    @Published var isGetCourseActualData = false
    @Published var isLoadingBySearchKey = false
    @Published var error: Error?
    @Published var showingDialogAlert = false
    @Published var dialogMessage = ""
    @Published var isSucess = false
    
    private let courseService: CourseService
    
    @Published var courseData : CourseData?
    @Published var scyllabusInfo : [SyllabusInfo]?
    @Published var classRoutineInfo : [ClassRoutineInfo]?
    @Published var ratingInfo : [Rating]?
    @Published var ratingPercentage : [String: Double]?
    @Published var instructor : CreatedBy?
    
    @Published var enrolledData : CourseEnrolledData?
    
    init(courseService: CourseService = CourseService()) {
        self.courseService = courseService
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    
    func courseDetails(courseId: Int) {
        isLoading = true
        courseService.courseDetails(courseId: courseId)
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
                self?.courseData = data.data
                self?.scyllabusInfo = data.data.syllabusInfo ?? []
                self?.classRoutineInfo = data.data.classRoutineInfo ?? []
                self?.ratingInfo = data.data.rating ?? []
                self?.ratingPercentage = data.data.ratingPercentage ?? [:]
                self?.instructor = data.data.createdBy
                
            })
            .store(in: &cancellables)
        
        
    }
    
    func enrolled(body: EnrolledRequestModel,completion: @escaping (Bool) -> Void) {
        isLoadingEnrollment = true
        courseService.enrollment(body)
            .handleEvents(receiveCompletion: { [weak self] value in
                self?.isLoadingEnrollment = false
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
                self?.isLoadingEnrollment = true
                self?.enrolledData = data.data
                completion(data.success)
                
            })
            .store(in: &cancellables)
        
    }    
    
    func singlePayment(body: SinglePaymentRequestModel,completion: @escaping (Bool) -> Void) {
        isLoading = true
        courseService.singlePayment(body)
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
                self?.dialogMessage = data.message ?? ""
                completion(data.success ?? false)
                
            })
            .store(in: &cancellables)
        
    }   
    
    func groupEnrolled(body: GroupEnrollRequestModel,completion: @escaping (Bool) -> Void) {
        isLoading = true
        courseService.groupPayment(body)
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
                self?.dialogMessage = data.message ?? ""
                completion(data.success ?? false)
                
            })
            .store(in: &cancellables)
        
    }
        
    func createReview(body: CourseRatingRequestModel,completion: @escaping (Bool) -> Void) {
        isLoadingForCreateReview = true
        courseService.createReview(body)
            .handleEvents(receiveCompletion: { [weak self] value in
                self?.isLoadingForCreateReview = false
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
                self?.isLoadingForCreateReview = false
                completion(data.success)
                
            })
            .store(in: &cancellables)
        
    }
    
}
