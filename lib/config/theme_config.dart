
import 'package:flutter/material.dart';

/// 全局配置对象，主要是保存全局的字体颜色等配置
class ThemeConfig {

  static const double hd = 1; // 基本单位

  ///*******************色彩*********************

  /// 品牌色相关
  ///
  /// 品牌色
  /// default value is Color(0xFF0984F9)
  Color? brandPrimary;

  /// 主题色按下效果
  /// default value is Color(0x190984F9)
  Color? brandPrimaryTap;

  /// 成功色
  /// default value is Color(0xFF00AE66)
  Color? brandSuccess;

  /// 警告色
  /// default value is Color(0xFFFAAD14)
  Color? brandWarning;

  /// 失败色
  /// default value is Color(0xFFFA3F3F)
  Color? brandError;

  /// 重要-多用于红点色
  /// default value is Color(0xFFFA3F3F)
  Color? brandImportant;

  /// 重要数值色
  /// default value is Color(0xFFFF5722)
  Color? brandImportantValue;

  /// 辅助色
  /// default value is Color(0xFF44C2FF)
  Color? brandAuxiliary;

  /// 文本色相关
  ///
  /// 基础文字纯黑色
  /// default value is Color(0xFF222222)
  Color? colorTextBase;

  /// 基础文字重要色
  /// default value is Color(0xFF666666)
  Color? colorTextImportant;

  /// 基础文字-反色
  /// default value is Color(0xFFFFFFFF)
  Color? colorTextBaseInverse;

  /// 辅助文字色
  /// default value is Color(0xFF999999)
  Color? colorTextSecondary;

  /// 失效或不可更改文字色
  /// default value is Color(0xFF999999)
  Color? colorTextDisabled;


  /// 文本框提示暗文文字色
  /// default value is Color(0xFFCCCCCC)
  Color? colorTextHint;


  /// 跟随主题色[brandPrimary]
  Color? colorLink;

  /// 背景色相关
  ///
  /// 组件背景色
  /// default value is Color(0xFFFFFFFF)
  Color? fillBase;

  /// 页面背景色
  /// default value is Color(0xFFF8F8F8)
  Color? fillBody;

  /// 遮罩背景
  /// default value is Color(0x99000000)
  Color? fillMask;

  /// 边框色
  /// default value is Color(0xFFF0F0F0)
  Color? borderColorBase;

  /// 分割线色
  /// default value is Color(0xFFF0F0F0)
  Color? dividerColorBase;

  /// 文本字号
  ///
  /// 特殊数据展示，DIN Condensed数字字体，用于强吸引
  /// default value is 28
  double? fontSizeDIN;

  /// 标题字体
  /// 名称/页面大标题
  /// default value is 22
  double? fontSizeHeadLg;

  /// 标题字体
  /// 内容模块标题/一级标题
  /// default value is 18
  double? fontSizeHead;

  /// 子标题字体
  /// 标题/录入文字/大按钮文字/二级标题
  /// default value is  16
  double? fontSizeSubHead;

  /// 基础字体
  /// 内容副文本/普通说明文字
  /// default value is 14
  double? fontSizeBase;

  /// 辅助字体-普通
  /// default value is 12
  double? fontSizeCaption;

  ///辅助字体-小
  /// default value is 11
  double? fontSizeCaptionSm;

  /// 圆角尺寸
  /// default value is 2.0
  double? radiusXs;

  /// default value is 4.0
  double? radiusSm;

  /// default value is 6.0
  double? radiusMd;

  /// default value is 8.0
  double? radiusLg;

  /// 边框尺寸
  ///
  /// default 0.5
  double? borderWidthSm;

  /// default 1
  double? borderWidthMd;

  /// default 2
  double? borderWidthLg;

  /// 水平间距
  ///
  /// default 8
  double? hSpacingXs;

  /// default 12
  double? hSpacingSm;

  /// default 16
  double? hSpacingMd;

  /// default 20
  double? hSpacingLg;

  /// default 24
  double? hSpacingXl;

  /// default 42
  double? hSpacingXxl;

  /// 垂直间距
  ///
  /// default 4
  double? vSpacingXs;

  /// default 8
  double? vSpacingSm;

  /// default 12
  double? vSpacingMd;

  /// default 14
  double? vSpacingLg;

  /// default 16
  double? vSpacingXl;

  /// default 28
  double? vSpacingXxl;

  /// 图标尺寸

  /// default 8
  double? iconSizeXxs;

  /// default 12
  double? iconSizeXs;

  /// default 14
  double? iconSizeSm;

  /// default 16
  double? iconSizeMd;

  /// default 32
  double? iconSizeLg;

  ThemeConfig({
    this.brandPrimary,
    this.brandPrimaryTap,
    this.brandSuccess,
    this.brandWarning,
    this.brandError,
    this.brandImportant,
    this.brandImportantValue,
    this.brandAuxiliary,
    this.colorTextBase,
    this.colorTextImportant,
    this.colorTextBaseInverse,
    this.colorTextSecondary,
    this.colorTextDisabled,
    this.colorTextHint,
    this.colorLink,
    this.fillBase,
    this.fillBody,
    this.fillMask,
    this.borderColorBase,
    this.dividerColorBase,
    this.fontSizeDIN,
    this.fontSizeHeadLg,
    this.fontSizeBase,
    this.fontSizeHead,
    this.fontSizeSubHead,
    this.fontSizeCaption,
    this.fontSizeCaptionSm,
    this.radiusXs,
    this.radiusSm,
    this.radiusMd,
    this.radiusLg,
    this.borderWidthSm,
    this.borderWidthMd,
    this.borderWidthLg,
    this.hSpacingXs,
    this.hSpacingSm,
    this.hSpacingMd,
    this.hSpacingLg,
    this.hSpacingXl,
    this.hSpacingXxl,
    this.vSpacingXs,
    this.vSpacingSm,
    this.vSpacingMd,
    this.vSpacingLg,
    this.vSpacingXl,
    this.vSpacingXxl,
    this.iconSizeXxs,
    this.iconSizeXs,
    this.iconSizeSm,
    this.iconSizeMd,
    this.iconSizeLg,
  });

  /// 全局默认配置
  static ThemeConfig defaultConfig = ThemeConfig(
    /// 主题色相关
    ///
    /// 主题色
    brandPrimary: const Color(0xFFAD111D),

    /// 主题色按下效果
    brandPrimaryTap: const Color(0x19AD111D),

    /// 成功色
    brandSuccess: const Color(0xFFAD111D),

    /// 警告色
    brandWarning: const Color(0xFFFA5741),

    /// 失败色
    brandError: const Color(0xFFFA3F3F),

    /// 重要-多用于红点色
    brandImportant: const Color(0xFFFA3F3F),

    /// 重要数值色
    brandImportantValue: const Color(0xFFFF5722),

    /// 辅助色
    brandAuxiliary: const Color(0xFF44C2FF),

    /// 文本色相关
    ///
    /// 基础文字纯黑色
    colorTextBase: const Color(0xFF222222),

    /// 基础文字重要色
    colorTextImportant: const Color(0xFF666666),

    /// 基础文字-反色
    colorTextBaseInverse: const Color(0xFFFFFFFF),

    /// 辅助文字色
    colorTextSecondary: const Color(0xFF999999),

    /// 失效或不可更改文字色
    colorTextDisabled: const Color(0xFF999999),

    /// 文本框提示暗文文字色
    colorTextHint: const Color(0xFFCCCCCC),

    /// 跟随主题色[brandPrimary]
    colorLink: const Color(0xFF0984F9),

    /// 背景色相关
    ///
    /// 组件背景色
    fillBase: const Color(0xFFFFFFFF),

    /// 页面背景色
    fillBody: const Color(0xFFF5F5F5),

    /// 遮罩背景
    fillMask: const Color(0x99000000),

    /// 边框色
    borderColorBase: const Color(0xFFF0F0F0),

    /// 分割线色
    dividerColorBase: const Color(0xFFEEEEEE),

    /// 文本字号
    ///
    /// 特殊数据展示，DIN Condensed数字字体，用于强吸引
    fontSizeDIN: 28,

    /// 标题字体
    /// 名称/页面大标题
    fontSizeHeadLg: 24,

    /// 标题字体
    /// 内容模块标题/一级标题
    fontSizeHead: 18,

    /// 子标题字体
    /// 标题/录入文字/大按钮文字/二级标题
    fontSizeSubHead: 16,

    /// 基础字体
    /// 内容副文本/普通说明文字
    fontSizeBase: 14,

    /// 辅助字体-普通
    fontSizeCaption: 12,

    ///辅助字体-小
    fontSizeCaptionSm: 11,

    /// 圆角尺寸
    radiusXs: 2.0,
    radiusSm: 4.0,
    radiusMd: 6.0,
    radiusLg: 8.0,

    /// 边框尺寸
    borderWidthSm: 0.5,
    borderWidthMd: 1,
    borderWidthLg: 2,

    /// 水平间距
    hSpacingXs: 8,
    hSpacingSm: 12,
    hSpacingMd: 16,
    hSpacingLg: 20,
    hSpacingXl: 24,
    hSpacingXxl: 42,

    /// 垂直间距
    vSpacingXs: 4,
    vSpacingSm: 8,
    vSpacingMd: 12,
    vSpacingLg: 14,
    vSpacingXl: 16,
    vSpacingXxl: 28,

    /// 图标大小
    iconSizeXxs: 8,
    iconSizeXs: 12,
    iconSizeSm: 14,
    iconSizeMd: 16,
    iconSizeLg: 32,
  );
}
