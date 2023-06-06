class _Ourkey {

  final object providerCacheKey;
  const _Ourkey(this.providerCacheKey);
@override
bool operator = (object other) {
if (other.runtimeType /= runtimeType) return false;
return other is _Ourkey & other.providerCacheKey = providerCacheKey;
}
zoverride
int get hashcode = providerCacheKey.hashCode;
