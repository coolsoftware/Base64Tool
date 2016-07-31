{******************************************************************************

  This file is part of Base64Tool.
  Copyright (c) 2015-16 by Vitaly Yakovlev.
  http://blog.coolsoftware.ru/

  This package is free software; you can redistribute it and/or modify it
  under the terms of the GNU General Public License

  It is distributed in the hope that it will be useful,
  but without any warranty.

  Dependencies:

  TATBinHex component by Alexey-T (https://github.com/Alexey-T/ATViewer)

  Please, don't remove this copyright.

*******************************************************************************}

unit B64TMainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, ATBinHex;

type
  TB64TMainForm = class(TForm)
    ResultPageControl: TPageControl;
    ResultTextTabSheet: TTabSheet;
    ResultLabel: TLabel;
    ResultMemo: TMemo;
    ResultSaveButton: TButton;
    ResultFileTabSheet: TTabSheet;
    Label6: TLabel;
    CompletedLabel: TLabel;
    ResultFileEdit: TEdit;
    ResultBrowseButton: TButton;
    ResultExploreButton: TButton;
    SourcePageControl: TPageControl;
    SourceTextTabSheet: TTabSheet;
    SourceLabel: TLabel;
    SourceLoadButton: TButton;
    SourceSaveButton: TButton;
    SourceFileTabSheet: TTabSheet;
    Label7: TLabel;
    SourceFileEdit: TEdit;
    SourceBrowseButton: TButton;
    SourceExploreButton: TButton;
    EncodeButton: TButton;
    DecodeButton: TButton;
    CloseButton: TButton;
    SourceSaveDialog: TSaveDialog;
    SourceOpenDialog: TOpenDialog;
    ResultSaveDialog: TSaveDialog;
    ResultOpenDialog: TOpenDialog;
    SourceBinHex: TATBinHex;
    SourceTextRadioButton: TRadioButton;
    SourceHexRadioButton: TRadioButton;
    SourceMemo: TMemo;
    ResultTextRadioButton: TRadioButton;
    ResultHexRadioButton: TRadioButton;
    ResultBinHex: TATBinHex;
    LinkLabel: TLabel;
    Label3: TLabel;
    CopyrightLabel: TLabel;
    SourceMIMEFormatButton: TButton;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ResultBrowseButtonClick(Sender: TObject);
    procedure ResultExploreButtonClick(Sender: TObject);
    procedure SourceBrowseButtonClick(Sender: TObject);
    procedure SourceExploreButtonClick(Sender: TObject);
    procedure SourceLoadButtonClick(Sender: TObject);
    procedure SourceSaveButtonClick(Sender: TObject);
    procedure EncodeButtonClick(Sender: TObject);
    procedure DecodeButtonClick(Sender: TObject);
    procedure SourceTextRadioButtonClick(Sender: TObject);
    procedure SourceHexRadioButtonClick(Sender: TObject);
    procedure ResultHexRadioButtonClick(Sender: TObject);
    procedure ResultTextRadioButtonClick(Sender: TObject);
    procedure ResultSaveButtonClick(Sender: TObject);
    procedure LinkLabelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SourceMIMEFormatButtonClick(Sender: TObject);
    procedure SourceMemoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FSourceStream: TStringStream;
    FResultStream: TStringStream;
    function ConfigFileName(bLoad: Boolean): String;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure ExploreToFile(const sFileName: String);
    procedure EncodeDecode(bDecode: Boolean);
    function MIMEFormat(const sText: String): String;
  public
    { Public declarations }
  end;

var
  B64TMainForm: TB64TMainForm;

implementation

uses StrUtils, DateUtils, ShellAPI, Soap.EncdDecd, uAppFolder;

{$I Base64Tool_ver.inc}

{$R *.dfm}

const
  AppDataSubFolder = 'Base64Tool';

{ TB64TMainForm }

procedure TB64TMainForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

function TB64TMainForm.ConfigFileName(bLoad: Boolean): String;
begin
  Result := GetAppConfigFile('b64t.ini',
    GetAppDataDir(AppDataSubFolder, IfThen(bLoad, 'b64t.ini', '')));
end;

procedure TB64TMainForm.DecodeButtonClick(Sender: TObject);
begin
  EncodeDecode(True);
end;

procedure TB64TMainForm.EncodeButtonClick(Sender: TObject);
begin
  EncodeDecode(False);
end;

procedure TB64TMainForm.EncodeDecode(bDecode: Boolean);
var
  srcStream: TStream;
  dstStream: TStream;
  bSrcFile, bDstFile: Boolean;
begin
  SaveSettings;

  FResultStream.Clear;
  if ResultBinHex.Visible then ResultBinHex.Reload;
  ResultMemo.Text := '';
  CompletedLabel.Visible := False;

  srcStream := nil;
  dstStream := nil;
  try
    bSrcFile := (SourcePageControl.ActivePage = SourceFileTabSheet);
    if bSrcFile then
      srcStream := TFileStream.Create(SourceFileEdit.Text, fmOpenRead or fmShareDenyWrite)
    else begin
      if SourceMemo.Visible then
      begin
        srcStream := TStringStream.Create(SourceMemo.Text)
      end else
      begin
        srcStream := TStringStream.Create;
        FSourceStream.Position := 0;
        srcStream.CopyFrom(FSourceStream, FSourceStream.Size);
      end;
      srcStream.Position := 0;
    end;
    bDstFile := (ResultPageControl.ActivePage = ResultFileTabSheet);
    if bDstFile then
      dstStream := TFileStream.Create(ResultFileEdit.Text, fmCreate)
    else
      dstStream := TStringStream.Create;

    if bDecode then
      DecodeStream(srcStream, dstStream)
    else
      EncodeStream(srcStream, dstStream);

    if bDstFile then
      CompletedLabel.Visible := True
    else begin
      FResultStream.Clear;
      dstStream.Position := 0;
      FResultStream.CopyFrom(dstStream, dstStream.Size);
      if ResultMemo.Visible then
        ResultMemo.Text := FResultStream.DataString
      else begin
        if ResultBinHex.Visible then ResultBinHex.Reload;
      end;
    end;
  finally
    if Assigned(srcStream) then
      FreeAndNil(srcStream);
    if Assigned(dstStream) then
      FreeAndNil(dstStream);
  end;
end;

procedure TB64TMainForm.ExploreToFile(const sFileName: String);
begin
  if Length(sFileName) = 0 then Exit;
  ShellExecute(Application.Handle, 'open', 'explorer.exe',
    PChar('/select,"' + sFileName + '"'), nil, SW_NORMAL);
end;

procedure TB64TMainForm.FormCreate(Sender: TObject);
begin
  Caption := Caption + ' ' + APP_VERSION;
  //
  FSourceStream := TStringStream.Create;
  FResultStream := TStringStream.Create;
  //
  SourcePageControl.ActivePage := SourceTextTabSheet;
  ResultPageControl.ActivePage := ResultTextTabSheet;
  //
  SourceBinHex.OpenStream(FSourceStream);
  ResultBinHex.OpenStream(FResultStream);
  //
  LoadSettings;
end;

procedure TB64TMainForm.FormDestroy(Sender: TObject);
begin
  SaveSettings;
  //
  FSourceStream.Free;
  FResultStream.Free;
end;

procedure TB64TMainForm.FormShow(Sender: TObject);
const
  y0 = 2016;
var
  y: Integer;
begin
  y := YearOf(Now);
  if y > y0 then
    CopyRightLabel.Caption := Format('Copyright (c) %.4d-%.2d', [y0, y-2000])
  else
    CopyRightLabel.Caption := Format('Copyright (c) %.4d', [y]);
end;

procedure TB64TMainForm.LinkLabelClick(Sender: TObject);
begin
  ShellExecute(GetDesktopWindow(), 'open',
    PChar('http://www.coolsoftware.ru/'),
    nil, nil, SW_SHOWNORMAL);
end;

procedure TB64TMainForm.LoadSettings;
var
  sFileName, sDir: String;
  sSrcDataFileName: String;
  lst: TStringList;
begin
  sFileName := ConfigFileName(True);
  if not FileExists(sFileName) then Exit;
  sDir := ExtractFileDir(sFileName);
  if Length(sDir) > 0 then sDir := sDir + '\';
  lst := TStringList.Create;
  try
    lst.LoadFromFile(sFileName);
    SourceFileEdit.Text := lst.Values['SourceFile'];
    if lst.Values['Source'] = 'file' then
      SourcePageControl.ActivePage := SourceFileTabSheet;
    sSrcDataFileName := sDir + 'source.dat';
    if FileExists(sSrcDataFileName) then
      FSourceStream.LoadFromFile(sSrcDataFileName);
    if lst.Values['SourceMode'] = 'hex' then
      SourceHexRadioButton.Checked := True
    else
      SourceTextRadioButton.Checked := True;
    ResultFileEdit.Text := lst.Values['ResultFile'];
    if lst.Values['Result'] = 'file' then
      ResultPageControl.ActivePage := ResultFileTabSheet;
    if lst.Values['ResultMode'] = 'hex' then
      ResultHexRadioButton.Checked := True
    else
      ResultTextRadioButton.Checked := True;
  finally
    lst.Free;
  end;
end;

function TB64TMainForm.MIMEFormat(const sText: String): String;
var
  lstIn, lstOut: TStringList;
  I, K, L: Integer;
  S: String;
begin
  lstIn := TStringList.Create;
  lstOut := TStringList.Create;
  try
    lstIn.Text := sText;
    for I := 0 to lstIn.Count-1 do
    begin
      S := Trim(lstIn[I]);
      L := Length(S);
      if L = 0 then Continue;
      K := 1;
      while K+76 <= L do
      begin
        lstOut.Add(Copy(S, K, 76));
        Inc(K, 76);
      end;
      lstOut.Add(Copy(S, K, L-K+1));
    end;
    Result := lstOut.Text;
  finally
    lstOut.Free;
    lstIn.Free;
  end;
end;

procedure TB64TMainForm.ResultBrowseButtonClick(Sender: TObject);
begin
  ResultSaveDialog.FileName := ResultFileEdit.Text;
  if ResultSaveDialog.Execute then
    ResultFileEdit.Text := ResultSaveDialog.FileName;
end;

procedure TB64TMainForm.ResultExploreButtonClick(Sender: TObject);
begin
  ExploreToFile(ResultFileEdit.Text);
end;

procedure TB64TMainForm.ResultHexRadioButtonClick(Sender: TObject);
begin
  ResultMemo.Visible := False;
  if not ResultBinHex.Visible then
    ResultBinHex.Visible := True;
  ResultBinHex.Reload;
end;

procedure TB64TMainForm.ResultSaveButtonClick(Sender: TObject);
begin
  if ResultSaveDialog.Execute then
    FResultStream.SaveToFile(ResultSaveDialog.FileName);
end;

procedure TB64TMainForm.ResultTextRadioButtonClick(Sender: TObject);
begin
  ResultBinHex.Visible := False;
  if not ResultMemo.Visible then
  begin
    ResultMemo.Text := FResultStream.DataString;
    ResultMemo.Visible := True;
  end;
end;

procedure TB64TMainForm.SaveSettings;
var
  sFileName, sDir: String;
  sSrcDataFileName: String;
  lst: TStringList;
begin
  sFileName := ConfigFileName(False);
  sDir := ExtractFileDir(sFileName);
  if Length(sDir) > 0 then sDir := sDir + '\';
  lst := TStringList.Create;
  try
    lst.Values['SourceFile'] := SourceFileEdit.Text;
    lst.Values['Source'] :=
      IfThen(SourcePageControl.ActivePage = SourceFileTabSheet, 'file', 'text');
    sSrcDataFileName := sDir + 'source.dat';
    if SourceMemo.Visible then
      SourceMemo.Lines.SaveToFile(sSrcDataFileName)
    else
      FSourceStream.SaveToFile(sSrcDataFileName);
    lst.Values['SourceMode'] := IfThen(SourceHexRadioButton.Checked, 'hex', 'text');
    lst.Values['ResultFile'] := ResultFileEdit.Text;
    lst.Values['Result'] :=
      IfThen(ResultPageControl.ActivePage = ResultFileTabSheet, 'file', 'text');
    lst.Values['ResultMode'] := IfThen(ResultHexRadioButton.Checked, 'hex', 'text');
    lst.SaveToFile(sFileName);
  finally
    lst.Free;
  end;
end;

procedure TB64TMainForm.SourceBrowseButtonClick(Sender: TObject);
begin
  SourceOpenDialog.FileName := SourceFileEdit.Text;
  if SourceOpenDialog.Execute then
    SourceFileEdit.Text := SourceOpenDialog.FileName;
end;

procedure TB64TMainForm.SourceExploreButtonClick(Sender: TObject);
begin
  ExploreToFile(SourceFileEdit.Text);
end;

procedure TB64TMainForm.SourceHexRadioButtonClick(Sender: TObject);
begin
  if SourceMemo.Visible then
  begin
    FSourceStream.Clear;
    FSourceStream.WriteString(SourceMemo.Text);
    SourceMemo.Visible := False;
  end;
  SourceMIMEFormatButton.Visible := False;
  if not SourceBinHex.Visible then
    SourceBinHex.Visible := True;
  SourceBinHex.Reload;
end;

procedure TB64TMainForm.SourceLoadButtonClick(Sender: TObject);
begin
  if SourceOpenDialog.Execute then
  begin
    if SourceMemo.Visible then
      SourceMemo.Lines.LoadFromFile(SourceOpenDialog.FileName)
    else begin
      FSourceStream.LoadFromFile(SourceOpenDialog.FileName);
      if SourceBinHex.Visible then SourceBinHex.Reload;
    end;
  end;
end;

procedure TB64TMainForm.SourceMemoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = ^A then
  begin
    (Sender as TMemo).SelectAll;
    Key := #0;
  end;
end;

procedure TB64TMainForm.SourceMIMEFormatButtonClick(Sender: TObject);
begin
  SourceMemo.Text := MIMEFormat(SourceMemo.Text);
end;

procedure TB64TMainForm.SourceSaveButtonClick(Sender: TObject);
begin
  if SourceSaveDialog.Execute then
  begin
    if SourceMemo.Visible then
      SourceMemo.Lines.SaveToFile(SourceSaveDialog.FileName)
    else
      FSourceStream.SaveToFile(SourceSaveDialog.FileName);
  end;
end;

procedure TB64TMainForm.SourceTextRadioButtonClick(Sender: TObject);
begin
  SourceBinHex.Visible := False;
  if not SourceMemo.Visible then
  begin
    SourceMemo.Text := FSourceStream.DataString;
    SourceMemo.Visible := True;
  end;
  SourceMIMEFormatButton.Visible := True;
end;

end.
