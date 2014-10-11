//
//  CustomCell.h
//  StageManager
//
//  Created by Jakub Vallo on 5/1/13.
//  Copyright (c) 2013 pv239. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* cellText;
@property (weak, nonatomic) IBOutlet UIImageView* cellImage;

@end
