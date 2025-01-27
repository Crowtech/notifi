import 'package:minio/minio.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/credentials.dart';
import 'package:notifi/models/gps.dart';
import 'package:notifi/models/nestfilter.dart';
import '../api_utils.dart';
import '../models/crowtech_basepage.dart';
import 'dart:math' as math;

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);

// Notifier for uploading a file to minio exposed by a state notifier
// provider
class MinioUpLoader extends Notifier<String> {

 

  @override
  String build() {
    return "good";
  }

  // void generate() {
  //   state = Random().nextInt(9999);
  // }

  //Future<CrowtechBasePage<GPS>> fetchGPS(
  void upload() {
   
  }


// Notifier provider holding the state
final minioProvider =
    NotifierProvider<MinioUpLoader ,String>(MinioUpLoader.new);


void main() async {
  final minio = Minio(
    endPoint:  '//'play.min.io',
    accessKey: 'Q3AM3UQ867SPQQA43P2F',
    secretKey: 'zuf+tfteSlswRu7BJ86wekitnifILbZam1KYY3TG',
    useSSL: true,
    // enableTrace: true,
  );

  final bucket = '00test';
  final object = 'custed.png';
  final copy1 = 'custed.copy1.png';
  final copy2 = 'custed.copy2.png';

  if (!await minio.bucketExists(bucket)) {
    await minio.makeBucket(bucket);
    print('bucket $bucket created');
  } else {
    print('bucket $bucket already exists');
  }

  final poller = minio.listenBucketNotification(
    bucket,
    events: [
      's3:ObjectCreated:*',
    ],
  );
  poller.stream.listen((event) {
    print('--- event: ${event['eventName']}');
  });

  final region = await minio.getBucketRegion('00test');
  print('--- object region:');
  print(region);

  final etag = await minio.fPutObject(bucket, object, 'example/$object');
  print('--- etag:');
  print(etag);

  final url = await minio.presignedGetObject(bucket, object, expires: 1000);
  print('--- presigned url:');
  print(url);

  final copyResult1 = await minio.copyObject(bucket, copy1, '$bucket/$object');
  final copyResult2 = await minio.copyObject(bucket, copy2, '$bucket/$object');
  print('--- copy1 etag:');
  print(copyResult1.eTag);
  print('--- copy2 etag:');
  print(copyResult2.eTag);

  await minio.fGetObject(bucket, object, 'example/$copy1');
  print('--- copy1 downloaded');

  await minio.listObjects(bucket).forEach((chunk) {
    print('--- objects:');
    for (var o in chunk.objects) {
      print(o.key);
    }
  });

  await minio.listObjectsV2(bucket).forEach((chunk) {
    print('--- objects(v2):');
    for (var o in chunk.objects) {
      print(o.key);
    }
  });

  final stat = await minio.statObject(bucket, object);
  print('--- object stat:');
  print(stat.etag);
  print(stat.size);
  print(stat.lastModified);
  print(stat.metaData);

  await minio.removeObject(bucket, object);
  print('--- object removed');

  await minio.removeObjects(bucket, [copy1, copy2]);
  print('--- copy1, copy2 removed');

  await minio.removeBucket(bucket);
  print('--- bucket removed');

  poller.stop();
}