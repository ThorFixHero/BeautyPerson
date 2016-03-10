//
//  BaseTableCell.m
//  MMPerson
//
//  Created by 徐文达 on 15/11/5.
//  Copyright © 2015年 徐文达. All rights reserved.
//

#import "BaseTableCell.h"

@implementation BaseTableCell

+(instancetype)cellWithTableView:(UITableView *)table{
    
    static NSString *cellId=nil;
    
    cellId=[NSString stringWithFormat:@"%@",self.class];
    
    [table registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
    
    BaseTableCell *cell=[table dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil]lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
