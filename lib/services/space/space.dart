import 'package:option_result/option_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scheduleme/constants/api_url.dart';
import 'package:scheduleme/services/space/model.dart';
import 'package:scheduleme/utils/logger.dart';

part 'space.g.dart';

class GetSpaceResponse {
  GetSpaceResponse({this.spaces = const []});
  List<SpacePartedInfo> spaces;

  @override
  GetSpaceResponse from(source) {
    final spaces = <SpacePartedInfo>[];
    for (final v in source) {
      try {
        spaces.add(SpacePartedInfo.fromJson(v));
      } catch (e, stackTrace) {
        logger.e(e, stackTrace: stackTrace);
      }
    }
    this.spaces = spaces;
    return this;
  }
}

@riverpod
class GetSpaces extends _$GetSpaces {
  @override
  AsyncValue<Result<Option<GetSpaceResponse>, String>> build() =>
      const AsyncValue.data(Ok(None()));

  Future getSpace(Option<String> id) async {
    state = const AsyncValue.loading();
    // final result = await Client.instance.get(Uri.parse(
    //     id.isSome() ? ApiURL.spaceWithId(id.unwrap()) : ApiURL.spaces));
    // switch (result) {
    //   case Ok(:final value):
    //     {
    //       final rv = ApiResponse.decodeResponse<GetSpaceResponse>(value.body);
    //       state = AsyncValue.data(rv.status == ApiStatus.success
    //           ? Ok(rv.data)
    //           : Err(rv.error.unwrap().getMessage));
    //     }
    //   case Err(:PrettyException value):
    //     state = AsyncValue.error(Err(value), StackTrace.empty);
    // }
  }
}
