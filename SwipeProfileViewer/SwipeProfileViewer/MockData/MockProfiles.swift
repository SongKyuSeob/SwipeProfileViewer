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
            name: "우디",
            bio: " 주말에 뭐해요? :-) ",
            keywords: ["아직 잘 모르겠어요", "강아지"],
            images: ["profile_1_1", "profile_1_2", "profile_1_3"]
        ),
        Profile(
            id: 2,
            name: "WOO",
            bio: "진중하게 알아가고 싶어요",
            keywords: ["진지한만남", "운동", "ENFJ"],
            images: ["profile_2_1", "profile_2_2", "profile_2_3", "profile_2_4"]
        ),
        Profile(
            id: 3,
            name: "흠냐흠냐",
            bio: " 두쫀쿠 오픈런 ㄱㄱ?",
            keywords: ["ENTP", "두쫀쿠", "콘서트"],
            images: ["profile_3_1", "profile_3_2", "profile_3_3"]
        ),
        Profile(
            id: 4,
            name: "제로",
            bio: " 탈퇴하실 분 ",
            keywords: ["여행", "새벽"],
            images: ["profile_4_1", "profile_4_2", "profile_4_3", "profile_4_4"]
        ),
    ]
}
