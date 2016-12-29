//
//  SerieViewCell.swift
//  Series Populares
//
//  Created by SoSucesso on 12/29/16.
//  Copyright © 2016 Leonardo Simas. All rights reserved.
//

import UIKit
import AlamofireImage

class SerieViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var serie : Serie?
    
    func setSerie ( serie : Serie ) {
        self.serie = serie
        
        let imageUrl = SeriesDataRequester.getPosterUrl(serie : serie)
        let url = URL(string: imageUrl)!
        
        imageView.af_setImage(withURL: url, placeholderImage : #imageLiteral(resourceName: "placeholder"))
        label.text = serie.name

    }

}
