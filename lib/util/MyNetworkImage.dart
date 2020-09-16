import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ImageUtil.dart';

class MyNetworkImage extends ImageProvider<MyNetworkImage> {
  /// Creates an object that fetches the image at the given URL.
  ///
  /// The arguments must not be null.
  const MyNetworkImage(this.url, {this.scale = 1.0, this.headers, this.sdCache})
      : assert(url != null),
        assert(scale != null);

  /// The URL from which the image will be fetched.
  final String url;

  final bool sdCache;

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  /// The HTTP headers that will be used with [HttpClient.get] to fetch image from network.
  final Map<String, String> headers;
  @override
  Future<MyNetworkImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<MyNetworkImage>(this);
  }

  @override
  ImageStreamCompleter load(MyNetworkImage key,DecoderCallback decode) {
    final StreamController<ImageChunkEvent> chunkEvents = StreamController<ImageChunkEvent>();

    return MultiFrameImageStreamCompleter(

      codec: _loadAsync(key, chunkEvents),

      chunkEvents: chunkEvents.stream,
      scale: key.scale,
      informationCollector: () {
        return <DiagnosticsNode>[
          DiagnosticsProperty<MyNetworkImage>('Image provider', this),
          DiagnosticsProperty<MyNetworkImage>('Image key', key),
        ];
      },
    );
  }
  Future<Codec> _loadAsync1(MyNetworkImage key) async {
    assert(key == this);
    final Uint8List bytes = await ImageUtil.loadAsync(key.url);
    if (bytes != null &&
        bytes.lengthInBytes != null &&
        bytes.lengthInBytes != 0) {
      print("success");
      return await PaintingBinding.instance.instantiateImageCodec(bytes);
    }
/*    final Uri resolved = Uri.base.resolve(key.url);
    http.Response response  = await http.get(resolved);
    if (response.statusCode != HttpStatus.ok)
      throw Exception('HTTP request failed, statusCode: ${response?.statusCode}, $resolved');
    final Uint8List bytes = await response.bodyBytes;
    await ImageUtil.saveImage(key.url,key.url);
    print("save =${sdCache}");
    if(sdCache==null){
      final Uint8List bytes = await ImageUtil.saveImage(key.url,key.url);
      if (bytes.lengthInBytes == 0){
        throw Exception('MyNetworkImage is an empty file:' +key.url);
      }
      sdCache
     // return await PaintingBinding.instance.instantiateImageCodec(bytes);
    }else{
      return null;
    }
    */
  }
  Future<Codec> _loadAsync(
      MyNetworkImage key,
      StreamController<ImageChunkEvent> chunkEvents,
      ) async {
    try {
/*        final Uri resolved = Uri.base.resolve(key.url);
        final HttpClientRequest request = await _httpClient.getUrl(resolved);
        headers?.forEach((String name, String value) {
          request.headers.add(name, value);
        });
        final HttpClientResponse response = await request.close();
        if (response.statusCode != HttpStatus.ok)
          throw Exception('HTTP request failed, statusCode: ${response?.statusCode}, $resolved');
        //将网络返回的 response 信息，转换成内存中的 Uint8List bytes。这里面有解压 gzip 的逻辑。*/
      final Uint8List bytes = await ImageUtil.loadAsync(key.url);
/*        final Uint8List bytes = await consolidateHttpClientResponseBytes(
          response,
          onBytesReceived: (int cumulative, int total) {
            chunkEvents.add(ImageChunkEvent(
              cumulativeBytesLoaded: cumulative,
              expectedTotalBytes: total,
            ));
          },
        );*/
      if (bytes.lengthInBytes == 0)
        throw Exception('NetworkImage is an empty file: ${key?.url}');

      return PaintingBinding.instance.instantiateImageCodec(bytes);
    } finally {
      chunkEvents.close();
    }
  }
  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final MyNetworkImage typedOther = other;
    return url == typedOther.url && scale == typedOther.scale;
  }

  @override
  int get hashCode => hashValues(url, scale);
  @override
  String toString() => '$runtimeType("$url", scale: $scale)';
}
