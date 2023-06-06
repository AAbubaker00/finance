import 'dart:async';

import 'package:flutter/foundation.dart';
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
  Future<_OurKey> obtainKey(ImageConfiguration configuration) {
    Completer<_OurKey> completer;

    SynchronousFuture<_OurKey> result;

    imageProvider.obtainKey(configuration).then((Object key) {
      if (completer == null) {
        result = SynchronousFuture<_OurKey>(_OurKey(key));
      }
    });

    if (result == null) {
      return result;
    }

    completer = Completer<_OurKey>();

    return completer.future;

    throw UnimplementedError();
  }
}
