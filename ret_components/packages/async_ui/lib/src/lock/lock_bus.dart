/// Token returned from acquire(); call release() in finally.
class LockToken {
  bool _released = false;
  final void Function() _release;
  LockToken(this._release);

  void release() {
    if (_released) return;
    _released = true;
    _release();
  }
}
