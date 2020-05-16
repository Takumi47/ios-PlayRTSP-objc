//
//  RTSPListViewController.m
//  PlayRTSP_Objc
//
//  Created by xander on 5/15/20.
//  Copyright © 2020 com.xander. All rights reserved.
//

#import "RTSPListViewController.h"
#import "XDefer.h"
#import "XButton.h"
#import "RTSPViewCell.h"
#import "RTSPItemModel.h"
#import "IJKMediaService.h"
#import "RTSPViewController.h"
#import "UIViewController+SegueHandler.h"
#import "UICollectionView+ApplyChanges.h"

#define RTSP_DEFAULT_NAME @"Cam_"
#define RTSP_DEFAULT_URL @"rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov"

typedef void (^Tuple)(NSString*__autoreleasing *, NSString*__autoreleasing *);

NSString * const kCellReuseId = @"Cell";
static const CGFloat kNumberOfItemsInARow = 2;
static const CGFloat kItemHorizontalOffset = 16;
static const CGFloat kItemHeightByWidthRatio = 180/180;
static const CGFloat kMinimumInteritemSpacing = 8;

@interface RTSPListViewController ()

@property (weak, nonatomic) IBOutlet XButton *addRTSPButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) UIBarButtonItem *trashButton;
@property (nonatomic) UIBarButtonItem *doneButton;
@property (nonatomic) UITapGestureRecognizer *tapGesture;

@end

@implementation RTSPListViewController

#pragma mark - Lifecycle

- (UIBarButtonItem*)trashButton {
    return [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                        target:self
                                                        action:@selector(onTrashButtonTapped)];
}

- (UIBarButtonItem*)doneButton {
    return [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                        target:self
                                                        action:@selector(onDoneButtonTapped)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addObservers];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.collectionView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeObservers];
}

- (void)initUI {
    self.navigationItem.rightBarButtonItem = self.trashButton;
    
    void (^setupLayout)(UICollectionViewFlowLayout*) = ^(UICollectionViewFlowLayout *layout) {
        layout.minimumLineSpacing = 16;
        layout.minimumInteritemSpacing = kMinimumInteritemSpacing;
        layout.sectionInset = UIEdgeInsetsMake(24, kItemHorizontalOffset, 64, kItemHorizontalOffset);
    };
    
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        setupLayout((UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout);
    }
    
    self.collectionView.alwaysBounceVertical = false;
    [self.collectionView registerClass:[RTSPViewCell class] forCellWithReuseIdentifier:kCellReuseId];
    
    self.tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRTSP:)];
    [self.collectionView addGestureRecognizer:self.tapGesture];
}

- (void)addObservers {
    RTSPItemModel.didUpdate = ^(RLMCollectionChange *changes) {
        [self.collectionView applyWithChanges:changes];
    };
}

- (void)removeObservers {
    RTSPItemModel.didUpdate = nil;
}

#pragma mark - Override

- (void)setEditing:(BOOL)editing {
    [super setEditing:editing];
    [self.addButton setEnabled:!editing];
    [self.collectionView reloadData];
}

#pragma mark - Selector

- (IBAction)onAddButtonTapped:(id)sender {
    [self addRTSP];
}

- (void)onTrashButtonTapped {
    if (RTSPItemModel.items.count == 0) { return; }
    self.navigationItem.rightBarButtonItem = self.doneButton;
    [self setEditing:true];
}

- (void)onDoneButtonTapped {
    self.navigationItem.rightBarButtonItem = self.trashButton;
    [self setEditing:false];
}

- (void)tapRTSP:(UITapGestureRecognizer*)gesture {
    if (self.isEditing) { return; }
    
    /* get indexpath */
    CGPoint p1 = [gesture locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p1];
    
    /* check tap area */
    RTSPViewCell *cell = (RTSPViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    CGPoint p2 = [gesture locationInView:cell];
    
    if (CGRectContainsPoint(cell.rtspView.contentView.frame, p2)) {
        
        /* close all other media */
        RTSPItem *item = RTSPItemModel.items[indexPath.item];
        [IJKMediaService.sharedInstance setSingleMediaWithUUID:item.uuid];
        
        /* play selected media */
        if (![IJKMediaService.sharedInstance hasMediaWithUUID:item.uuid]) {
            [IJKMediaService.sharedInstance setMediaWithUUID:item.uuid url:item.url];
        }
        
        Tuple cellInfo = ^(NSString **cellHeroId, NSString **cellUUID) {
            *cellHeroId = cell.heroID;
            *cellUUID = item.uuid;
        };
        
        [self performSegueWithSegueIdentifier:Detail sender:cellInfo];
    }
}

- (void)addRTSP {
    __block UITextField *nameField = [[UITextField alloc]init];
    __block UITextField *urlField = [[UITextField alloc]init];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add RTSP"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    // cancel action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    // add action
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ((nameField.text.length != 0) && (urlField.text.length != 0)) {
            [RTSPItemModel addWithName:nameField.text url:urlField.text];
        }
    }];
    [addAction setEnabled:false];
    [alert addAction:addAction];
    
    [NSNotificationCenter.defaultCenter addObserverForName:UITextFieldTextDidChangeNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        if ((nameField.text.length != 0) && (urlField.text.length != 0)) {
            [addAction setEnabled:true];
        }
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        nameField = textField;
        nameField.placeholder = @"Name";
        nameField.text = RTSP_DEFAULT_NAME;
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        urlField = textField;
        urlField.placeholder = @"rtsp://";
        urlField.text = RTSP_DEFAULT_URL;
    }];
    
    [self presentViewController:alert animated:true completion:^{
        [nameField becomeFirstResponder];
    }];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RTSPItem *item = RTSPItemModel.items[indexPath.item];
    
    void (^setupCell)(RTSPViewCell*) = ^(RTSPViewCell *rtspCell) {
        [rtspCell setShaking:self.isEditing];
        rtspCell.heroID = [NSString stringWithFormat:@"rtsp_%li", (long)indexPath.item];
        rtspCell.rtspView.object = item;
        rtspCell.rtspView.playHandler = ^(NSString *uuid, NSString *url) {
            [self playWithUUID:uuid url:url];
        };
        rtspCell.rtspView.deletionHandler = ^(NSString *uuid) {
            [self deleteWithUUID:uuid];
        };
    };
    
    if ([cell isKindOfClass:[RTSPViewCell class]]) {
        setupCell((RTSPViewCell*)cell);
    }
}

- (void)playWithUUID:(NSString*)uuid url:(NSString*)url {
    if (self.isEditing) { return; }
    [IJKMediaService.sharedInstance setMediaWithUUID:uuid url:url];
    [self.collectionView reloadData];
}

- (void)deleteWithUUID:(NSString*)uuid {
    [IJKMediaService.sharedInstance removeMediaWithUUID:uuid];
    [RTSPItemModel deleteWithUUID:uuid];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = RTSPItemModel.items.count;
    id defer;
    defer = [XDefer block:^{
        [self.addRTSPButton isVisible:(count == 0)];
        if (count == 0) {
            [self onDoneButtonTapped];
        }
    }];
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseId forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat totalSpace = 2 * kItemHorizontalOffset + kNumberOfItemsInARow * kMinimumInteritemSpacing;
    CGFloat width = (collectionView.bounds.size.width - totalSpace) / kNumberOfItemsInARow;
    CGFloat height = width * kItemHeightByWidthRatio;
    return CGSizeMake(width, height);
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    SegueIdentifier segueId = [self segueIdentifierFromSegue:segue];
    if ((segueId == Detail) &&
        ([segue.destinationViewController isKindOfClass:[RTSPViewController class]])) {
        
        if (sender) {
            Tuple cellInfo = (Tuple)sender;
            RTSPViewController *destVC = (RTSPViewController*)segue.destinationViewController;
            
            NSString *heroID;
            NSString *uuid;
            cellInfo(&heroID, &uuid);
            
            destVC.view.heroID = heroID;
            destVC.uuid = uuid;
        }
    }
}

@end
