//
//  Post.swift
//  FB Table View
//
//  Created by 楊曜安 on 2023/6/1.
//

import Foundation


struct PostInfo { // 貼文資訊
    let userName: String
    let profilePictureName: String
    let timestamp: Date
    let isPublic: Bool
    let text: String?
    let imageName: String?
    var likes: Int = 0
    var commentsCount: Int { // 計算屬性（Computed Properties）
        var count = postComments.count
        for postComment in postComments {
            count += postComment.replyComments.count
        }
        return count
    }
    var shares: Int = 0
    var isLiked: Bool = false { // 觀察屬性（Property Observers）
        didSet {
            if isLiked {
                likes += 1
            } else {
                likes -= 1
            }
        }
    }
    var likeButtonImageName:String { // 計算屬性（Computed Properties）
        get {
            isLiked ? "hand.thumbsup.fill" : "hand.thumbsup"
        }
        set {
            isLiked = newValue == "hand.thumbsup.fill" ? true : false
        }
    }
    var postComments: [PostComment] = []
}

struct PostComment { // 貼文留言
    let userName: String
    let profilePictureName: String
    let content: String
    let timestamp: Date
    var isLiked: Bool = false { // 觀察屬性（Property Observers）
        didSet {
            if isLiked {
                likes += 1
            } else {
                likes -= 1
            }
        }
    }
    var likes: Int = 0
    var replyComments: [ReplyComments] = []
}

struct ReplyComments { // 貼文留言中的回覆留言
    let userName: String
    let profilePictureName: String
    let content: String
    let timestamp: Date
    var isLiked: Bool = false { // 觀察屬性（Property Observers）
        didSet {
            if isLiked {
                likes += 1
            } else {
                likes -= 1
            }
        }
    }
    var likes: Int = 0
}

func convertStringToDate(_ dateString: String, dateFormat: String = "yyyy/MM/dd HH:mm:ss") -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    dateFormatter.locale = Locale(identifier: "zh-TW") //設定繁體中文
    guard let date = dateFormatter.date(from: dateString) else {
        preconditionFailure("Check your date format")
    }
    return date
}

func timeAgoDisplay(date: Date) -> String {
    let now = Date()
    let calendar = Calendar.current
    let yearOfDate = calendar.component(.year, from: date)
    let yearOfNow = calendar.component(.year, from: now)
    let components = calendar.dateComponents([.month], from: date, to: now)
    
    if yearOfDate != yearOfNow {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年M月d日"
        dateFormatter.locale = Locale(identifier: "zh_TW")
        return dateFormatter.string(from: date)
    } else if let months = components.month, months >= 1 {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M月d日"
        dateFormatter.locale = Locale(identifier: "zh_TW")
        return dateFormatter.string(from: date)
    } else {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.locale = Locale(identifier: "zh_TW")
        return formatter.localizedString(for: date, relativeTo: now)
    }
}

var postArray = [
    PostInfo(userName: "MLB Taiwan 美國職棒大聯盟", profilePictureName: "MLB Taiwan pic", timestamp: convertStringToDate("2023/6/14 13:53:54"), isPublic: true, text: "這幾位打者在打點排行榜領先群雄🤩\n他們總是能在關鍵時刻給對手致命一擊👊", imageName: "MLB Taiwan postImage", likes: 933 ,shares: 1),
    PostInfo(userName: "Los Angeles Angels", profilePictureName: "Los Angeles Angels pic", timestamp: convertStringToDate("2023/6/1 08:44:54"), isPublic: true, text: "A two-homer day for Shohei Ohtani and it's only the 6th inning 👀", imageName: "Los Angeles Angels postImage", likes: 3775, shares: 170),
    PostInfo(userName: "台南Josh", profilePictureName: "台南Josh pic", timestamp: convertStringToDate("2023/6/1 08:44:54"), isPublic: true, text: "好 你們可以開始笑了🥲", imageName: "台南Josh postImage", likes: 12574, shares: 72),
    PostInfo(userName: "DDCAR", profilePictureName: "DDCAR pic", timestamp: convertStringToDate("2023/1/3 10:23:20"), isPublic: true, text: "🎊iX1首批交車啦\n 摸索快充需要一點時間\n 來 U-POWER 充是一個好的開始XD", imageName: "DDCAR postImage", likes: 116, shares: 2),
    PostInfo(userName: "Dcard", profilePictureName: "Dcard pic", timestamp: convertStringToDate("2023/4/5 14:00:23"), isPublic: true, text: "覺得孝親費太少 🤢 媽媽：自私、換來你們的無情", imageName: "Dcard postImage", likes: 443, shares: 17),
    PostInfo(userName: "批踢踢實業坊(Ptt.cc)", profilePictureName: "批踢踢實業坊(Ptt.cc) pic", timestamp: convertStringToDate("2023/5/18 16:04:04"), isPublic: true, text: "[西洽] 日本高中生流行語：蛙化現象。\n http://www.ptt.cc/bbs/c_chat/M.1684388959.A.66C.html\n #日本男生也太辛苦了", imageName: "批踢踢實業坊(Ptt.cc) postImage", likes: 3437, shares: 582),
    PostInfo(userName: "Rakuten Monkeys", profilePictureName: "Rakuten Monkeys pic", timestamp: convertStringToDate("2023/5/30 10:10:10"), isPublic: true, text: "📅2023/06/01 VS 統一獅\n桃猿軍團今日移師台南與統一獅交手，由陳克羿與宋嘉翔擔任投捕搭檔，此役桃猿軍團英勇的先發部隊出列！(￣^￣)ゞ\n１０號隊友齊心應猿👊\n與桃猿戰士並肩作戰💪\n#READY #全猿準備", imageName: "Rakuten Monkeys postImage", likes: 29, shares: 15),
    PostInfo(userName: "MLB Dugout", profilePictureName: "MLB Dugout pic", timestamp: convertStringToDate("2022/12/31 17:17:17"), isPublic: true, text: "【花卷東高校監督的這句話，撼動了大谷翔平的靈魂】\n大谷翔平的母親加代子形容兒子從小就有「冒險精神」。\n什麼是「冒險精神」？美國攀岩運動家霍諾德（Alex Honnold）為「冒險精神」下了一個定義：「嘗試別人沒做過的事，挑戰自己的極限，試探自己的能耐。在某種意義上，這股動力可說是好奇心，是探險家都有的精神，我想看看前方究竟有什麼東西。」\n這就是驅使大谷不斷製造驚奇的原動力。他在決定就讀花卷東高校時曾對母親說過，「如果雄星賢拜他們已經拿下全國優勝，我就會去唸其他高校」；在思考高中畢業直接挑戰大聯盟時，他則說「我想成為先驅者」。\n在棒球場上，大谷高中時以球速一六○公里為目標，乃至於後來的「二刀流」，更是「冒險精神」的極致。別忘了大谷剛入學時的球速只能投到一三○公里中段，當他決定以一五○公里作為目標時，佐佐木監督卻說服他改以全日本高校、乃至於全業餘球界前所未有的一六○公里為目標。\n「二刀流」更是如此。大谷一直堅持這樣的想法。他在二○一九年受訪時這麼說：「我不知道將來會發生什麼事，也不知道『二刀流』能走多遠，但至少現在我的打擊能力進步幅度超過預期，我相信我還有許多連自己都不知道的潛力。」\n「事實上去年春訓熱身賽我打得很糟，許多人說我不可能在大聯盟擔任打者，結果呢？我現在的棒次就排在楚奧特後面。你永遠不知道將來會發生什麼事，對吧？」\n「先入為主的觀念，將使可能成為不可能」，這是佐佐木洋監督在一次會議中告訴大谷的話，後來成為大谷的座右銘之一，大谷甚至形容這句話「撼動他的靈魂」。", imageName: "MLB Dugout postImage", likes: 21, shares: 10)
]
