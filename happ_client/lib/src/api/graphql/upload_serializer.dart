// import 'package:untitled_client/src/models/customMultipartFile.dart';
import 'package:http/http.dart';


MultipartFile fromGraphQLUploadToDartMultipartFile(MultipartFile file) => file;
MultipartFile fromDartMultipartFileToGraphQLUpload(MultipartFile file) => file;

List<MultipartFile> fromGraphQLListUploadToDartListMultipartFile(List<MultipartFile> file) => file;
List<MultipartFile> fromDartListMultipartFileToGraphQLListUpload(List<MultipartFile> file) => file;

MultipartFile? fromGraphQLUploadNullableToDartMultipartFileNullable(MultipartFile? file) => file;
MultipartFile? fromDartMultipartFileNullableToGraphQLUploadNullable(MultipartFile? file) => file;

List<MultipartFile>? fromGraphQLListNullableUploadToDartListNullableMultipartFile(List<MultipartFile>? file) => file;
List<MultipartFile>? fromDartListNullableMultipartFileToGraphQLListNullableUpload(List<MultipartFile>? file) => file;