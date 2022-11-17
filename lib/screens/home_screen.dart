import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const InfoHome();
  }
}

class InfoHome extends StatefulWidget {
  const InfoHome({Key? key}) : super(key: key);

  @override
  State<InfoHome> createState() => _InfoHomeState();
}

class _InfoHomeState extends State<InfoHome> {

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  List<ParameterItem> _deviceData = <ParameterItem>[];


  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    var deviceData = <ParameterItem>[];

    try {
      if (kIsWeb) {
        deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        if (Platform.isAndroid) {
          deviceData =
              _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } else if (Platform.isIOS) {
          deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        } else if (Platform.isLinux) {
          deviceData = _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);
        } else if (Platform.isMacOS) {
          deviceData = _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
        } else if (Platform.isWindows) {
          deviceData =
              _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo);
        }
      }
    } on PlatformException {
      ParameterItem it = ParameterItem('Error:','Failed to get platform version.');
      deviceData.add(it);
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  List<ParameterItem> _readAndroidBuildData(AndroidDeviceInfo build) {
    List<ParameterItem> pi = <ParameterItem>[];

    build.toMap().forEach((key, value) {
      pi.add(ParameterItem(key.toString(), value));
    });

    return pi;
  }

  List<ParameterItem> _readIosDeviceInfo(IosDeviceInfo data) {
    List<ParameterItem> pi = <ParameterItem>[];

    data.toMap().forEach((key, value) {
      pi.add(ParameterItem(key.toString(), value));
    });

    return pi;
  }

  List<ParameterItem> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
    List<ParameterItem> pi = <ParameterItem>[];

    data.toMap().forEach((key, value) {
      pi.add(ParameterItem(key.toString(), value));
    });

    return pi;
  }

  List<ParameterItem> _readWebBrowserInfo(WebBrowserInfo data) {
    List<ParameterItem> pi = <ParameterItem>[];

    data.toMap().forEach((key, value) {
      pi.add(ParameterItem(key.toString(), value));
    });

    return pi;
  }

  List<ParameterItem> _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    List<ParameterItem> pi = <ParameterItem>[];

    data.toMap().forEach((key, value) {
      pi.add(ParameterItem(key.toString(), value));
    });

    return pi;
  }

  List<ParameterItem> _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    List<ParameterItem> pi = <ParameterItem>[];

    data.toMap().forEach((key, value) {
      pi.add(ParameterItem(key.toString(), value));
    });

    return pi;
  }

  String getTitleText(){

    if(kIsWeb) return 'Інфо що до Web Browser';

    return Platform.isAndroid
        ? 'Інформація про Android пристрій'
        : Platform.isIOS
        ? 'Інформація про iOS пристрій'
        : Platform.isLinux
        ? 'Інформація про Linux пристрій'
        : Platform.isMacOS
        ? 'Інформація про MacOS пристрій'
        : Platform.isWindows
        ? 'Інформація про Windows пристрій'
        : '';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getTitleText(),
          ),
        actions:  [
          IconButton(onPressed: (){
            _deviceData.clear();
            initPlatformState();
          },
              icon: const Icon(Icons.recycling_sharp)
          ),
        ],
        ),

        body:Column(

          children: <Widget>[
            const Text('Дані пристрою',
            style: TextStyle(
              backgroundColor: Colors.blueAccent,
              color: Colors.yellowAccent,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
            Expanded(
                child:GridOfList(deviceData: _deviceData),
            ),
          ],
        ),

      );
   }
}

class GridOfList extends StatelessWidget {
  const GridOfList({
    Key? key,
    required List<ParameterItem> deviceData,
  }) : _deviceData = deviceData, super(key: key);

  final List<ParameterItem> _deviceData;

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: _deviceData.length,
        itemBuilder: (context, index){
          return ListTile(

            title: Text(_deviceData[index].propertyName,
              style: const TextStyle(
                backgroundColor: Colors.black12,
                fontWeight: FontWeight.bold,
            ),
            ),
            subtitle: Text(_deviceData[index].property.toString()),
          );
        }
    );

  }
}

class ParameterItem {
  late final String propertyName;
  dynamic property;

  ParameterItem(this.propertyName, this.property);

}




