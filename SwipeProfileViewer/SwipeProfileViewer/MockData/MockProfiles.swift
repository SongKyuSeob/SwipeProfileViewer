//
//  MockProfiles.swift
//  SwipeProfileViewer
//
//  Created by 송규섭 on 1/27/26.
//

import Foundation

struct MockProfiles {
    static let profiles = [
        Profile(
            id: 1,
            name: "신짱구",
            age: 5,
            bio: "초코비 먹고 액션가면 보는게 제일 좋아요!",
            distance: 2,
            images: ["profile_1_1", "profile_1_2", "profile_1_3", "profile_1_4"]
        ),
        Profile(
            id: 2,
            name: "김철수",
            age: 5,
            bio: "로봇 좋아하고 공부도 잘해요",
            distance: 5,
            images: ["profile_2_1", "profile_2_2", "profile_2_3"]
        ),
        Profile(
            id: 3,
            name: "한유리",
            age: 5,
            bio: "토끼 인형이랑 놀기 좋아해요 🐰",
            distance: 3,
            images: ["profile_3_1", "profile_3_2", "profile_3_3", "profile_3_4", "profile_3_5"]
        ),
        Profile(
            id: 4,
            name: "이훈이",
            age: 5,
            bio: "맹구랑 친하고 장난치는 거 좋아해요",
            distance: 1,
            images: ["profile_4_1", "profile_4_2", "profile_4_3", "profile_4_4"]
        ),
    ]
}
