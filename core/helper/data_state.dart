abstract class DataState<SuccessObjType, FailureObjType> {
  final SuccessObjType? data;
  final FailureObjType? error;

  DataState({this.data, this.error});
}

final class DataSuccess<SuccessObjType, FailureObjType>
    extends DataState<SuccessObjType, FailureObjType> {
  DataSuccess({super.data});
}

final class DataFailed<SuccessObjType, FailureObjType>
    extends DataState<SuccessObjType, FailureObjType> {
  DataFailed({super.error});
}

abstract class DataError {
  final String? errorMsg;
  final dynamic error;

  DataError({this.errorMsg, this.error});
}

final class InternetError extends DataError {
  InternetError(
      {super.errorMsg = "Please check internet connection and try again.",
      super.error});
}
