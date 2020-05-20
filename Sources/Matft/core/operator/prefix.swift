//
//  prefix.swift
//  Matft
//
//  Created by Junnosuke Kado on 2020/02/29.
//  Copyright © 2020 jkado. All rights reserved.
//

import Foundation

prefix operator -
public prefix func -(_ mfarray: MfArray) -> MfArray{
    return Matft.mfarray.neg(mfarray)
}

prefix operator !
public prefix func !(_ mfarray: MfArray) -> MfArray{
    return Matft.mfarray.logical_not(mfarray)
}
