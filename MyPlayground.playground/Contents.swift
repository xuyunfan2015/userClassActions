//: Playground - noun: a place where people can play

import UIKit

let dataDic:Dictionary<String,AnyObject> = ["name":"ali","age":18,"mela":"man","other":"anyOther"]

class UserInfo: NSObject,NSCoding {
    var name :String?
    var age :Int = 0
    var mela :String?
    //MARK:-
    init(dic:Dictionary<String,AnyObject>) {
        super.init()
        //必须加superinit，为类对象分配空间
        //基础属性int 不能为可选类型，不然不会分配空间导致赋值失败
        //必须实现setvalue forUndefinedKey 避免崩溃
        self.setValuesForKeysWithDictionary(dic)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    override var description: String{
    return self.name! + self.mela!
    
    }
    //MARK:-NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeInteger(age, forKey: "age")
        aCoder.encodeObject(mela, forKey: "mela")
    }
    required init?(coder aDecoder: NSCoder) {
        self.age = aDecoder.decodeIntegerForKey("age")
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.mela = aDecoder.decodeObjectForKey("mela") as? String
    }
    //MARK:- waibu
    func saveAccount() -> Bool {
        //1.获取缓存目录路径
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        //2.生成缓存路径
        let filePath = (path as NSString).stringByAppendingPathComponent("account.plist")
        print(filePath)
        //3.归档对象
        return NSKeyedArchiver.archiveRootObject(self, toFile: filePath)
        
        
    }
    //jie dang
    static var myaccout :UserInfo?
    
    class func loadUserAccount() -> UserInfo?{
        //1.判断是否已经加载过了
        if UserInfo.myaccout != nil {
            return myaccout
        }
        //2.尝试从文件中加载
        
        //1.获取缓存目录路径
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        //2.生成缓存路径
        let filePath = (path as NSString).stringByAppendingPathComponent("account.plist")
        
        guard let account = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) else{
        return UserInfo.myaccout
        }
        UserInfo.myaccout = account as? UserInfo
        return account as? UserInfo
    }
    class func isLogin() -> Bool{
    return UserInfo.loadUserAccount() != nil
    }
    
}

let user = UserInfo.init(dic: dataDic)

print(user)

user.saveAccount()