//
//  Post.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/6/1.
//

//import Foundation

struct PostComment {
    let userName: String
    let profilePictureName: String
    let content: String
    let timestamp: String
    var isLiked: Bool = false
}


struct PostInfo {
    let userName: String
    let profilePictureName: String
    let timestamp: String
    let isPublic: Bool
    let text: String
    let imageName: String
    var likes: Int
    var commentsCount: Int
    var shares: Int
    var isLiked: Bool = false {
        didSet {
            if isLiked {
                likes += 1
            } else {
                likes -= 1
            }
        }
    }
    var likeButtonImageName:String {
        get {
            isLiked ? "hand.thumbsup.fill" : "hand.thumbsup"
        }
        set {
            isLiked = newValue == "hand.thumbsup.fill" ? true : false
        }
    }
    var comments: [PostComment] = []
}


var postArray = [
    PostInfo(userName: "MLB Taiwan 美國職棒大聯盟", profilePictureName: "MLB Taiwan pic", timestamp: "22小時", isPublic: true, text: "這幾位打者在打點排行榜領先群雄🤩\n他們總是能在關鍵時刻給對手致命一擊👊", imageName: "MLB Taiwan postImage", likes: 933 ,commentsCount: 29,shares: 1),
    PostInfo(userName: "Los Angeles Angels", profilePictureName: "Los Angeles Angels pic", timestamp: "14小時", isPublic: true, text: "A two-homer day for Shohei Ohtani and it's only the 6th inning 👀", imageName: "Los Angeles Angels postImage", likes: 3775, commentsCount: 77, shares: 170),
    PostInfo(userName: "台南Josh", profilePictureName: "台南Josh pic", timestamp: "1天", isPublic: true, text: "好 你們可以開始笑了🥲", imageName: "台南Josh postImage", likes: 12574, commentsCount: 841, shares: 72),
    PostInfo(userName: "DDCAR", profilePictureName: "DDCAR pic", timestamp: "3天", isPublic: true, text: "🎊iX1首批交車啦\n 摸索快充需要一點時間\n 來 U-POWER 充是一個好的開始XD", imageName: "DDCAR postImage", likes: 116, commentsCount: 8, shares: 2),
    PostInfo(userName: "Dcard", profilePictureName: "Dcard pic", timestamp: "4天", isPublic: true, text: "覺得孝親費太少 🤢 媽媽：自私、換來你們的無情", imageName: "Dcard postImage", likes: 443, commentsCount: 119, shares: 17),
    PostInfo(userName: "批踢踢實業坊(Ptt.cc)", profilePictureName: "批踢踢實業坊(Ptt.cc) pic", timestamp: "5月18日下午4:04", isPublic: true, text: "[西洽] 日本高中生流行語：蛙化現象。\n http://www.ptt.cc/bbs/c_chat/M.1684388959.A.66C.html\n #日本男生也太辛苦了", imageName: "批踢踢實業坊(Ptt.cc) postImage", likes: 3437, commentsCount: 532, shares: 582),
    PostInfo(userName: "Rakuten Monkeys", profilePictureName: "Rakuten Monkeys pic", timestamp: "40分鐘", isPublic: true, text: "📅2023/06/01 VS 統一獅\n桃猿軍團今日移師台南與統一獅交手，由陳克羿與宋嘉翔擔任投捕搭檔，此役桃猿軍團英勇的先發部隊出列！(￣^￣)ゞ\n１０號隊友齊心應猿👊\n與桃猿戰士並肩作戰💪\n#READY #全猿準備", imageName: "Rakuten Monkeys postImage", likes: 29, commentsCount: 73, shares: 15),
    PostInfo(userName: "MLB Dugout", profilePictureName: "MLB Dugout pic", timestamp: "6小時", isPublic: true, text: "【花卷東高校監督的這句話，撼動了大谷翔平的靈魂】\n大谷翔平的母親加代子形容兒子從小就有「冒險精神」。\n什麼是「冒險精神」？美國攀岩運動家霍諾德（Alex Honnold）為「冒險精神」下了一個定義：「嘗試別人沒做過的事，挑戰自己的極限，試探自己的能耐。在某種意義上，這股動力可說是好奇心，是探險家都有的精神，我想看看前方究竟有什麼東西。」\n這就是驅使大谷不斷製造驚奇的原動力。他在決定就讀花卷東高校時曾對母親說過，「如果雄星賢拜他們已經拿下全國優勝，我就會去唸其他高校」；在思考高中畢業直接挑戰大聯盟時，他則說「我想成為先驅者」。\n在棒球場上，大谷高中時以球速一六○公里為目標，乃至於後來的「二刀流」，更是「冒險精神」的極致。別忘了大谷剛入學時的球速只能投到一三○公里中段，當他決定以一五○公里作為目標時，佐佐木監督卻說服他改以全日本高校、乃至於全業餘球界前所未有的一六○公里為目標。\n「二刀流」更是如此。大谷一直堅持這樣的想法。他在二○一九年受訪時這麼說：「我不知道將來會發生什麼事，也不知道『二刀流』能走多遠，但至少現在我的打擊能力進步幅度超過預期，我相信我還有許多連自己都不知道的潛力。」\n「事實上去年春訓熱身賽我打得很糟，許多人說我不可能在大聯盟擔任打者，結果呢？我現在的棒次就排在楚奧特後面。你永遠不知道將來會發生什麼事，對吧？」\n「先入為主的觀念，將使可能成為不可能」，這是佐佐木洋監督在一次會議中告訴大谷的話，後來成為大谷的座右銘之一，大谷甚至形容這句話「撼動他的靈魂」。", imageName: "MLB Dugout postImage", likes: 21, commentsCount: 20, shares: 10)
]
