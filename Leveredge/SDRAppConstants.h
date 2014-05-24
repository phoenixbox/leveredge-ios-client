//
//  SDRAppConstants.h
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#ifndef Leveredge_SDRAppConstants_h
#define Leveredge_SDRAppConstants_h

// Development
// Vendor Routes
#define kAPIVendorsIndex @"http://10.0.0.8:3000/api/v1/vendors"

// User Routes
#define kAPIUserLogin @"http://10.0.0.8:3000/api/v1/users/login"

// PreQualified Routes
#define kAPIPreQualifiedEndpoint @"http://10.0.0.8:3000/api/v1/pre_qualifications"

// Production
// Vendor Routes
#define kProdAPIVendorsIndex @"http://mule-rail.herokuapp.com/api/v1/vendors"
// User Routes
#define kProdAPIUserLogin @"http://mule-rail.herokuapp.com/api/v1/users/login"

// PreQualified Routes
#define kProdAPIPreQualifiedEndpoint @"http://mule-rail.herokuapp.com/v1/pre_qualifications"

#endif
