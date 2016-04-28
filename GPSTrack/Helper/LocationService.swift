//
//  LocationService.swift
//  GPSTrack
//
//  Created by Albert Zhang on 3/30/16.
//  Copyright © 2016 Albert Zhang. All rights reserved.
//

import CoreLocation

typealias CheckLocationPermissionResult = (Bool) -> Void
typealias LocationUpdateCallback = (CLLocation) -> Void

class LocationService: NSObject , CLLocationManagerDelegate {

    private static var singleton:LocationService?
    static func service() -> LocationService {
        if singleton == nil {
            singleton = LocationService()
        }
        return singleton!
    }

    // MARK: -

    var locationUpdateCallback:LocationUpdateCallback?

    private var checkPermissionCallback: CheckLocationPermissionResult?
    private var checkPermissionLocMgr: CLLocationManager?

    func checkPermission(result: CheckLocationPermissionResult) {
        let st = CLLocationManager.authorizationStatus()
        if st == .Restricted || st == .Denied {
            result(false)
            return
        }

        if st == .AuthorizedAlways {
            result(true)
            return
        }

        checkPermissionCallback = result

        checkPermissionLocMgr = CLLocationManager()
        checkPermissionLocMgr!.delegate = self
        checkPermissionLocMgr!.requestAlwaysAuthorization()
    }

    // MARK: -

    private var locationManager:CLLocationManager?
    private var _lastLocation:CLLocation?

    var lastLocation:CLLocation? {
        get{
            return _lastLocation
        }
    }

    func start() {
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.pausesLocationUpdatesAutomatically = true
            locationManager!.activityType = .Other
            locationManager!.allowsBackgroundLocationUpdates = true
        }
        _lastLocation = nil
        locationManager?.startUpdatingLocation()
    }

    func stop() {
        _lastLocation = nil;
        locationManager?.stopUpdatingLocation()
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        _lastLocation = locations.last
        print("location update: \(_lastLocation?.coordinate.latitude), \(_lastLocation?.coordinate.longitude), \(_lastLocation?.altitude)")
        if _lastLocation != nil {
            locationUpdateCallback?(_lastLocation!)
        }
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {

    }

    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {

    }

    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {

    }

    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion) {

    }

    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {

    }

    // MARK: -

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if let cb = checkPermissionCallback {
            if status == .AuthorizedAlways {
                cb(true)
                checkPermissionCallback = nil
                checkPermissionLocMgr = nil

            } else if status == .Denied {
                cb(false)
                checkPermissionCallback = nil
                checkPermissionLocMgr = nil
            }
        }
    }

}
