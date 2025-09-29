import '../domain/models/api_response.dart';
import 'model/generic_list_response.dart';
import 'model/generic_response.dart';


// common response
typedef CommonDataResponse<T> = ApiResponse<GenericResponse<T>>;

// common list response
typedef CommonListDataResponse<T> = ApiResponse<GenericListResponse<T>>;