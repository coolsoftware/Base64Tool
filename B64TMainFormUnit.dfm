object B64TMainForm: TB64TMainForm
  Left = 0
  Top = 0
  Caption = 'Base64 Tool'
  ClientHeight = 655
  ClientWidth = 761
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    761
    655)
  PixelsPerInch = 96
  TextHeight = 13
  object LinkLabel: TLabel
    Left = 296
    Top = 623
    Width = 119
    Height = 13
    Cursor = crHandPoint
    Anchors = [akLeft, akBottom]
    Caption = 'www.coolsoftware.ru'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = LinkLabelClick
  end
  object Label3: TLabel
    Left = 174
    Top = 623
    Width = 87
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Vitaly Yakovlev'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object CopyrightLabel: TLabel
    Left = 17
    Top = 623
    Width = 74
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Copyright (c)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ResultPageControl: TPageControl
    Left = 16
    Top = 336
    Width = 737
    Height = 273
    ActivePage = ResultTextTabSheet
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object ResultTextTabSheet: TTabSheet
      Caption = 'Result Data'
      ExplicitHeight = 267
      DesignSize = (
        729
        245)
      object ResultLabel: TLabel
        Left = 11
        Top = 10
        Width = 60
        Height = 13
        Caption = 'Result Data:'
      end
      object ResultMemo: TMemo
        Left = 11
        Top = 32
        Width = 701
        Height = 170
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
        Visible = False
        WordWrap = False
        ExplicitHeight = 192
      end
      object ResultSaveButton: TButton
        Left = 11
        Top = 208
        Width = 102
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Save to file...'
        TabOrder = 1
        OnClick = ResultSaveButtonClick
        ExplicitTop = 230
      end
      object ResultTextRadioButton: TRadioButton
        Left = 93
        Top = 9
        Width = 92
        Height = 17
        Caption = 'View as Text'
        TabOrder = 2
        OnClick = ResultTextRadioButtonClick
      end
      object ResultHexRadioButton: TRadioButton
        Left = 191
        Top = 9
        Width = 82
        Height = 17
        Caption = 'View as Hex'
        TabOrder = 3
        OnClick = ResultHexRadioButtonClick
      end
      object ResultBinHex: TATBinHex
        Left = 11
        Top = 32
        Width = 701
        Height = 170
        Cursor = crIBeam
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Caption = 'SourceBinHex'
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 4
        Visible = False
        FontOEM.Charset = OEM_CHARSET
        FontOEM.Color = clWindowText
        FontOEM.Height = -12
        FontOEM.Name = 'Terminal'
        FontOEM.Style = []
        FontFooter.Charset = DEFAULT_CHARSET
        FontFooter.Color = clBlack
        FontFooter.Height = -12
        FontFooter.Name = 'Arial'
        FontFooter.Style = []
        FontGutter.Charset = DEFAULT_CHARSET
        FontGutter.Color = clBlack
        FontGutter.Height = -12
        FontGutter.Name = 'Courier New'
        FontGutter.Style = []
        Mode = vbmodeHex
        ExplicitHeight = 192
      end
    end
    object ResultFileTabSheet: TTabSheet
      Caption = 'Result File'
      ImageIndex = 1
      ExplicitHeight = 267
      DesignSize = (
        729
        245)
      object Label6: TLabel
        Left = 11
        Top = 10
        Width = 57
        Height = 13
        Caption = 'Output File:'
      end
      object CompletedLabel: TLabel
        Left = 11
        Top = 88
        Width = 55
        Height = 13
        Caption = 'Completed.'
        Visible = False
      end
      object ResultFileEdit: TEdit
        Left = 11
        Top = 29
        Width = 702
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object ResultBrowseButton: TButton
        Left = 11
        Top = 56
        Width = 75
        Height = 25
        Caption = 'Browse...'
        TabOrder = 1
        OnClick = ResultBrowseButtonClick
      end
      object ResultExploreButton: TButton
        Left = 92
        Top = 56
        Width = 111
        Height = 25
        Caption = 'Explore to file'
        TabOrder = 2
        OnClick = ResultExploreButtonClick
      end
    end
  end
  object SourcePageControl: TPageControl
    Left = 16
    Top = 16
    Width = 737
    Height = 265
    ActivePage = SourceTextTabSheet
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    object SourceTextTabSheet: TTabSheet
      Caption = 'Source Data'
      DesignSize = (
        729
        237)
      object SourceLabel: TLabel
        Left = 11
        Top = 10
        Width = 63
        Height = 13
        Caption = 'Source Data:'
      end
      object SourceLoadButton: TButton
        Left = 11
        Top = 199
        Width = 104
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Load from file...'
        TabOrder = 0
        OnClick = SourceLoadButtonClick
      end
      object SourceSaveButton: TButton
        Left = 121
        Top = 199
        Width = 104
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Save to file...'
        TabOrder = 1
        OnClick = SourceSaveButtonClick
      end
      object SourceTextRadioButton: TRadioButton
        Left = 96
        Top = 9
        Width = 89
        Height = 17
        Caption = 'Edit as Text'
        TabOrder = 3
        OnClick = SourceTextRadioButtonClick
      end
      object SourceHexRadioButton: TRadioButton
        Left = 191
        Top = 9
        Width = 82
        Height = 17
        Caption = 'View as Hex'
        TabOrder = 4
        OnClick = SourceHexRadioButtonClick
      end
      object SourceMemo: TMemo
        Left = 11
        Top = 32
        Width = 701
        Height = 161
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 5
        Visible = False
        WordWrap = False
      end
      object SourceBinHex: TATBinHex
        Left = 11
        Top = 32
        Width = 701
        Height = 161
        Cursor = crIBeam
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Caption = 'SourceBinHex'
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        Visible = False
        FontOEM.Charset = OEM_CHARSET
        FontOEM.Color = clWindowText
        FontOEM.Height = -12
        FontOEM.Name = 'Terminal'
        FontOEM.Style = []
        FontFooter.Charset = DEFAULT_CHARSET
        FontFooter.Color = clBlack
        FontFooter.Height = -12
        FontFooter.Name = 'Arial'
        FontFooter.Style = []
        FontGutter.Charset = DEFAULT_CHARSET
        FontGutter.Color = clBlack
        FontGutter.Height = -12
        FontGutter.Name = 'Courier New'
        FontGutter.Style = []
        Mode = vbmodeHex
      end
    end
    object SourceFileTabSheet: TTabSheet
      Caption = 'Source File'
      ImageIndex = 1
      DesignSize = (
        729
        237)
      object Label7: TLabel
        Left = 11
        Top = 10
        Width = 56
        Height = 13
        Caption = 'Source File:'
      end
      object SourceFileEdit: TEdit
        Left = 11
        Top = 29
        Width = 708
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object SourceBrowseButton: TButton
        Left = 11
        Top = 56
        Width = 75
        Height = 25
        Caption = 'Browse...'
        TabOrder = 1
        OnClick = SourceBrowseButtonClick
      end
      object SourceExploreButton: TButton
        Left = 92
        Top = 56
        Width = 111
        Height = 25
        Caption = 'Explore to file'
        TabOrder = 2
        OnClick = SourceExploreButtonClick
      end
    end
  end
  object EncodeButton: TButton
    Left = 20
    Top = 291
    Width = 91
    Height = 29
    Caption = 'Encode'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = EncodeButtonClick
  end
  object DecodeButton: TButton
    Left = 117
    Top = 291
    Width = 92
    Height = 29
    Caption = 'Decode'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = DecodeButtonClick
  end
  object CloseButton: TButton
    Left = 658
    Top = 615
    Width = 91
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 4
    OnClick = CloseButtonClick
  end
  object SourceSaveDialog: TSaveDialog
    DefaultExt = '.txt'
    Filter = 
      'Text files (*.txt)|*.txt|Data files (*.dat)|*.dat|All files (*.*' +
      ')|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 64
    Top = 152
  end
  object SourceOpenDialog: TOpenDialog
    Filter = 
      'Text files (*.txt)|*.txt|Data files (*.dat)|*.dat|All files (*.*' +
      ')|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 64
    Top = 96
  end
  object ResultSaveDialog: TSaveDialog
    DefaultExt = '.txt'
    Filter = 
      'Text files (*.txt)|*.txt|Data files (*.dat)|*.dat|All files (*.*' +
      ')|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 41
    Top = 456
  end
  object ResultOpenDialog: TOpenDialog
    Filter = 
      'Text files (*.txt)|*.txt|Data files (*.dat)|*.dat|All files (*.*' +
      ')|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 41
    Top = 392
  end
end
