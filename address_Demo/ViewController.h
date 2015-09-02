//
//  ViewController.h
//  address_Demo
//
//  Created by Vinod Ramanathan on 19/08/15.
//  Copyright (c) 2015 Vinod Ramanathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>


@interface ViewController : UIViewController <CNContactPickerDelegate,UITableViewDataSource,UITableViewDelegate>


- (IBAction)open_contacts:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *table_list;

@end

