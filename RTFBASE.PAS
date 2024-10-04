{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2024
  @website(https://www.gladir.com/CODER/RTFLIB-TP)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Unit RTFBASE;

INTERFACE

Var
 IsTextTag:Boolean;

Function StrToRTFTag(S:String):Word;

IMPLEMENTATION

Uses RTFDEF;

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

Function StrToRTFTag(S:String):Word;
Var
 I:Integer;
Begin
 S:=StrToUpper(S);
 For I:=Length(S)downto 1 do Begin
  If S[I]in['A'..'Z']Then Break;
  If S[I]in['0'..'9',' ']Then Dec(S[0]);
 End;
 StrToRTFTag:=0;
 For I:=Low(TagList) to High(TagList)do Begin
  If StrToUpper(TagList[I].Name)=StrToUpper(S)Then Begin
   StrToRTFTag:=TagList[I].Code;
   IsTextTag:=TagList[I].IsText;
   Exit;
  End;
 End;
End;

END.