{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2024
  @website(https://www.gladir.com/CODER/RTFLIB-TP)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Unit RTFEXP;

INTERFACE

Function RTF2TXT(SourceFileName,TargetFileName:String):Boolean;

IMPLEMENTATION

Uses RTFDEF,RTFBase;

Function EvalHex(hexStr:String):Integer;
Var
 HexVal,i,n:Integer;
 EvalErr:Boolean;
Begin
 evalErr:=False;
 hexVal:=0;
 For i:=1 TO Length(hexStr)do Begin
  n:=Pos(Upcase(hexStr[i]),'0123456789ABCDEF');
  If n=0 Then evalErr:=True
         Else hexVal:=hexVal*16+n-1;
 End;
 If(EvalErr)Then Begin
  hexVal:=0;
 END;
 EvalHex:=hexVal;
End;

Function IntToStr(I:Integer):String;
Var
 S:String;
Begin
 Str(I,S);
 IntToStr:=S;
End;

Function RTF2TXT(SourceFileName,TargetFileName:String):Boolean;
Var
 RTFFile:File;
 TxtFile:Text;
 C,C1,C2:Char;
 ReadOfs,CurrTag:Word;
 BeginSlash:Boolean;
 SlashParam,CurrentWord:String;
Begin
 If SourceFileName<>''Then Begin
  {$I-}Assign(RTFFile,SourceFileName);
  Reset(RTFFile,1);{$I+}
  If IOResult<>0 Then Begin
   RTF2TXT:=False;
   Exit;
  End;
  {$I-}Assign(TxtFile,TargetFileName);
  Rewrite(TxtFile);{$I+}
  If IOResult=0 Then Begin
   CurrentWord:='';
   SlashParam:='';
   BeginSlash:=False;
   IsTextTag:=True;
   While Not EOF(RTFFile) do BEgin
    BlockRead(RTFFile,C,SizeOf(C),ReadOfs);
    Case C of
     #0:;
     #10,#13:;
     '{':Begin
     End;
     '\':Begin
      BlockRead(RTFFile,C1,SizeOf(C),ReadOfs);
      Case C1 of
       '''':Begin
        BlockRead(RTFFile,C1,SizeOf(C),ReadOfs);
        BlockRead(RTFFile,C2,SizeOf(C),ReadOfs);
        CurrentWord:=CurrentWord+Chr(Byte(EvalHex(C1+C2)));
        BeginSlash:=False;
       End;
       '*':Begin
        BeginSlash:=False;
       End;
       '~':Begin
        If CurrentWord<>''Then Begin
         WriteLn(CurrentWord);
         CurrentWord:='';
        End;
        WriteLn;
        BeginSlash:=False;
       End;
       Else Begin
        SlashParam:=C1;
        While Not EOF(RTFFile)do Begin
         BlockRead(RTFFile,C1,SizeOf(C),ReadOfs);
         If Not(C1 in['A'..'Z','a'..'z','0'..'9','\'])Then Break;
         If C1='\'Then SlashParam:=''
                  Else SlashParam:=SlashParam+C1;
        End;
        CurrTag:=StrToRTFTag(SlashParam);
        Case CurrTag of
         RTF_BULLET:Write(TxtFile,'ú');
         RTF_EMDASH:Write(TxtFile,'-');
         RTF_ENDASH:Write(TxtFile,'-');
         RTF_LDBLQUOTE:Write(TxtFile,'®');
         RTF_RDBLQUOTE:Write(TxtFile,'¯');
         RTF_PAR:Begin
          If CurrentWord<>''Then Begin
           WriteLn(TxtFile,CurrentWord);
           CurrentWord:='';
          End;
          WriteLn;
         End;
         RTF_RQUOTE:Write(TxtFile,'''');
         RTF_TAB:Write(TxtFile,#9);
        End;
        If(IsTextTag)Then Begin
         BeginSlash:=False;
        End
         Else
        BeginSlash:=True;
       End;
      End;
     End;
     '}':Begin
     SlashParam:='';
      BeginSlash:=False;
     End;
     ' ':Begin
      If(BeginSlash)Then Begin
       SlashParam:=SlashParam+' ';
       BeginSlash:=False;
      End
       Else
      Begin
       Write(CurrentWord,' ');
       CurrentWord:='';
      End;
     End;
     Else Begin
      If(BeginSlash)Then SlashParam:=SlashParam+C
                    Else CurrentWord:=CurrentWord+C;
     End;
    End;
   End;
   Write(TxtFile,CurrentWord,' ');
   Close(TxtFile);
   Close(RTFFile);
   RTF2TXT:=True;
  End
   Else
  Begin
   RTF2TXT:=False;
  End;
 End;
End;

END.


END.