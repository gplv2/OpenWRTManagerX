import 'package:openwrt_managerx/common/api_factory/api.dart';
import 'package:openwrt_managerx/common/api_factory/dio_factory.dart';
import 'package:openwrt_managerx/common/utils/utils.dart';
import 'package:openwrt_managerx/src/home/model/res_partner_model.dart';

resPartnerApi({required OnResponse<ResPartnerModel> onResponse}) {
  Api.searchRead(
    model: "res.partner",
    domain: [],
    fields: ["name", "email", "image_512"],
    onResponse: (response) {
      onResponse(ResPartnerModel.fromJson(response));
    },
    onError: (error, data) {
      handleApiError(error);
    },
  );
}
