{******************************************************************************

  This file is part of Base64Tool.
  Copyright (c) 2015-16 by Vitaly Yakovlev.
  http://blog.coolsoftware.ru/

  This package is free software; you can redistribute it and/or modify it
  under the terms of the GNU General Public License

  It is distributed in the hope that it will be useful,
  but without any warranty.

  Please, don't remove this copyright.

*******************************************************************************}

unit uAppFolder;

interface

uses Windows, SysUtils, SHFolder, Forms, StrUtils;

function GetAppDataDir(
  const SubFolder: String;
  const ConfigFiles: String = ''): String;
function GetAppConfigFile(
  const DefAppConfigFile: String;
  const AppDataDir: String): String;

implementation

var
  //0 - undefined, 1 - use app settings dir, -1 - use user app data settings dir
  AppSettingsDir: Integer = 0;
  AppConfigFile: PChar = '';
  bufAppConfigFile: array[0..MAX_PATH] of Char;

function GetAppConfigFile(const DefAppConfigFile, AppDataDir: String): String;
var
  i: Integer;
begin
  if AppSettingsDir = 0 then
  begin
    AppSettingsDir := -1;
    for i := 1 to ParamCount do
    begin
      if ParamStr(i) = '-appsettingsdir' then
        AppSettingsDir := 1
      else
      if (ParamStr(i) = '-config') and
         (i+1 <= ParamCount) then
      begin
        bufAppConfigFile[0] := #0;
        StrPLCopy(bufAppConfigFile, ParamStr(i+1), MAX_PATH);
        bufAppConfigFile[MAX_PATH] := #0;
        AppConfigFile := bufAppConfigFile;
        if AppConfigFile^ <> #0 then
          AppSettingsDir := 1;
      end;
    end;
  end;
  if AppConfigFile^ <> #0 then
    Result := AppConfigFile
  else
    Result := DefAppConfigFile;
  if (Length(AppDataDir) > 0) and
     (Pos(':', Result) = 0) then
  begin
    Result := AppDataDir + '\' + Result;
  end;
end;

function GetAppDataDir(const SubFolder: String;
  const ConfigFiles: String = ''): String;
const
  SHGFP_TYPE_CURRENT = 0;
var
  path: array [0..MAX_PATH] of char;
  t, sAppDataFolder: String;
  sSrcFile, sDstFile: String;
  sr: TSearchRec;
  i, k, l: Integer;
begin
  Result := ExtractFileDir(Application.ExeName);
  if AppSettingsDir = 0 then
  begin
    AppSettingsDir := -1;
    for i := 1 to ParamCount do
    begin
      if ParamStr(i) = '-appsettingsdir' then
        AppSettingsDir := 1
      else
      if (ParamStr(i) = '-config') and
         (i+1 <= ParamCount) then
      begin
        bufAppConfigFile[0] := #0;
        StrPLCopy(bufAppConfigFile, ParamStr(i+1), MAX_PATH);
        bufAppConfigFile[MAX_PATH] := #0;
        AppConfigFile := bufAppConfigFile;
        if AppConfigFile^ <> #0 then
          AppSettingsDir := 1;
      end;
    end;
  end;
  if AppSettingsDir = 1 then Exit;
  if SUCCEEDED(SHGetFolderPath(0,CSIDL_APPDATA,0,SHGFP_TYPE_CURRENT,@path[0])) then
  begin
    sAppDataFolder := path;
    if Length(SubFolder) > 0 then
    begin
      if SubFolder[1] = '\' then
        sAppDataFolder := sAppDataFolder + SubFolder
      else
        sAppDataFolder := sAppDataFolder + '\' + SubFolder;
      if not DirectoryExists(sAppDataFolder) then
      begin
        if not CreateDir(sAppDataFolder) then Exit;
        if Length(ConfigFiles) > 0 then
        begin
          k := 1;
          repeat
            l := PosEx(';', ConfigFiles, k);
            if l >= k then
            begin
              t := Trim(Copy(ConfigFiles, k, l-k));
              k := l+1;
            end else
            begin
              t := Trim(Copy(ConfigFiles, k, MaxInt));
              k := Length(ConfigFiles)+1;
            end;
            if Length(t) > 0 then
            begin
              if FindFirst(Result+'\'+t, 0, sr) = 0 then
              begin
                repeat
                  sSrcFile := Result+'\'+sr.Name;
                  sDstFile := sAppDataFolder+'\'+sr.Name;
                  if not FileExists(sDstFile) then
                  begin
                    CopyFile(PChar(sSrcFile), PChar(sDstFile), True);
                  end;
                until FindNext(sr) <> 0;
                FindClose(sr);
              end;
            end;
          until (k > Length(ConfigFiles));
        end;
      end;
      Result := sAppDataFolder;
    end;
  end;
end;

end.
