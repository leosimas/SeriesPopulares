//
//  SeriesViewController.swift
//  Series Populares
//
//  Created by SoSucesso on 12/29/16.
//  Copyright © 2016 Leonardo Simas. All rights reserved.
//

import UIKit
import EZLoadingActivity

class SeriesViewController : UICollectionViewController {
    
    var currentPage : Int = 0
    var totalPages : Int?
    var series : [Serie] = []
    
    let cellIdentifier = "SerieViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initViews()
        self.requestNextPage()
    }
    
    private func initViews() {
        self.collectionView!.register(UINib(nibName: "SerieViewCell", bundle: nil), forCellWithReuseIdentifier: self.cellIdentifier)
        
        self.collectionView!.addInfiniteScroll { (collectionView) -> Void in
            self.requestNextPage()
        }
        
    }
    
    private func requestNextPage() {
        let page = currentPage + 1
        if ( self.totalPages != nil && page > self.totalPages! ) {
            return
        }
        
        if (page == 1) {
            EZLoadingActivity.show("Carregando...", disableUI: true)
        } else {
            self.collectionView!.beginInfiniteScroll(false)
        }
        
        SeriesDataRequester.sharedInstance.listPopular(page: page, callback: {seriesResponse, errorMsg in
            if ( errorMsg != nil ) {
                self.showAlert(msg : errorMsg!)
                return
            }
            
            if ( self.totalPages == nil ) {
                self.totalPages = seriesResponse?.totalPages
            }
            self.currentPage = page
            
            self.collectionView!.performBatchUpdates({ () -> Void in
                // update collection view
                let newSeries = seriesResponse!.results!
                
                var index = self.series.count
                self.series.append(contentsOf : newSeries)
                
                var arrayIndexPaths = [IndexPath]()
                for _ in newSeries {
                    arrayIndexPaths.append( IndexPath(row: index, section: 0))
                    index += 1
                }
                
                self.collectionView!.insertItems(at: arrayIndexPaths)
                
            }, completion: { (finished) -> Void in
                if (page == 1) {
                    EZLoadingActivity.hide()
                } else {
                    self.collectionView!.finishInfiniteScroll()
                }
            })
            
        })
        
    }
    
    private func showAlert(msg : String) {
        let alertController = UIAlertController(title: "Alerta", message:
            msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func resetSeries() {
        self.currentPage = 0
        self.totalPages = nil
        self.series.removeAll()
    }
    
    // datasource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.series.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: SerieViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! SerieViewCell
        
        cell.setSerie(serie: self.series[indexPath.row])
        
        return cell
    }
    
}
