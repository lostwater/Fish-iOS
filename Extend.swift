//
//  Extend.swift
//  Fisheriers
//
//  Created by Lost on 23/02/2016.
//  Copyright © 2016 Feng. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UITableView{
    func reloadData(completion:()->())
    {
        UIView.animateWithDuration(0, animations: {
            self.reloadData()
        }) { (_) in
            completion()
        }    }
}

extension UIViewController
{
    func setUserButton()
    {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "button_userinfo01"), landscapeImagePhone: UIImage(named: "button_userinfo01"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(UIViewController.UserIconClicked))
        self.navigationController?.navigationBar.tintColor = UIColor.darkGrayColor()
        //self.navigationController?.navigationBar.backItem?.rightBarButtonItem = UIBarButtonItem()
    }
    
    
    func UserIconClicked()
    {
        if token == ""
        {
            presentViewController(UIStoryboard(name:"Login",bundle: nil).instantiateInitialViewController()!, animated: true, completion: nil)
        }
        else
        {
            self.sideMenuViewController?.presentLeftMenuViewController()
        }
    }
    
    func setLiveButton()
    {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "button_live01"), landscapeImagePhone: UIImage(named: "button_live01"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(UIViewController.liveButtonClicked))
        self.navigationController?.navigationBar.tintColor = UIColor.darkGrayColor()
        //self.navigationController?.navigationBar.backItem?.rightBarButtonItem = UIBarButtonItem()
    }
    
    func liveButtonClicked()
    {
        let bundle = NSBundle(URL: NSBundle.mainBundle().URLForResource("LCStreamingBundle" , withExtension: "bundle")!)
        let vc = CaptureStreamingViewController(nibName: "CaptureStreamingViewController", bundle: bundle, title: nil, activityId: "A20160502000025w", userId: "823100", secretKey: "2e44b05a1d3b751efc6a3a3eb1654e79", orientation: CaptureStreamingViewControllerOrientation.Portrait)
        presentViewController(vc, animated: true, completion: nil)
        //navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIImageView
{
    func setBasicImage(var path : String?)
    {
        if path == nil
        {
            self.image = defaultBasicImage
        }
        else
        {
            path = path?.stringByReplacingOccurrencesOfString("\\", withString: "/")
            let url = NSURL(string:(domain +  path!))
            self.sd_setImageWithURL(url, placeholderImage : defaultBasicImage)
        }
    }
    
    func setHeaderImage(var path : String?)
    {
        if path == nil
        {
            self.image = defaultAvatarImage
        }
        else
        {
            path = path?.stringByReplacingOccurrencesOfString("\\", withString: "/")
            let url = NSURL(string: domain +  path!)
            self.sd_setImageWithURL(url, placeholderImage : defaultAvatarImage)
        }
    }
    
    func setAdImage(var path : String?)
    {
        self.contentMode = UIViewContentMode.ScaleAspectFill
        self.layer.masksToBounds = true
        if path == nil
        {
            self.image = UIImage(named:"th.jpeg")
        }
        else
        {
            path = path?.stringByReplacingOccurrencesOfString("\\", withString: "/")
            let url = NSURL(string: domain +  path!)
            self.sd_setImageWithURL(url, placeholderImage : UIImage(named:"th.jpeg"))
        }
    }
    
    func resetUserImage(var path : String?, done: ()->())
    {
        self.layer.masksToBounds = true
        if path == nil
        {
            self.image = UIImage(named:"avatar01")
        }
        else
        {
            
            path = path?.stringByReplacingOccurrencesOfString("\\", withString: "/")
            path = path?.stringByReplacingOccurrencesOfString("~", withString: "")
            let url = NSURL(string: domain +  path!)
            SDImageCache.sharedImageCache().removeImageForKey(url?.absoluteString, fromDisk:true)
            self.sd_setImageWithURL(url, placeholderImage: UIImage(named:"Hall-of-fame-avatar01"), completed: { (_image, _error, _type, _url) in
                done()
            })
            //self.sd_setImageWithURL(url, placeholderImage : UIImage(named:"Hall-of-fame-avatar01"))
        }
    }
    
    func setUserImage(var path : String?)
    {
        self.layer.masksToBounds = true
        if path == nil
        {
            self.image = UIImage(named:"avatar01")
        }
        else
        {
            
            path = path?.stringByReplacingOccurrencesOfString("\\", withString: "/")
            path = path?.stringByReplacingOccurrencesOfString("~", withString: "")
            let url = NSURL(string: domain +  path!)
            
            self.sd_setImageWithURL(url, placeholderImage : UIImage(named:"Hall-of-fame-avatar01"))
        }
    }
}