{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2024
  @website(https://www.gladir.com/CODER/RTFLIB-TP)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Unit RTFSAVE;

INTERFACE

Procedure Body(Var T:Text);
Procedure CloseParagraph(Var T:Text);
Procedure Color(Var T:Text;Red,Green,Blue:Byte);
Procedure Font(Var T:Text);
Procedure Head(Var T:Text);
Procedure Info(Var T:Text);
Procedure PrintRTFBegin(Var T:Text);
Procedure PrintRTFEnd(Var T:Text);
Procedure OpenParagraph(Var T:Text);
Procedure RTF(Var T:Text);
Procedure Style(Var T:Text);
Procedure Txt(Var T:Text);

IMPLEMENTATION

Procedure PrintRTFBegin(Var T:Text);Begin
 WriteLn(T,'\par \pard\plain \s0\nowidctlpar{\*\hyphen2\hyphlead2\hyphtrail2\hyphmax0}',
           '\cf0\kerning1\dbch\af5\langfe2052\dbch\af6\afs24\alang1081\loch\f0\fs24',
           '\lang2070{\rtlch \ltrch\loch');
End;

Procedure PrintRTFEnd(Var T:Text);Begin
 WriteLn(T,' }');
End;

Procedure EndRTF(Var T:Text);Begin
 WriteLn(T,'\par }');
End;

Procedure OpenParagraph(Var T:Text);Begin
 WriteLn(T,'{\*\ftnsep\chftnsep}\pgndec\pard\plain ',
           '\s20\sb0\sa0\dbch\af8\dbch\af5\afs20\loch\f0\fs20');
End;

Procedure CloseParagraph(Var T:Text);Begin
 WriteLn(T,' }');
End;

Procedure Info(Var T:Text);Begin
 WriteLn(T,'\info{\creatim\yr0\mo0\dy0\hr0\min0}{\revtim\yr2021\',
         'mo1\dy17\hr1\min47}{\printim\yr0\mo0\dy0\hr0\min0}{\',
         'comment txt2rtf}{\vern67306242}}\deftab709');
 WriteLn('\viewscale100');
End;

Procedure Txt(Var T:Text);Begin
 WriteLn(T,'{\s20\sbasedon0\snext20\sb0\sa0\dbch\af8\dbch\af5\',
         'afs20\loch\f5\fs20 Preformatted Text;}');
End;

Procedure Body(Var T:Text);Begin
 WriteLn(T,'{\s16\sbasedon0\snext16\sl288\slmult1\sb0\sa140 Text Body;}');
End;

Procedure Head(Var T:Text);Begin
 WriteLn(T,'\s15\sbasedon0\snext16\sb240\sa120\keepn\dbch\af7\dbch',
            '\af9\afs28\loch\f4\fs28 Heading;}');
End;

Procedure Style(Var T:Text);Begin
 WriteLn(T,'{\stylesheet{\s0\snext0\nowidctlpar{\*\hyphen2\hyphlead2\',
           'hyphtrail2\hyphmax0}\cf0\dbch\af7\langfe2052\dbch\af9\afs24\',
           'alang1081\loch\f3\fs24\lang2070 Normal;}');
End;

Procedure Color(Var T:Text;Red,Green,Blue:Byte);Begin
 WriteLn(T,'{\colortbl;\red0\green0\blue128;\red',Red,
          '\green',Green,'\blue',Blue,';}');
End;

Procedure Font(Var T:Text);Begin
 WriteLn(T,'{\fonttbl{\f0\froman\fprq2\fcharset0 Free Mono;}}');
End;

Procedure RTF(Var T:Text);Begin
 WriteLn(T,'{\rtf1\ansi\deff3\adeflang1025');
End;

END.