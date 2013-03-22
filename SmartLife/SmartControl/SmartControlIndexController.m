//
//  SmartControlIndexController.m
//  SmartLife
//
//  Created by zppro on 13-3-22.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "SmartControlIndexController.h"
#import "CDevice.h"
#import "SmartControlDetailController.h"

#define cellWidth 216.0f/2.0f
#define cellHeight 120.0f/2.0f
#define cellSplitWidth 35
#define cellSplitHeight 35
#define tileRows 4
#define tileColumn 2

@interface SmartControlIndexController ()
@property (nonatomic, retain) NSArray  *arrDevices;
@property (nonatomic, retain) TileWall *tileWall;
@property (nonatomic, retain) UIImage *defaultBackgroundImage;

@end

@implementation SmartControlIndexController
@synthesize arrDevices;
@synthesize tileWall;
@synthesize defaultBackgroundImage;
- (void)dealloc {
    MARK;
    self.arrDevices = nil;
    self.tileWall = nil;
    self.defaultBackgroundImage = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.defaultBackgroundImage = MF_PngOfDefaultSkin(@"SmartControl/device_01.png"); //Default Cell BackgroundImage
    [self fetchDataLocal];
    
    [self createTileWall];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchDataLocal{
    /*
    NSDictionary *dataItem11 = [NSDictionary dictionaryWithObjectsAndKeys:@"TEST01",@"DeviceId",@"AirCondition01",@"DeviceCode",@"空调",@"DeviceName",NB(FALSE),@"SwitchOnFlag",appSession.userId,@"UserId",NB(FALSE),@"LocalSyncFlag",NI(1),@"OrderNo",nil];
    [CDevice createWithIEntity:dataItem11];
    
    NSDictionary *dataItem12 = [NSDictionary dictionaryWithObjectsAndKeys:@"TEST02",@"DeviceId",@"Switch01",@"DeviceCode",@"开关一",@"DeviceName",NB(FALSE),@"SwitchOnFlag",appSession.userId,@"UserId",NB(FALSE),@"LocalSyncFlag",NI(2),@"OrderNo",nil];
    [CDevice createWithIEntity:dataItem12];
    
    NSDictionary *dataItem21 = [NSDictionary dictionaryWithObjectsAndKeys:@"TEST03",@"DeviceId",@"WaterHeater01",@"DeviceCode",@"热水器",@"DeviceName",NB(FALSE),@"SwitchOnFlag",appSession.userId,@"UserId",NB(FALSE),@"LocalSyncFlag",NI(3),@"OrderNo",nil];
    [CDevice createWithIEntity:dataItem21];
    
    NSDictionary *dataItem22 = [NSDictionary dictionaryWithObjectsAndKeys:@"TEST04",@"DeviceId",@"Switch02",@"DeviceCode",@"开关二",@"DeviceName",NB(FALSE),@"SwitchOnFlag",appSession.userId,@"UserId",NB(FALSE),@"LocalSyncFlag",NI(4),@"OrderNo",nil];
    [CDevice createWithIEntity:dataItem22];
    
    NSDictionary *dataItem31 = [NSDictionary dictionaryWithObjectsAndKeys:@"TEST05",@"DeviceId",@"Fountain01",@"DeviceCode",@"饮水机",@"DeviceName",NB(FALSE),@"SwitchOnFlag",appSession.userId,@"UserId",NB(FALSE),@"LocalSyncFlag",NI(5),@"OrderNo",nil];
    [CDevice createWithIEntity:dataItem31];
    
    NSDictionary *dataItem32 = [NSDictionary dictionaryWithObjectsAndKeys:@"TEST06",@"DeviceId",@"Switch03",@"DeviceCode",@"开关三",@"DeviceName",NB(FALSE),@"SwitchOnFlag",appSession.userId,@"UserId",NB(FALSE),@"LocalSyncFlag",NI(6),@"OrderNo",nil];
    [CDevice createWithIEntity:dataItem32];
    
    NSDictionary *dataItem41 = [NSDictionary dictionaryWithObjectsAndKeys:@"TEST07",@"DeviceId",@"Sound01",@"DeviceCode",@"音响",@"DeviceName",NB(FALSE),@"SwitchOnFlag",appSession.userId,@"UserId",NB(FALSE),@"LocalSyncFlag",NI(7),@"OrderNo",nil];
    [CDevice createWithIEntity:dataItem41];
    
    NSDictionary *dataItem42 = [NSDictionary dictionaryWithObjectsAndKeys:@"TEST08",@"DeviceId",@"curtain01",@"DeviceCode",@"窗帘",@"DeviceName",NB(FALSE),@"SwitchOnFlag",appSession.userId,@"UserId",NB(FALSE),@"LocalSyncFlag",NI(8),@"OrderNo",nil];
    [CDevice createWithIEntity:dataItem42];
    
    NSDictionary *dataItem51 = [NSDictionary dictionaryWithObjectsAndKeys:@"TEST09",@"DeviceId",@"Socket01",@"DeviceCode",@"插座一",@"DeviceName",NB(FALSE),@"SwitchOnFlag",appSession.userId,@"UserId",NB(FALSE),@"LocalSyncFlag",NI(9),@"OrderNo",nil];
    [CDevice createWithIEntity:dataItem51];
    
    NSDictionary *dataItem52 = [NSDictionary dictionaryWithObjectsAndKeys:@"TEST10",@"DeviceId",@"Socket02",@"DeviceCode",@"插座二",@"DeviceName",NB(FALSE),@"SwitchOnFlag",appSession.userId,@"UserId",NB(FALSE),@"LocalSyncFlag",NI(10),@"OrderNo",nil];
    [CDevice createWithIEntity:dataItem52];
    
    NSDictionary *dataItem61 = [NSDictionary dictionaryWithObjectsAndKeys:@"TEST11",@"DeviceId",@"Socket03",@"DeviceCode",@"插座三",@"DeviceName",NB(FALSE),@"SwitchOnFlag",appSession.userId,@"UserId",NB(FALSE),@"LocalSyncFlag",NI(11),@"OrderNo",nil];
    [CDevice createWithIEntity:dataItem61];
    
    NSDictionary *dataItem62 = [NSDictionary dictionaryWithObjectsAndKeys:@"TEST12",@"DeviceId",@"Socket04",@"DeviceCode",@"插座四",@"DeviceName",NB(FALSE),@"SwitchOnFlag",appSession.userId,@"UserId",NB(FALSE),@"LocalSyncFlag",NI(12),@"OrderNo",nil];
    [CDevice createWithIEntity:dataItem62];
    
    [moc save];
    */
    self.arrDevices = [CDevice listDevicesByUser:appSession.userId];
}

#pragma mark 子类重写方法

- (UIImage*) getFooterBackgroundImage{
    return nil;
}

#pragma mark - tile

- (void)createTileWall {
    if (tileWall != nil) {
        [tileWall removeFromSuperview];
    }
    
    tileWall = [[TileWall alloc] initWithOrigin:CGPointMake(35, 35)];
    tileWall.blockSplitWidth = 10;
    tileWall.tileWallDelegate = self;
    [self.containerView addSubview:tileWall];
    tileWall.tileBlocks = [self createTileBlocks];
    [tileWall refresh];
    
    /*
    TileBlock *defaultOne = [tileWall.tileBlocks objectAtIndex:0];
    for (int i = 0; i < [defaultOne.tiles count]; i++) {
        CDevice *device = [self.arrDevices objectAtIndex:i];
        Tile *tile = [defaultOne.tiles objectAtIndex:i];
        //tile.backgroundColor = [UIColor clearColor];
    }
    */
}

- (NSMutableArray*)createTileBlocks {
    MARK;
    int blockCount = ([self.arrDevices count] - 1)/ (tileRows*tileColumn);
    NSMutableArray *tileBlocks = [NSMutableArray array];
    for (int i = 0; i <= blockCount; i++) {
        TileBlock *tileBlock = [[TileBlock alloc] initWithWall:self.tileWall withGird:CCGGridMake(tileRows,tileColumn) andCellSize:(CGSize) CGSizeMake(cellWidth, cellHeight) andCellSplitSize:CGSizeMake(cellSplitWidth, cellSplitHeight)];
        tileBlock.tiles = [self createTilesInBlockIndex:i];
        [tileBlocks addObject:tileBlock];
        [tileBlock release];
    }
    return tileBlocks;
}

- (NSMutableArray*)createTilesInBlockIndex:(int)blockIndex {
    NSUInteger len = (blockIndex + 1) * (tileRows*tileColumn) < [self.arrDevices count] ? (tileRows*tileColumn) : ([self.arrDevices count] - blockIndex * (tileRows*tileColumn));
    
    NSRange r = NSMakeRange(blockIndex * (tileRows*tileColumn), len);
    NSArray *catalogInBlock = [self.arrDevices subarrayWithRange:r];
    
    __block int i = 0;
    return  [NSMutableArray arrayWithArray:[catalogInBlock map:^id(id obj) {
        int locationFromX = (i / tileColumn)+1;
        int locationFromY = (i % tileColumn)+1;
        CDevice *device = (CDevice *)obj;
        Tile *tile = [[[Tile alloc] initWithLocation:CCGGridLocationMake(locationFromX, locationFromY) andDefaultBackgroundImage:self.defaultBackgroundImage] autorelease];
        tile.titleLabel.text = device.deviceName;
        tile.showMode = TileShowModeTextBigIconSmall;
        tile.delegate = self; 
        tile.normalColor = [UIColor clearColor];
        i++;
        return tile;
    }]];
}

#pragma mark -Tile Delegate
- (void)tileTapped:(Tile *)tile {
    [tile scaleMe2D];
    CDevice *device = [self.arrDevices objectAtIndex:((TileBlock *)[tile superview]).indexInTileWall * (tileRows*tileColumn) + tile.indexInTileBlock];
    SmartControlDetailController *smartControlDetailControllerVC = [[SmartControlDetailController alloc] initWithDevice:device];
    [self presentModalViewController:smartControlDetailControllerVC animated: YES];
}

#pragma mark -TileWall Delegate
- (void)tileWall:(TileWall *)tileWall scrollFrom:(TileBlock *)fromTileBlock to:(TileBlock *) toTileBlock {
    
    /*
    double delayInSeconds = 0.5f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [fromTileBlock.tiles each:^(id sender) {
            Tile *tile = (Tile*)sender;
            [tile restore];
        }];
        
        __block int i = 0;
        [toTileBlock.tiles each:^(id sender) {
            __block Tile *tile = (Tile*)sender;
            double delayInSeconds = i * 0.07f;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
                //int indexTile = (toTileBlock.indexInTileWall*(tileRows*tileColumn)+tile.indexInTileBlock);
                //CDevice *device = [self.arrDevices objectAtIndex:indexTile];
            });
            i++;
        }];
    });
    */
}



@end
