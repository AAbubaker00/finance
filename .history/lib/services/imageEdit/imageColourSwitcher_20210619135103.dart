import 'package:flutter/cupertino.dart';

class _Ourkey {
  final Object providerCacheKey;
  const _Ourkey(this.providerCacheKey);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType == runtimeType) return false;
    return other is _Ourkey && other.providerCacheKey == providerCacheKey;
  }

  @override
  int get hashcode => providerCacheKey.hashCode;
}

Class OurImageProvider extends ImageProvide<_QurKey>
