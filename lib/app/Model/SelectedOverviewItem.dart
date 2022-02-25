class SelectedOverviewItem
{
  late String guid;
  late String overviewItemGuid;
  late String deviceGuid;

  Map toJson() => {
        'guid': guid,
        'overviewItemGuid': overviewItemGuid,
        'deviceGuid': deviceGuid,
      };

      static SelectedOverviewItem fromJson(Map<String, dynamic> json){
         var i = SelectedOverviewItem();
         i.guid = json['guid'].toString();
         i.overviewItemGuid = json['overiviewItemGuid'].toString();
         i.deviceGuid = json['deviceGuid'].toString();
         return i;
       }
}
