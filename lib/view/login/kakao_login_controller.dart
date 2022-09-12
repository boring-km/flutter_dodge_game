import 'dart:async';

import 'package:dodge_game/provider/get_shared_prefs.dart';
import 'package:dodge_game/provider/shared_data.dart';
import 'package:dodge_game/utils/logger.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class KakaoLoginController extends GetxController {
  Future<void> login() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        await getUserInfo();
        Log.i('카카오톡으로 로그인 성공');
      } catch (error) {
        Log.e('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          await getUserInfo();
          Log.i('카카오계정으로 로그인 성공');
        } catch (error) {
          Log.e('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        await getUserInfo();
        Log.i('카카오계정으로 로그인 성공');
      } catch (error) {
        Log.e('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  void _moveToMainView() {
    LoginSharedPrefs.saveLoginPlatform('kakao');
    unawaited(Get.offAndToNamed('/menu'));
  }

  Future<void> getUserInfo() async {
    User user;
    try {
      user = await UserApi.instance.me();
      await _saveUser(inputUser: user);
    } catch (error) {
      Log.e('사용자 정보 요청 실패 $error');
      return;
    }
    final scopes = <String>[];

    if (user.kakaoAccount?.emailNeedsAgreement == true) {
      scopes.add('account_email');
    }

    if (user.kakaoAccount?.profileNicknameNeedsAgreement == true) {
      scopes.add('profile_nickname');
    }

    if (scopes.isNotEmpty) {
      Log.i('사용자에게 추가 동의 받아야 하는 항목이 있습니다');

      // OpenID Connect 사용 시
      // scope 목록에 "openid" 문자열을 추가하고 요청해야 함
      // 해당 문자열을 포함하지 않은 경우, ID 토큰이 재발급되지 않음
      // scopes.add("openid")

      //scope 목록을 전달하여 카카오 로그인 요청
      OAuthToken token;
      try {
        token = await UserApi.instance.loginWithNewScopes(scopes);
        Log.i('현재 사용자가 동의한 동의 항목: ${token.scopes}');
      } catch (error) {
        Log.e('추가 동의 요청 실패 $error');
        return;
      }

      // 사용자 정보 재요청
      await _saveUser();
    }
    _moveToMainView();
  }

  Future<void> _saveUser({User? inputUser}) async {
    try {
      final user = inputUser ?? await UserApi.instance.me();
      await SharedData.saveUser(
        user.kakaoAccount?.email,
        user.kakaoAccount?.profile?.nickname,
      );
      Log.i('nickname: ${await SharedData.getUserName()}');
    } catch (error) {
      Log.e('사용자 정보 요청 실패 $error');
    }
  }
}