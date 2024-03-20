class KakaoKeywordPlaceModel {
  final String addressName,
      categoryGroupName,
      categoryName,
      phone,
      placeName,
      placeUrl,
      roadAddressName,
      categoryGroupCode,
      id,
      x,
      y;

  KakaoKeywordPlaceModel.fromJson(Map<String, dynamic> json)
      : placeName = json['place_name'],
        placeUrl = json['place_url'],
        categoryName = json['category_name'],
        addressName = json['address_name'],
        roadAddressName = json['road_address_name'],
        id = json['id'],
        phone = json['phone'],
        categoryGroupName = json['category_group_name'],
        categoryGroupCode = json['category_group_code'],
        x = json['x'],
        y = json['y'];
}

/**
id	String	장소 ID
place_name	String	장소명, 업체명
category_name	String	카테고리 이름
category_group_code	String	중요 카테고리만 그룹핑한 카테고리 그룹 코드
category_group_name	String	중요 카테고리만 그룹핑한 카테고리 그룹명
phone	String	전화번호
address_name	String	전체 지번 주소
road_address_name	String	전체 도로명 주소
x	String	X 좌표 혹은 경도(longitude)
y	String	Y 좌표 혹은 위도(latitude)
place_url	String	장소 상세 페이지 URL
distance	String	중심좌표까지의 거리 (단, x,y 파라미터를 준 경우에만 존재)
(단위: 미터(m))
 */