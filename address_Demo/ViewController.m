//
//  ViewController.m
//  address_Demo
//
//  Created by Vinod Ramanathan on 19/08/15.
//  Copyright (c) 2015 Vinod Ramanathan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
NSMutableArray *getvalue;
NSMutableArray *getNumber;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    
    getvalue = [[NSMutableArray alloc]init];

    getNumber = [[NSMutableArray alloc]init];
    
    CNContactStore *cstore = [[CNContactStore alloc]init];
   
    
    [cstore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted,NSError *error){
     
     
        if (granted) {
     
            NSLog(@"Granted Permission");
            
            NSMutableArray *key = [[NSMutableArray alloc]initWithObjects:CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey, nil];
            
            CNContactFetchRequest *fr = [[CNContactFetchRequest alloc]initWithKeysToFetch:key];
            
            [cstore enumerateContactsWithFetchRequest:fr error:nil usingBlock:^(CNContact *ct,BOOL *stop){
                
              CNPhoneNumber *pn;
            
              CNLabeledValue *lv;
                
              [getvalue addObject:ct.givenName];
                
                
              for (lv in ct.phoneNumbers) {
                  
                    pn = lv.value;
                  
                }
               
                [getNumber addObject:pn.stringValue];
                
                [_table_list reloadData];
                
            }];
           
            
        }else{
            
            NSLog(@"Denied Permission");
        }
        
        if (error) {
            
            NSLog(@"Error");
        }
        
    }];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ContactsUI **

- (IBAction)open_contacts:(id)sender {
    
    CNContactPickerViewController *cvc = [[CNContactPickerViewController alloc]init];
    [cvc setDelegate:self];
    [self presentViewController:cvc animated:YES completion:nil];
    
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    
  //  CNContact *ct = contactProperty.contact ;
    
    CNPhoneNumber *ph =contactProperty.value;
    
    NSLog(@"%@",ph);
  
    
}


//Table View **

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  return  [getvalue count];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.text = [getvalue objectAtIndex:[indexPath row]];
  
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *phonenumber = [getNumber objectAtIndex:indexPath.row];
    
    NSString *name = [getvalue objectAtIndex:indexPath.row];
    
    UIAlertController *alert_c = [UIAlertController alertControllerWithTitle:name message:phonenumber preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
    }];
    
    [alert_c addAction:action];
    
    [self presentViewController:alert_c animated:YES completion:nil];
    
    
}


@end
