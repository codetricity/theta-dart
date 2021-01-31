import 'dart:convert';
import 'package:theta/theta.dart';
import 'package:apitest/options/reset_my_setting.dart';
import 'package:apitest/commands/delete_all.dart';
import 'package:apitest/thumbnails/not-working-list_all_thumnails.dart';
import 'package:apitest/options/set_autobracket.dart';
import 'package:apitest/download_ready.dart';
import 'package:args/args.dart';
import 'package:apitest/list_files.dart';
import 'package:apitest/commands/get_options.dart';
import 'package:apitest/download_file.dart';
import 'package:apitest/get_last_image_url.dart';
import 'package:apitest/commands/get_metadata.dart';
// import 'package:apitest/scratch/test.dart';
import 'package:apitest/download_file_from_state.dart';
import 'package:apitest/options/set_exposure_delay_five.dart';
import 'package:apitest/options/set_exposure_delay_zero.dart';
import 'package:apitest/options/get_timeshift.dart';
import 'package:apitest/options/set_capture_preset.dart';
import 'package:apitest/options/set_hdr.dart';
import 'package:apitest/options/set_shutter.dart';
import 'package:apitest/commands/start_capture.dart';
import 'package:apitest/options/set_my_setting.dart';
import 'package:apitest/options/set_exposure_compensation_two.dart';
import 'package:apitest/options/filter_off.dart';
import '../lib/options/set_language.dart';
import 'package:apitest/thumbnails/get_thumb.dart';
import 'package:apitest/thumbnails/get_thumb_2.dart';
import 'package:apitest/commands/reset.dart';
import 'package:apitest/options/sleep_off.dart';
import 'package:apitest/options/off_off.dart';
import 'package:apitest/list_urls.dart';
import 'package:apitest/thumbnails/save_thumbs.dart';
import 'package:apitest/thumbnails/get_all_thumbs.dart';
import 'package:apitest/thumbnails/write_all_thumbs.dart';
import 'package:apitest/commands/delete_test.dart';
import 'package:apitest/options/set_mode_image.dart';

void prettyPrint(map) {
  print(JsonEncoder.withIndent('  ').convert(map));
}

void printUsage() {
  print("\nusage: dart bin/main.py command\n");
  print("command must be one of the following:");
  print('info -   manufacturer, model, serialNumber, _wlanMacAddress, '
      '_bluetoothMacAddress, firmwareVersion, supportUrl, gps, '
      'gyro, uptime, api, endpoints, apiLevel\n\n'
      'model -  THETA model. SC2, V, Z1, other\n'
      'firmware - camera firmware.  example: 1.60.1\n'
      'state - current camera information\n'
      'status\n'
      'takePicture\n');
  print("listFiles, getOptions, downloadFile");
  print("getMetadata, downloadReady, takeAndDownload");
  print("setExposureDelayFive, setExposureDelayZero, exposureCompensation");
  print("getTimeShift, setCapturePreset, setHdr, saveHdr, setShutter");
  print("filterOff, sleepOff, offOff, reset, resetMySetting");
  print("autoBracket, startCapture, setLanguage");
  print("saveThumbs, getThumb, getThumb2");
  print("deleteAll, setModeImage\n");
  print('example: dart bin/main.py info\n');
}

void main(List<String> args) async {
  var parser = ArgParser();
  parser.parse(args);

  if (args.length < 1) {
    printUsage();
  } else {
    switch (args[0]) {

      /// test case is for scratch data that you can
      /// throw away after you run an API test
      case "test":
        {
          prettyPrint(await Camera.model);
          // test();
        }
        break;

      case "info":
        {
          /// RICOH THETA info
          /// example is in packages/theta/lib/src/
          // Official API reference https://api.ricoh/docs/theta-web-api-v2.1/protocols/info/

          prettyPrint(await Camera.info);
        }
        break;

      case "state":
        {
          /// camera state
          /// API reference https://api.ricoh/docs/theta-web-api-v2.1/protocols/state/
          /// example is in packages/theta/lib/src
          prettyPrint(await state());
        }
        break;

      case "takePicture":
        {
          /// take picture.  must pass payload that is json encoded
          /// API reference https://api.ricoh/docs/theta-web-api-v2.1/commands/camera.take_picture/
          prettyPrint(await takePicture());
        }
        break;

      case "listFiles":
        {
          /// list files
          /// API reference: https://api.ricoh/docs/theta-web-api-v2.1/commands/camera.list_files/
          listFiles();
        }
        break;

      case "saveHdr":
        {
          saveHdr();
        }
        break;

      case "setModeImage":
        {
          setModeImage();
        }
        break;

      case "getOptions":
        {
          /// get options
          getOptions();
        }
        break;

      case "downloadFile":
        {
          /// download a single file
          downloadFile();
        }
        break;

      case "getMetadata":
        {
          getLastImageUrl().then((url) {
            getMetadata(url);
          });
        }
        break;

      case "firmware":
        {
          print(await Camera.firmware);
        }
        break;

      case "model":
        {
          print(await Camera.model);
        }
        break;

      case "downloadReady":
        {
          downloadReady();
        }
        break;

      case "takeAndDownload":
        {
          takeAndDownload();
        }
        break;

      case "setExposureDelayFive":
        {
          setExposureDelayFive();
        }
        break;

      case "setExposureDelayZero":
        {
          setExposureDelayZero();
        }
        break;

      case "getTimeShift":
        {
          getTimeShift();
        }
        break;

      case "setCapturePreset":
        {
          setPreset();
        }
        break;

      case "setHdr":
        {
          setHdr();
        }
        break;

      case "setShutter":
        {
          setShutter();
        }
        break;

      case "autoBracket":
        {
          autoBracket();
        }
        break;

      case "startCapture":
        {
          startCapture();
        }
        break;

      case "exposureCompensation":
        {
          setExposureCompensationTwo();
        }
        break;

      case "filterOff":
        {
          filterOff();
        }
        break;

      case "status":
        {
          if (args.length == 2) {
            prettyPrint(await status(args[1]));
          } else {
            print('please supply id.  Example: dart main.dart status 306');
          }
        }
        break;

      case "setLanguage":
        {
          if (args.length == 2) {
            print('setting lang');
            setLanguage(args[1]);
          } else {
            print(args.length);
            print(
                'please supply language.  Example: dart main.dart setLanguage en-US');
            print(
                'supported values: en-US, en-GB, ja, fr, de, zh-TW, zh-CN, it, ko');
          }
        }
        break;

      case "getThumb":
        {
          String lastImageUrl = await getLastImageUrl();
          getThumb(lastImageUrl);
        }
        break;

      case "getThumb2":
        {
          String lastImageUrl = await getLastImageUrl();
          getThumb2(lastImageUrl);
        }
        break;

      case "listAllThumbnails":
        {
          listAllThumbnails();
        }
        break;

      case 'deleteAll':
        {
          deleteAll();
        }
        break;

      case "reset":
        {
          reset();
        }
        break;

      case "sleepOff":
        {
          sleepOff();
        }
        break;

      case "offOff":
        {
          offOff();
        }
        break;

      case "resetMySetting":
        {
          resetMySetting();
        }
        break;

      case "listUrls":
        {
          listUrls();
        }
        break;
      case "saveThumbs":
        {
          saveThumbs(await listUrls());
        }
        break;

      case "getAllThumbs":
        {
          getAllThumbs(await listUrls());
        }
        break;

      case "writeAllThumbs":
        {
          writeAllThumbs();
        }
        break;

      case "deleteTest":
        {
          deleteTest();
        }
        break;

      default:
        {
          printUsage();
        }
        break;
    }
  }
}
