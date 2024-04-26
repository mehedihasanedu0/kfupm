//
//  StaticComponentForSharedPreferrence.swift
//  scai_ios
//
//  Created by Mehedi Hasan on 11/12/23.
//

import Foundation




let IS_LOGIN_OUT_D = "Log Out"
let ORDER_FOOD_ITEMS_D = "orderedFoodItems"
let ORDER_FOOD_IMAGE_D = "orderedFoodImage"
let ORDER_FOOD_ITEM_ID_D = "orderedFooditemId"
let ORDER_FOOD_ROOM_ID_D = "orderedFoodRoomId"
let ORDER_FOOD_DESCRIPTION_D = "orderedFoodDescription"
let FCM_TOKEN_D = "fcm_token"
let QR_IMAGE_D = "qrImage"
let CREATE_VISITOR_SUCCESSFULLY_D = "Visitor create successfully"
let shared = UserDefaults.standard


enum Keys: String, CaseIterable {
    case IS_LOGIN_D = "LOGIN"
    case USER_UUID_D = "User UUID"
    case TOKEN_D = "TOKEN"
    case refreshToken = "Refresh token"
    case USER_NAME = "User Name"
    case USER_PROFILE = "User Profile Image"
}


extension UserDefaults {
    func resetKeys() {
        Keys.allCases.forEach {
            removeObject(forKey: $0.rawValue)
        }
    }
}
