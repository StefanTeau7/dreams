import 'package:flutter/material.dart';

class Styles {
  static const deepOceanBlue = Color(0xFF094D92);
  static const forestGreen = Color(0xFF0B3D0B);
  static const lavenderPurple = Color(0xFF7B68EE);
  static const mistyBlue = Color(0xFF759ABE);
  static const twilightGreen = Color(0xFF34656D);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static Color backgroundModalColor = white.withOpacity(0.1);
  static Color backgroundModalDark = white.withOpacity(0.25);

  static const _headlineFont = "Tobias";
  static const _copyFont = "Haffer";
  static const copyFontFamily = _copyFont;

  static const sidePadding = 20.0;
  static const _xxsSize = 10.0;
  static const _uiExtraSmallFontSize = 13.0;
  static const _uiSmallFontSize = 14.0;
  static const badgeSize = 15.0;
  static const _uiMediumFontSize = 16.00;
  static const _uiLargeFontSize = 18.0;
  static const _bodyMediumFontSize = 24.0;
  static const _groupHeaderLargeFontSize = 21.0;
  static const _headlineMediumFontSize = 25.0;
  static const _headlineLargeFontSize = 28.0;
  static const _headlineExtraLargeFontSize = 40.0;
  static const buttonHeight = 40.0;
  static const buttonWidth = 85.0;
  static const smallButtonSize = 32.0;
  static const smallIconSize = 24.0;
  static const mediumIconSize = 34.0;
  static const bottomNavIconHeight = 24.0;
  static const modalPadding = EdgeInsets.fromLTRB(20.0, 10, 20, 10);
  static const pollPadding = EdgeInsets.all(10);
  static const itemPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 5);
  static const columnSpacing = 10.0;
  static const MIN_WIDELAYOUT_WIDTH = 1200.0;
  static const COLUMN_WIDTH = 375.0;
  static const slidableThreshold = 0.5; // at 50% slide, open the slidable
  static const waitTimeInMilliseconds = 300;
  static const pillRoundCorner = 20.0;
  static const MAX_SUBJECT_LENGTH = 50;
  static const MAX_COMMENT_LENGTH = 140;
  static const ctaCornerWithLabel = 12.0;
  static const ctaCornerWithoutLabel = 30.0;

  static const MAX_SCREEN_WIDTH = 500.0;

  static const headlineExtraLarge = TextStyle(
    fontFamily: _headlineFont,
    fontSize: _headlineExtraLargeFontSize,
    fontWeight: FontWeight.w300,
    color: white,
  );

  static const headlineLarge = TextStyle(
    fontFamily: _headlineFont,
    fontSize: _headlineLargeFontSize,
    fontWeight: FontWeight.w400,
    color: deepOceanBlue,
  );

  static const headlineMedium = TextStyle(
    fontFamily: _headlineFont,
    fontSize: _headlineMediumFontSize,
    fontWeight: FontWeight.w400,
    color: white,
  );

  static const headlineSmall = TextStyle(
    fontFamily: _headlineFont,
    fontSize: _uiLargeFontSize,
    fontWeight: FontWeight.w400,
    color: white,
  );

  static const copyMediumBold = TextStyle(
    fontFamily: _copyFont,
    fontSize: _bodyMediumFontSize,
    color: deepOceanBlue,
    fontWeight: FontWeight.w700,
  );
  static const copyFont = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiMediumFontSize,
    color: white,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );
  static const copyBold = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiLargeFontSize,
    color: white,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  static const copyItalic = TextStyle(
      fontFamily: _copyFont,
      fontSize: _uiLargeFontSize,
      color: white,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic);

  static const copyBoldItalic = TextStyle(
      fontFamily: _copyFont,
      fontSize: _uiLargeFontSize,
      color: white,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.italic);

  static const copyItalicLight = TextStyle(
      fontFamily: _copyFont,
      fontSize: _uiLargeFontSize,
      color: white,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic);

  static const uiExtraLarge = TextStyle(
    fontFamily: _copyFont,
    fontSize: _groupHeaderLargeFontSize,
    color: white,
    fontWeight: FontWeight.w400,
  );

  static const uiBoldExtraLarge = TextStyle(
    fontFamily: _copyFont,
    fontSize: _groupHeaderLargeFontSize,
    color: white,
    fontWeight: FontWeight.w700,
  );

  static const uiBoldLarge = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiLargeFontSize,
    color: white,
    fontWeight: FontWeight.w700,
  );

  static const uiSemiBoldLarge = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiLargeFontSize,
    color: white,
    fontWeight: FontWeight.w600,
  );

  static const uiBoldMedium = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiMediumFontSize,
    color: white,
    fontWeight: FontWeight.w700,
  );

  static const uiBoldSmall = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiSmallFontSize,
    color: white,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static const uiBoldExtraSmall = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiExtraSmallFontSize,
    color: white,
    fontWeight: FontWeight.w700,
  );

  static const uiSemiBoldMedium = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiMediumFontSize,
    color: white,
    fontWeight: FontWeight.w600,
  );
  static const uiSemiBoldSmall = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiSmallFontSize,
    color: white,
    fontWeight: FontWeight.w600,
  );

  static const uiSemiBoldExtraSmall = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiExtraSmallFontSize,
    color: white,
    fontWeight: FontWeight.w600,
  );
  static const uiSemiBoldXXS = TextStyle(
    fontFamily: _copyFont,
    fontSize: _xxsSize,
    color: white,
    fontWeight: FontWeight.w600,
  );

  static const uiLarge = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiLargeFontSize,
    color: white,
    fontWeight: FontWeight.w400,
  );

  static const uiMedium = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiMediumFontSize,
    color: white,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static const uiMediumItalic = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiMediumFontSize,
    color: white,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    height: 1.3,
  );

  static const uiLightMedium = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiMediumFontSize,
    color: white,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static const uiInactiveMedium = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiMediumFontSize,
    color: white,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static const uiSmall = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiSmallFontSize,
    color: white,
    fontWeight: FontWeight.w400,
    height: 1.2,
  );

  static const uiLightSmall = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiSmallFontSize,
    color: white,
    fontWeight: FontWeight.w400,
    height: 1.2,
  );

  static const uiExtraSmall = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiExtraSmallFontSize,
    color: white,
    fontWeight: FontWeight.w400,
  );

  static const uiLightExtraSmall = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiExtraSmallFontSize,
    color: white,
    fontWeight: FontWeight.w400,
  );

  static const sectionHeader = TextStyle(
    fontFamily: _copyFont,
    fontSize: _uiMediumFontSize,
    color: white,
    fontWeight: FontWeight.w500,
  );

  static const getInputBoxDecoration = BoxDecoration(
    color: Styles.white,
    borderRadius: BorderRadius.all(Radius.circular(Styles.pillRoundCorner)),
  );

  static customTextStyle({Color? color, double? size, FontWeight? fontWeight, FontStyle? fontStyle, double? height}) {
    return TextStyle(
        color: color,
        height: height,
        fontSize: size,
        fontWeight: fontWeight,
        fontFamily: _copyFont,
        fontStyle: fontStyle);
  }

  static const List<BoxShadow> cardDefaultShadow = [
    BoxShadow(
      color: Color(0x30745B47),
      offset: Offset(0, 6),
      blurRadius: 20.0,
    )
  ];

  static const List<BoxShadow> cardInactiveShadow = [
    BoxShadow(
      color: Color(0x28745B47),
      offset: Offset(0, 0),
      blurRadius: 3.0,
    )
  ];

  static InputDecoration getInputDecoration(
    String label, {
    Color? color = Styles.white,
    TextStyle? hintStyle,
  }) {
    return InputDecoration(
      hintText: label,
      fillColor: color,
      filled: true,
      isCollapsed: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      hintStyle: hintStyle ?? Styles.uiMedium.copyWith(color: Styles.white),
      border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          )),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(Styles.pillRoundCorner),
        ),
      ),
    );
  }

  static InputDecoration getChatDecoration(
    String label, {
    Color? color = Styles.white,
    TextStyle? hintStyle,
  }) {
    return InputDecoration(
      hintText: label,
      fillColor: color,
      filled: false,
      isCollapsed: true,
      contentPadding: const EdgeInsets.all(10),
      hintStyle: hintStyle ?? Styles.uiMedium.copyWith(color: Styles.white),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Styles.white, width: 1.0),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Styles.deepOceanBlue, width: 1.0),
        borderRadius: BorderRadius.all(
          Radius.circular(Styles.pillRoundCorner),
        ),
      ),
    );
  }

  static InputDecoration getTitleDecoration(
    String label, {
    Color? color = Styles.white,
    TextStyle? hintStyle,
  }) {
    return InputDecoration(
      hintText: label,
      fillColor: color,
      filled: false,
      isCollapsed: true,
      contentPadding: const EdgeInsets.all(10),
      hintStyle: hintStyle ?? Styles.uiLarge.copyWith(color: Styles.white),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Styles.white, width: 1.0),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Styles.deepOceanBlue, width: 1.0),
        borderRadius: BorderRadius.all(
          Radius.circular(Styles.pillRoundCorner),
        ),
      ),
    );
  }

  static const roundedBottomBorderRadius =
      BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8));

  static const roundedBottomBorderRadius15 =
      BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15));

  static const roundedBottomBorderRadius20 =
      BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20));

  static BoxShadow shadowSofty = BoxShadow(
    color: Styles.white.withOpacity(0.18),
    spreadRadius: 0,
    blurRadius: 29,
    offset: const Offset(0, 6), // changes position of shadow
  );
}
