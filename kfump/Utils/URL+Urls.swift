//
//  URL+Urls.swift
//  kfump
//
//  Created by Mehedi Hasan on 24/4/24.
//

import Foundation

extension URL{
#if QA
    static let baseUrl  = "https://kfu-dev-admin.ewnbd.com/api/v1"
#else
    static let baseUrl  = "https://kfu-dev-admin.ewnbd.com/api/v1"
#endif
}

extension URL {
    
    // MARK: - Customer Authorization-
    static let login                               = "\(URL.baseUrl)/user/login/"
    static let logout                              = "\(URL.baseUrl)/user/login/"
    static let registration                        = "\(URL.baseUrl)/user/registration/"
    static let changePassword                      = "\(URL.baseUrl)/user/change-password/"
    static let forgetPassword                      = "\(URL.baseUrl)/user/reset-password/"
    static let resetPassword                       = "\(URL.baseUrl)/user/set-password/"
    static let otp_verify                          = "\(URL.baseUrl)/user/otp-verify/"
    static let delete_account                      = "\(URL.baseUrl)auth/delete-account"
    static let refreshToken                        = "\(URL.baseUrl)/user/refresh-token/"
    
    
    // MARK: Profile
    static let userProfile                         = "\(URL.baseUrl)/user/profile/"
    static let userType                            = "\(URL.baseUrl)/user/user-type/"
    static let colseAccount                        = "\(URL.baseUrl)/user/close-account/"
    static let paymentHistory                      = "\(URL.baseUrl)/payment/history/"
    
    // MARK: - More
    static let createReportAnIssue                 = "\(URL.baseUrl)/cms/report-an-issues/"
    static let getAllreportIssue                   = "\(URL.baseUrl)/cms/report-an-issues/"
    static let contactUs                           = "\(URL.baseUrl)/cms/get-in-touch/"
    static let attendanceHistory                   = "\(URL.baseUrl)/attendance/history/"
    

    // MARK: - Course
    static let courseDetails                       = "\(URL.baseUrl)/course/about/"
    static let enrolledCourse                      = "\(URL.baseUrl)/payment/checkout/"
    static let cashPayment                         = "\(URL.baseUrl)/payment/create/"
    static let enrolledGroup                       = "\(URL.baseUrl)/group/enrolled/"
    static let createReview                        = "\(URL.baseUrl)/course/rating/"
    static let readLecture                         = "\(URL.baseUrl)/course/lecture-is-read/"
    static let quiseList                           = "\(URL.baseUrl)/course/individual-course-lecture-details/"
    static let surveyList                          = "\(URL.baseUrl)/course/survey-answer-submit/?course_id="
    static let surveySubmit                        = "\(URL.baseUrl)/course/survey-answer-submit/"
    static let quizeSubmit                         = "\(URL.baseUrl)/course/class-quiz-assignment-submit/"
    static let quiseAns                            = "\(URL.baseUrl)/course/class-quiz-assignment-submit/"
    static let assignmentSubmit                    = "\(URL.baseUrl)/course/class-quiz-assignment-submit/"
    static let courseStatusChange                  = "\(URL.baseUrl)/course/enroll-status-update/"
    static let viewGirds                           = "\(URL.baseUrl)/course/trainee-view-grade-of-assignment-and-quiz/?course_id="
    
    
    static let ongoingCourseDetails                = "\(URL.baseUrl)/course/class-create/"
    
    // MARK: - Cupon
    static let apply_cupon                         = "\(URL.baseUrl)discount-coupon/apply"
    static let delete_cupon                        = "\(URL.baseUrl)discount-coupon/remove"
    
    
    // MARK: - Cupon
    static let userList                            = "\(URL.baseUrl)/user/user-list/"
    static let roomList                            = "\(URL.baseUrl)/chat-rooms/?limit=100"
    static let userChat                            = "\(URL.baseUrl)/messages/"
    static let notification                        = "\(URL.baseUrl)/notification/"
    
    
    // MARK: - Service
    static let admin_provided_service_list         = "\(URL.baseUrl)service/admin-provided-services"
    static let all_service_list                    = "\(URL.baseUrl)/customer/service/list"
    static let seller_self_profile                 = "\(URL.baseUrl)/customer/profile"
    static let sub_service_list                    = "\(URL.baseUrl)/customer/service/"
    static let add_service                         = "\(URL.baseUrl)/customer/service/add"
    static let update_service                      = "\(URL.baseUrl)/customer/service/update/"
    static let service_list                        = "\(URL.baseUrl)service/list/"
    static let product_list                        = "\(URL.baseUrl)product/list/"
    static let review_list                        = "\(URL.baseUrl)sp/reviews/"
    static let seller_filter                       = "\(URL.baseUrl)/seller/profile/filter?"
    static let service_list_on_map                 = "\(URL.baseUrl)/seller/service/customer-list-on-map"
    
    
    
    // MARK: - Genarate Certificate
    static let genarateTranscript                  = "\(URL.baseUrl)/course/generate_transcript/"
    static let genarateCertificate                 = "\(URL.baseUrl)/course/generate_certificate/"
    
    
    
    
    
    static let accept_quotation                    = "\(URL.baseUrl)/quotation/update/"
    
    // MARK: - Home
    static let courseList                         = "\(URL.baseUrl)/course/browse-course-list/?page=1&limit=100"
    static let courseListWithStatus               = "\(URL.baseUrl)/course/enroll-courses/?page=1&limit=100"
    static let courseListBySearchKey              = "\(URL.baseUrl)/course/browse-course-list/?search="
    static let filterCategory                     = "\(URL.baseUrl)/course/category/"
    static let availability                       = "\(URL.baseUrl)/course/availability/"
    static let profile                            = "\(URL.baseUrl)user/profile"
    
    // MARK: - Payment
    static let process_to_payment                  = "\(URL.baseUrl)order/proceed-to-payment"
    static let confirm_payment                     = "\(URL.baseUrl)order/confirm-payment"
    static let payment_history                     = "\(URL.baseUrl)payment/history?start_date=2023-05-10&end_date=2023-07-13"
    static let payment_history_details             = "\(URL.baseUrl)payment/history/"
    
    // MARK: - Order
    static let order_list                          = "\(URL.baseUrl)order/list?type=order_requested, pending, processing, declined, cancelled, completed"
    static let order_history_list                  = "\(URL.baseUrl)order/list?type=delined, cancelled, completed"
    static let order_history                       = "\(URL.baseUrl)order/list?type=history&page="
    static let order_list_details                  = "\(URL.baseUrl)order/"
    static let order_confirm                       = "\(URL.baseUrl)order/confirm"
    static let payment_confirm                     = "\(URL.baseUrl)order/confirm-payment"
    static let create_review                       = "\(URL.baseUrl)order/review/"
    
    
    
    //MARK: - Cart
    static let cart_list                           = "\(URL.baseUrl)order/cart"
    static let add_to_cart                         = "\(URL.baseUrl)order/cart"
    static let delete_cart                         = "\(URL.baseUrl)order/cart?"
    
    //MARK: - Cart
    static let sp_details                          = "\(URL.baseUrl)sp/details/"
   // static let add_to_cart                         = "\(URL.baseUrl)/order/cart/add"
    
    
    // MARK: - Update
    static let profileUpdate                      = "\(URL.baseUrl)/user/profile/"
    static let profile_picture_upload             = "\(URL.baseUrl)/user/change-profile-picture"
    static let uploadFile                         = "\(URL.baseUrl)/upload/"
    
    //MARK: - Favourite
    static let favourite_list                      = "\(URL.baseUrl)sp/favorite"
    static let favourite_add                       = "\(URL.baseUrl)sp/favorite/"
    static let favourite_delete                    = "\(URL.baseUrl)sp/favorite/"
    
    // MARK: - Order
    static let get_profile_info                    = "\(URL.baseUrl)user/profile"
    static let edit_order                          = "\(URL.baseUrl)/order/update/"
    static let upcoming_order                      = "\(URL.baseUrl)/home/upcoming-order"
    static let order_status_update                 = "\(URL.baseUrl)order/update-status/"

    
    //MARK: - Issue
    static let seller_issue_list                   = "\(URL.baseUrl)issue/admin-issue-categories"
    static let seller_track_list                   = "\(URL.baseUrl)issue"
    static let seller_issue_add                    = "\(URL.baseUrl)issue/"
    
    // MARK: - Change password
    static let change_password                     = "\(URL.baseUrl)auth/change-password"
    
    // MARK: - Notification
    static let notification_list                   = "\(URL.baseUrl)notification/list"
    static let notification_update                 = "\(URL.baseUrl)notification/mark-as-seen/"
    static let token_registration                  = "\(URL.baseUrl)notification/device/"
    
    
    // MARK: Google map
    static let get_lat_lon_by_address              = "https://maps.googleapis.com/maps/api/geocode/json?address="
    
    
}
