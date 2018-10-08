
class KKHttpError extends Error {
  String msg;
  String toString() => msg;
  StackTrace stackTrace;

  KKHttpError({ this.msg, this.stackTrace });
}