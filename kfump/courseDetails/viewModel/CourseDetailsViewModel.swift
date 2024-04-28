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
    @Published var isGetCourseActualData = false
    @Published var isLoadingBySearchKey = false
    @Published var error: Error?
    @Published var showingDialogAlert = false
    @Published var dialogMessage = ""
    @Published var isSucess = false
    
    private let courseService: CourseService
    
    @Published var courseData : CourseData?
    @Published var scyllabusInfo = [SyllabusInfo]()
    @Published var classRoutineInfo = [ClassRoutineInfo]()
    
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
                
            })
            .store(in: &cancellables)
        
        
    }
    
}
