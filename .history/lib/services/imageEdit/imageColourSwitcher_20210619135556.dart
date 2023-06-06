import 'package:flutter/material.dart';

class _OurKey {
  final Object providerCacheKey;
  const _OurKey(this.providerCacheKey);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType == runtimeType) return false;
    return other is _OurKey && other.providerCacheKey == providerCacheKey;
  }

  @override
  int get hashcode => providerCacheKey.hashCode;
}

class OurImageProvider extends ImageProvider<_OurKey> {
  final ImageProvider imageProvider;

  const OurImageProvider(this.imageProvider);

  @override
  ImageStreamCompleter load(_OurKey key, decode) {
    throw UnimplementedError();
  }


  @override
  Future<_OurKey> obtainKey(ImageConfiguration configuration)
}
