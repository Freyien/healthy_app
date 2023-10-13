import 'package:device_info_plus/device_info_plus.dart';

extension AndroidDeviceInfoExtensions on AndroidDeviceInfo {
  Map<String, dynamic> toMapInfo() => {
        'board': this.board,
        'bootloader': this.bootloader,
        'brand': this.brand,
        'device': this.device,
        'display': this.display,
        'heightInches': this.displayMetrics.heightInches,
        'heightPx': this.displayMetrics.heightPx,
        'sizeInches': this.displayMetrics.sizeInches,
        'widthInches': this.displayMetrics.widthInches,
        'widthPx': this.displayMetrics.widthPx,
        'xDpi': this.displayMetrics.xDpi,
        'yDpi': this.displayMetrics.yDpi,
        'fingerprint': this.fingerprint,
        'hardware': this.hardware,
        'host': this.host,
        'id': this.id,
        'manufacturer': this.manufacturer,
        'model': this.model,
        'product': this.product,
        'serialNumber': this.serialNumber,
        'tags': this.tags,
        'type': this.type,
      };
}

extension IosDeviceInfoExtensions on IosDeviceInfo {
  Map<String, dynamic> toMapInfo() => {
        'identifierForVendor': this.identifierForVendor,
        'isPhysicalDevice': this.isPhysicalDevice.toString(),
        'localizedModel': this.localizedModel,
        'model': this.model,
        'name': this.name,
        'systemName': this.systemName,
        'systemVersion': this.systemVersion,
        'machine': this.utsname.machine,
        'release': this.utsname.release,
        'sysname': this.utsname.sysname,
        'version': this.utsname.version,
      };
}
