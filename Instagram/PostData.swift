//
//  PostData.swift
//  Instagram
//
//  Created by ouyou on 2019/04/10.
//  Copyright © 2019 ouyou. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class PostData : NSObject {
    var id : String?
    var image : UIImage?
    var imageString : String?
    var name : String?
    var caption : String?
    var date : Date?
    var likes : [String] = []   //如果谁点了心的按钮，他的udisplay就会在这个配列里生成
    var isLiked : Bool = false  //如果likes这个配列里有这个人的名字，这个人的isLiked就等于true
    var comments : [[String:String]] = []
    
    init(snapshot:DataSnapshot,myId:String){
        //通信时会自动生成一个唯一的key，在这里我们把这个key赋值给id，DataSnapshot可以看做是サーバー中数据库中的一个表
        self.id = snapshot.key
        //我让这个表里的值以【String：Any】这种键值对的形式赋值给valueDictionary
        let valueDictionary = snapshot.value as! [String:Any]
        //解析image值，因为当时image是先c生成jpeg格式，然后转为base64的格式c保存的，这一个是把base64格式转为UIImage型
        imageString = valueDictionary["image"] as? String
        self.image = UIImage(data: Data(base64Encoded: imageString!, options: .ignoreUnknownCharacters)!)
        self.name = valueDictionary["name"] as? String
        self.caption = valueDictionary["caption"] as? String
        let time = valueDictionary["time"] as? String
        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
        
        if let comments = valueDictionary["comments"] as? [[String:String]]{
            self.comments = comments
        }
        
        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }
        
        for likeId in self.likes {
            if likeId == myId {
                self.isLiked = true
                break
            }
        }

    }
    
}

