//
//  Magi.swift
//  magiLoadingPlaceHolder
//
//  Created by 安然 on 2018/8/6.
//  Copyright © 2018年 anran. All rights reserved.
//

import UIKit

class MagiRefresh {
    
    var placeHolder: MagiPlaceHolder? {
        didSet {
            guard let scrollView = self.scrollView else { return }
            for view in scrollView.subviews {
                if view.isKind(of: MagiPlaceHolder.self) {
                    view.removeFromSuperview()
                }
            }
            if let place = placeHolder {
                scrollView.addSubview(place)
                place.isHidden = true
            }
        }
    }
    
    var header: MagiRefreshHeaderConrol? {
        didSet {
            guard let scrollView = self.scrollView else { return }
            scrollView.subviews.forEach { (view) in
                if view.isKind(of: MagiRefreshHeaderConrol.self) {
                    view.removeFromSuperview()
                }
            }
            if let header = header {
                scrollView.addSubview(header)
            }
        }
    }
    
    var footer: MagiRefreshFooterConrol? {
        didSet {
            guard let scrollView = self.scrollView else { return }
            scrollView.subviews.forEach { (view) in
                if view.isKind(of: MagiRefreshFooterConrol.self) {
                    view.removeFromSuperview()
                }
            }
            if let header = header {
                scrollView.addSubview(header)
            }
        }
    }
    
    var scrollView: UIScrollView?
    
    // MAKR: - 根据 DataSource 判断是否自动显示 PlaceHolder
    public func startLoading() {
        placeHolder?.isHidden = true
    }
    
    public func endLoading() {
        getDataAndSet()
    }
    
    public func showPlaceHolder() {
        scrollView?.layoutSubviews()
        placeHolder?.isHidden = false
        if let place = placeHolder {
            scrollView?.bringSubview(toFront: place)
        }
    }
    
    public func hidePlaceHolder() {
        placeHolder?.isHidden = true
    }
    
    // MARK: - Private Method
    fileprivate func totalDataCount() -> NSInteger {
        guard let scrollView = self.scrollView else { return 0 }
        var totalCount: NSInteger = 0
        if scrollView.isKind(of: UITableView.classForCoder()) {
            let tableView = scrollView as? UITableView
            if let section = tableView?.numberOfSections, section >= 1 {
                for index in 0..<section {
                    totalCount += tableView?.numberOfRows(inSection: index) ?? 0
                }
            }
        }
        else if scrollView.isKind(of: UICollectionView.classForCoder()) {
            let collectionView = scrollView as? UICollectionView
            if let section = collectionView?.numberOfSections, section >= 1 {
                for index in 0..<section {
                    totalCount += collectionView?.numberOfItems(inSection: index) ?? 0
                }
            }
        }
        return totalCount
    }
    
    public func getDataAndSet() {
        guard let _ = placeHolder else { return }
        if totalDataCount() == 0 {
            show()
        }
        else {
            hide()
        }
    }
    
    fileprivate func show() {
        if placeHolder?.isAutoShowPlaceHolder == false {
            placeHolder?.isHidden = true
            return
        }
        showPlaceHolder()
    }
    
    fileprivate func hide() {
        if placeHolder?.isAutoShowPlaceHolder == false {
            placeHolder?.isHidden = true
            return
        }
        hidePlaceHolder()
    }
    
}
