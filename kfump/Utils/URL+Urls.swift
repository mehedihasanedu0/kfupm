//
//  URL+Urls.swift
//  kfump
//
//  Created by Mehedi Hasan on 24/4/24.
//

import Foundation

extension URL{
#if QA
    static let baseUrl  = "https://kfu-admin.ewnbd.com/api/v1"
#else
    static let baseUrl  = "https://kfu-admin.ewnbd.com/api/v1"
#endif
}

extension URL {
    
    // MARK: - Customer Authorization-
    static let login                               = "\(URL.baseUrl)/user/login/"
    static let logout                              = "\(URL.baseUrl)/user/login/"
    static let registration                        = "\(URL.baseUrl)/user/registration/"
    static let changePassword                      = "\(URL.baseUrl)/user/set-password/"
    static let forgetPassword                      = "\(URL.baseUrl)/user/reset-password/"
//    static let resetPassword                       = "\(URL.baseUrl)auth/reset-password"
//    static let account_verify                      = "\(URL.baseUrl)/account/verify"
    static let otp_verify                          = "\(URL.baseUrl)/user/otp-verify/"
    static let delete_account                      = "\(URL.baseUrl)auth/delete-account"
    static let refreshToken                      = "\(URL.baseUrl)/user/refresh-token/"
    
    
    // MARK: Profile
    static let userType                            = "\(URL.baseUrl)/user/user-type/"
    
    // MARK: - Home
    static let home                                = "\(URL.baseUrl)user/homepage"
    

    // MARK: - Reservation
    static let add_reservation                     = "\(URL.baseUrl)/reservation/add"
    static let customer_getReservation_byDate      = "\(URL.baseUrl)/reservation/customer/view?seller="
    
    // MARK: - Cupon
    static let apply_cupon                         = "\(URL.baseUrl)discount-coupon/apply"
    static let delete_cupon                        = "\(URL.baseUrl)discount-coupon/remove"
    
    
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
    
    
    
    
    
    static let accept_quotation                    = "\(URL.baseUrl)/quotation/update/"
    
    // MARK: - Home
    static let seller_home                         = "\(URL.baseUrl)/customer/home"
    static let get_trending_offer                  = "\(URL.baseUrl)/home/trending"
    static let top_rated_saller                    = "\(URL.baseUrl)/home/top-rated"
    static let newest_saller                       = "\(URL.baseUrl)/home/newest"
    static let near_by_salon                       = "\(URL.baseUrl)/customer/nearby-shops?service="
    
    static let search_sp                           = "\(URL.baseUrl)sp/list"
    static let all_new_sp                          = "\(URL.baseUrl)sp/list?order_type=newest"
    static let all_top_rated_sp                    = "\(URL.baseUrl)sp/list?order_type=top-rated"
    
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
    static let profile_picture_upload              = "\(URL.baseUrl)user/change-profile-picture"
    
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
