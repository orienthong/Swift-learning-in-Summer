---
title: Swift设计模式
date: 2016-08-23 12:50:20
tags: Swift
---

##外观模式 - Facade
外观模式在复杂的业务系统上提供了简单的接口。如果直接把业务的所有接口直接 暴露给使用者,使用者需要单独面对这一大堆复杂的接口,学习成本很高,而且存 在误用的隐患。如果使用外观模式,我们只要暴露必要的 API 就可以了。

API 的使用者完全不知道这内部的业务逻辑有多么复杂。当我们有大量的类并且它 们使用起来很复杂而且也很难理解的时候,外观模式是一个十分理想的选择。

##装饰者模式 - Decorator

装饰者模式可以动态的给指定的类添加一些行为和职责,而不用对原代码进行任何 修改。当你需要使用子类的时候,不妨考虑一下装饰者模式,可以在原始类上面封 装一层。

在 Swift 里,有两种方式实现装饰者模式:扩展 (Extension) 和委托 (Delegation)。

##适配器模式 - Adapter
适配器把自己封装起来然后暴露统一的接口给其他类,这样即使其他类的接口各不 相同,也能相安无事,一起工作。

苹果通过委托实现了适配器模式。

##观察者模式 - Observer

在观察者模式里,一个对象在状态变化的时候会通知另一个对象。参与者并不需要 知道其他对象的具体是干什么的 - 这是一种降低耦合度的设计。这个设计模式常用 于在某个属性改变的时候通知关注该属性的对象。

常见的使用方法是观察者注册监听,然后再状态改变的时候,所有观察者们都会收 到通知。

在 MVC 里,观察者模式意味着需要允许 Model 对象和 View 对象进行交流，而不能有直接的关联。

Cocoa 使用两种方式实现了观察者模式: Notification 和 Key - Value Observing (KVO) 。
**Notification模式**

> 1

```
NSNotificationCenter.defaultCenter().postNotificationName("BLDownloadImageNotification", object: self, userInfo: ["imageView": coverImage, "coverUrl": albumCover])
```

```
deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
      }
```

```
NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LibraryAPI.downloadImage(_:)), name: "BLDownloadImageNotification", object: nil)
```

```
func downloadImage(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let imageView = userInfo["imageView"] as! UIImageView?
        let coverUrl = userInfo["coverUrl"] as! NSString
        
        if let imageViewUnWrapped = imageView {
            imageViewUnWrapped.image = persistencyManager.getImage(coverUrl.lastPathComponent)
            //如果图片没有存入本地，则下载图片
            if imageViewUnWrapped.image == nil {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    () -> Void in
                    let downloadedImage = self.httpClient.downloadImage(coverUrl as String)
                    
                    dispatch_sync(dispatch_get_main_queue(), {
                        () -> Void in
                        imageViewUnWrapped.image = downloadedImage
                        self.persistencyManager.saveImage(downloadedImage, filename: coverUrl.lastPathComponent)
                    })
                })
            }
        }
    }
```
>例2
可以收到应用进入后台的通知

```
NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.saveCurrentState), name: UIApplicationDidEnterBackgroundNotification, object: nil)
```
```
deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)    }
```
```
func saveCurrentState() {
        // when the user leaves the app and then comes back again, he wants it to be in the exact same state
        //he left it. in order to do this we need to save the currently displayed album 
        //Since it's only one piece of information we can use NSUserDefaults
        NSUserDefaults.standardUserDefaults().setInteger(currentAlbumIndex, forKey: "currentAlbumIndex")
    }
    
```
**Key - Value Observing**

```
addSubview(coverImage)
```
```
deinit {
        coverImage.removeObserver(self, forKeyPath: "image")
    }
```
```
override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "image" {
            indicator.stopAnimating()
        }
    }
```

##备忘录模式 - Memento

备忘录模式捕捉并且具象化一个对象的内在状态。换句话说，它把你的对象存在了某个地方，然后在以后的某个时间再把它恢复出来，而不会打破它本身的封装性，私有数据依旧是私有数据。
        
NSUserDefaults 是 iOS 提供的一个标准存储方案，用于保存应用的配置信息和数据。

```
//MARK: Memento Pattern
    func saveCurrentState() {
        // when the user leaves the app and then comes back again, he wants it to be in the exact same state
        //he left it. in order to do this we need to save the currently displayed album
        //Since it's only one piece of information we can use NSUserDefaults
        NSUserDefaults.standardUserDefaults().setInteger(currentAlbumIndex, forKey: "currentAlbumIndex")
    }
    
    func loadPreviousState() {
        currentAlbumIndex = NSUserDefaults.standardUserDefaults().integerForKey("currentAlbumIndex")
        showDataForAlbum(currentAlbumIndex)
    }
```

##归档- Archiving
苹果通过归档的方法来实现备忘录模式。它把对象转化成了流然后在不暴露内部属性的情况下存储数据。

在model中

```
required init(coder decoder: NSCoder) {
    super.init()
    self.title = decoder.decodeObjectForKey("title") as! String
    self.artist = decoder.decodeObjectForKey("artist")as! String
    self.genre = decoder.decodeObjectForKey("genre") as! String?
    self.coverUrl = decoder.decodeObjectForKey("cover_url")as! String
    self.year = decoder.decodeObjectForKey("year") as! String
}

func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(title, forKey: "title")
    aCoder.encodeObject(artist, forKey: "artist")
    aCoder.encodeObject(genre, forKey: "genre")
    aCoder.encodeObject(coverUrl, forKey: "cover_url")
    aCoder.encodeObject(year, forKey: "year")
}
```

在Manager中写入和读取数据方法

```
func saveAlbums() {
    let filename = NSHomeDirectory().stringByAppendingString("/Documents/albums.bin")
    let data = NSKeyedArchiver.archivedDataWithRootObject(albums)
    data.writeToFile(filename, atomically: true)
}

```

```
override init() {
    super.init()
    if let data = NSData(contentsOfFile: NSHomeDirectory().stringByAppendingString("/Documents/albums.bin")) {
    
        let unarchiveAlbums = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Album]
      //查看是否读取成功
        if let unwrappedAlbum : [Album]  = unarchiveAlbums {
            albums = unwrappedAlbum
        }
    } else {
    //创建新的数据
        createPlaceholderAlbum()
    }
}

```
[The Demo Project](https://github.com/scauos/Swift-learning-in-Summer/tree/master/SwiftDesignPatterns-Demo)

##Write in the End


**learning in Raywenderlich**

[阅读原文](https://www.raywenderlich.com/86477/introducing-ios-design-patterns-in-swift-part-1)

[进阶](https://www.raywenderlich.com/86053/intermediate-design-patterns-in-swift)
