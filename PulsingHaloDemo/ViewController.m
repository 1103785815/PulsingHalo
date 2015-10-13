//
//  ViewController.m
//  PulsingHaloDemo
//
//  Created by shuichi on 12/5/13.
//  Modified by ShannonChou on 14-7-8
//  Copyright (c) 2013 Shuichi Tsutsumi. All rights reserved.
//

#import "ViewController.h"
#import "PulsingHaloLayer.h"

#define kMaxRadius 160


@interface ViewController ()
@property (nonatomic, weak) PulsingHaloLayer *mutiHalo;
@property (nonatomic, weak) PulsingHaloLayer *halo;
@property (nonatomic, weak) IBOutlet UIImageView *beaconView;
@property (nonatomic, weak) IBOutlet UIImageView *beaconViewMuti;
@property (nonatomic, weak) IBOutlet UISlider *countSlider;
@property (nonatomic, weak) IBOutlet UISlider *radiusSlider;
@property (nonatomic, weak) IBOutlet UISlider *rSlider;
@property (nonatomic, weak) IBOutlet UISlider *gSlider;
@property (nonatomic, weak) IBOutlet UISlider *bSlider;
@property (nonatomic, weak) IBOutlet UILabel *countLabel;
@property (nonatomic, weak) IBOutlet UILabel *radiusLabel;
@property (nonatomic, weak) IBOutlet UILabel *rLabel;
@property (nonatomic, weak) IBOutlet UILabel *gLabel;
@property (nonatomic, weak) IBOutlet UILabel *bLabel;
@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ///setup single halo layer
    PulsingHaloLayer *layer = [PulsingHaloLayer layer];
    self.halo = layer;
    self.halo.position = self.beaconView.center;
    [self.view.layer insertSublayer:self.halo below:self.beaconView.layer];

    ///setup multiple halo layer
    //you can specify the number of halos by initial method or by instance property "haloLayerNumber"
    PulsingHaloLayer *multiLayer = [PulsingHaloLayer layer];
    self.mutiHalo = multiLayer;
    self.mutiHalo.position = self.beaconViewMuti.center;
    [self.view.layer insertSublayer:self.mutiHalo below:self.beaconViewMuti.layer];
    
    [self setupInitialValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// =============================================================================
#pragma mark - Private

- (void)setupInitialValues {
    
    self.countSlider.value = 3;
    [self countChanged:nil];

    self.radiusSlider.value = 0.5;
    [self radiusChanged:nil];
    
    self.rSlider.value = 0;
    self.gSlider.value = 0.487;
    self.bSlider.value = 1.0;
    [self colorChanged:nil];
}


// =============================================================================
#pragma mark - IBAction

- (IBAction)countChanged:(UISlider *)sender {
    
    float value = floor(self.countSlider.value);
    self.mutiHalo.haloLayerNumber = value;
    self.countLabel.text = [@(value) stringValue];
}

- (IBAction)radiusChanged:(UISlider *)sender {
    
    self.mutiHalo.radius = self.radiusSlider.value * kMaxRadius;
    self.halo.radius = self.radiusSlider.value * kMaxRadius;
    
    self.radiusLabel.text = [@(self.radiusSlider.value) stringValue];
}

- (IBAction)colorChanged:(UISlider *)sender {
    
    UIColor *color = [UIColor colorWithRed:self.rSlider.value
                                     green:self.gSlider.value
                                      blue:self.bSlider.value
                                     alpha:1.0];
    
    [self.mutiHalo setBackgroundColor:color.CGColor];
    [self.halo setBackgroundColor:color.CGColor];
    
    self.rLabel.text = [@(self.rSlider.value) stringValue];
    self.gLabel.text = [@(self.gSlider.value) stringValue];
    self.bLabel.text = [@(self.bSlider.value) stringValue];
}

@end
