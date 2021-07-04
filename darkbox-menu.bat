@echo off
rem call :install_darkbox
if defined __ goto :menu
set __=.
call %0 %* | darkbox
set __=
exit
goto :eof

:menu
setlocal enabledelayedexpansion

set App.Width=110
set App.Height=24
set App.Background=0
set App.Foreground=f

color !App.Background!!App.Foreground!
mode !App.Width!,!App.Height!

call :Menu.New mymenu 21
call :Menu.Add mymenu JOUER play
call :Menu.Add mymenu OPTIONS options
call :Menu.Add mymenu CREDIT credit
call :Menu.Add mymenu QUITTER quit


call :Menu.Display mymenu 0x!App.Foreground!!App.Background! 0x7c


echo;-q
exit

:mymenu.play
echo;-dn "JOUER"
pause
exit /b
:mymenu.options
echo;-dn "OPTIONS"
pause
exit /b
:mymenu.credit
echo;-dn "CREDIT"
pause
exit /b
:mymenu.quit
echo;-q
exit
exit /b



:Menu.Title
  set tmpx=13
  echo;-g !App.Width!/2-!tmpx! 2 -c 0x!App.Background!!App.Foreground!
  echo;-g !App.Width!/2-!tmpx! 2 -d " _      _____ _      _    "
  echo;-g !App.Width!/2-!tmpx! 3 -d "/ \\__/|/  __// \\  /|/ \\ /\\"
  echo;-g !App.Width!/2-!tmpx! 4 -d "| |\\/|||  \\  | |\\ ||| | ||"
  echo;-g !App.Width!/2-!tmpx! 5 -d "| |  |||  /_ | | \\||| \\_/|"
  echo;-g !App.Width!/2-!tmpx! 6 -d "\\_/  \\|\\____\\\\_/  \\|\\____/"
exit /b

:Menu.New <basekey> <width>
  set %~1.Length=0
  set %~1.Width=%~2
exit /b

:Menu.Add <basekey> <text> <callback>
  set /a %~1.Length+=1
  for %%l in ("!%~1.Length!") do (
    set %~1.Item[%%~l].RawText=%~2
    set %~1.Item[%%~l].Text=
    set %~1.Item[%%~l].Callback=%~3
    call :String.Length len %~1.Item[%%~l].RawText
    set /a s=!%~1.Width!/2-!len!/2
    set /a tests=!len!%%2
    set "ss2="
    set ss=
    for /l %%i in (1,1,!s!) do set "ss=!ss! "
    if !s! gtr 0 if "!tests!"=="0" set "ss2= "
    set %~1.Item[%%~l].Text=!ss!!%~1.Item[%%~l].RawText!!ss!!ss2!
    set %~1.Item[%%~l].SText=!ss!
    set %~1.Item[%%~l].TextS=!ss!!ss2!
  )
exit /b

:Menu.Display <basekey> <color> <hovercolor>

  set /a startX=!App.Width!/2-!%~1.Width!/2-1
  set /a endX=!startX!+!%~1.Width!
  set /a startY=!App.Height!/2-!%~1.Length!/2-1
  
  set hover=0
  set click=0
  
  call :Menu.Title
  
  for /f "tokens=1,2,* delims= " %%a in ('darkbox.exe -m_') do (
    if not "%%~a"=="-1" (
      set click=%%~c
      if %%a geq !startX! if %%a leq !endX! (
        for /l %%i in (1,1,!%~1.Length!) do (
          set /a currentY=!startY!+%%i
          if %%b equ !currentY! (
            set hover=%%i
          )
        )
      )
    )
  )

  for /l %%i in (1,1,!%~1.Length!) do (
    if %%i equ !hover! (
      echo;-c %~3 -g !App.Width!/2-!%~1.Width!/2-2 !App.Height!/2-!%~1.Length!/2+%%i-1 -3a 178 177 176 -d "!%~1.Item[%%i].SText:~2![ !%~1.Item[%%i].RawText! ]!%~1.Item[%%i].TextS:~2!" -3a 176 177 178 -g 0 0
    ) else (
      echo;-c %~2 -g !App.Width!/2-!%~1.Width!/2-2 !App.Height!/2-!%~1.Length!/2+%%i-1 -3a 178 177 176 -d "!%~1.Item[%%i].Text!" -3a 176 177 178 -g 0 0
    )
  )
  
  echo;-c 0x!App.Background!!App.Foreground!
  
  if !hover! gtr 0 if "!click!"=="1" (
    echo;-s -g 0 0
    for %%k in ("!hover!") do call :%~1.!%~1.Item[%%~k].Callback!
    echo;-s
  )
  
  goto :Menu.Display
exit /b


:String.Length <resultVar> <stringVar>
  (set^ tmp=!%~2!)
  if defined tmp (
    set "%~1=1"
    for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
      if "!tmp:~%%P,1!" NEQ "" ( 
        set /a "%~1+=%%P"
        set "tmp=!tmp:~%%P!"
      )
    )
  ) else (
    set %~1=0
  )
exit /b




pause>nul&exit
:install_darkbox
for %%b in ( 
4D5343460000000047260000000000002C000000000000000301010001000000
00000000480000000100010000620000000000000000D552D01D20006461726B
626F782E657865003202B58CF7250062434BAC3B0B74544596AF433769A04335
10202A4AFC13F93BE080FC02D26B509AEDA8308E8280827F102138B86759E1F4
CB48FB68830A1AD7CC880EEE3A33CC022EAB1D054C4674220B7BD0453720D120
D93DEFD9C169356AF7D0A1F7DE5B55EFD70DA37B967392D4BBFFBA5575EBDEFB
1EE1DB36293D1445F1C24F2EA7280985FFAB54FEFABF75F0D377E89B7D95DDBD
0E5D9CF0CC3E74F12DF7DEB7AA7CC5CA87EE59B97859F95D8B972F7FA8A6FCCE
A5E52B572F2FBF6F79F9CCBFBDB97CD9434B968E2A29E97D9990110929CA6C4F
91436EBBC27AF4F1F454949B5001876D9B0FBF82F0B3425887E3226EB7A2587F
954D1C3EFC2585E6458441FB5FF30F277F046CF80173FDB1FFDA41EE18CFD9F1
A36A96AEA9411F4684413771BBEDFFCA1565D1A8258B6B16C3F8C17E62EEE88F
5B9C74E08DA6FFAB9D7363FFBDBE730C3A420BF9A3690F7BF209709B160A449B
BC9A9FEDF344D323997A9EE2828D66AA0F60C6021BF174E33B9880F18C0D146D
2E02F288FE655851A2FBBDB150560B65A3E9076897B1CD4DD1B422048D210D80
5B968FEB0DBF12B898063E268ACC11FA37164A6BA17444BFB8845410B7710950
EBBDC06AA32CCF9A687A2157B1C5ADC2630A463C20255D3CDC591D0FA7E0A7AB
3A42C0883E7700EA2BD5429D112D94829FAE88E653565402CA4FB30D72539E2B
FA7F31A01D9477C08F0E0678C88023FD8501EDA0BC037E74D380C767DB0C1854
C800563B1070FADDB3490DAB2D964A933E124F86A14DBA3A585A47D2E8D73B1E
1409DBA588C52DC3FFE0118AFC8D08AC6E44DA6ACD5FAD17933D81881EED675B
A4B548EF4B3D52A9449BCA2389BE647AC78D48E1278A58E8B8163ABE3E8D879B
4557224F1FDA26C763CD95804C9ED0F7DE8864ADD1748ED596A12597906FFEE5
469B9E816417D0CC676A3F458C2F117EC7E394984F4C8F72264047F4657C9C7C
C666E00032F03A6EA0312397CB1977A0889FE31AA1571F60755793EF1E60F127
CEE472D1F434A6766671B01454E770702F53EFEAC6C17D4CFD1850C605C4B18C
A9F308FC0BA6BE4CAC8F32F55D80E853605FC74387233A060A308956E65218AF
EFF4A38FDA1BF10FEC8CC3D5117DDF0DE4681D032A18997C8F7B60004E721099
BFED06CB33EFBF43A73F80A73FB1675D2578329BC0A00E9B291BD1DFE9434260
CCF6F9A31908033BF821A54788005B15FB0212CFE537F0E52B278F5E2994F536
658EE478737B71FB221E31E287399AEECDD4A1A42B8D2BABA2FDFA87B3081FD1
3F98C5D7E62381AEED2B0545F48F66D9163EC3CDA5CD92C5FD0A47200CD6F7BB
2916EAD25F9B65F91317815B19072BC9D29B091DB01D4C94A985BB621EEE826A
7D8D4DC2DDA4CB0FF263A6C7007C83E9B16A7D968D9CF6DE2536FF5546128357
E1029DACB20E80F153FB0C92FFECE698401CBBEC1C665C148BFB202D2EF72D06
5F2D1C98D8C2A25F159B87494AFF1CCCE7FE97C6FFA99896808C1F414ABC4657
4F211FF4FA0914D12B052E568CEB00873592D8F3F768D9FA5E7C07596788C373
D7F333746BB174BB9EBD9ECB08159B6B59CDE5AF6FCFD1E3A600A7B8B4D8B460
34A7D04A26AFAF543CCDB17097400C92884A42546374D62FE9CDB57E6E4DE1CB
62712FA504A08D0328A4EBF304C32E8B616FB15C43199A23FA27BDB9614F0099
5E0A4E35D6590C1B85061F9A28606B240CAD336E46B68F916D564F73EE25C21D
D7F4B41F31BD2F070B396384B1FA08E11ABFA5B754CEAC53007A48802E005FF7
14800E01382101ED709F68E1CE8A9688FECADF081844E24E2DDC31B185CFBBC1
7D75E5301CDA2EE556B897B4B08E32164B1947E08ED2C2ED3F58C66188F45AF8
88A47FD146CFE491077C458BD1835F0B8D981A3CFF7D26163AA891C361169E16
BE0BB4B9BAE703089143FCF608551B12319F4F8ED50E2049DC4C564BBA6E23D0
C158A845683C5ED1A2855B2636B32707711419814A514CAB07869D5AA8854C67
7193E6B887D380F0C338D48D9FE1846FF69A8BB6D0273CB55F00E6484093004C
91803D023042021202708104ECD642FB63A19DF05B0BEF012F847782C5F1F7AC
5B74271DFC9DC9362DD4140B6D87DF5A388184DB91B0DE22DC4E84DB9170372D
C12CCEAF85F7C304D549F4C4B5547135EA959C510B3721054F1FB9F82A2E9F2F
E3288A677CA5765A2BB59D566A654FFB4A7D721DDFE3CBD067D3F0D7F93D4CC7
5DE115937E5500064AC03601F04AC0562DB435166A1021B15EFCDDAC851AB470
3D18BBD14FF9D2AB5AB8010DA2C8023ED9A6CDADF77CA00DA48082D61DF1D9AD
9B729DD847C057EFE26B70F03538F87C76BE8A73F12D71F01D9A61F135549CCB
CE110EBE2DE7E2ABB0F37579ED7C0B669CC34E07DF1E07DFE533CEE117079FEA
E03B35DD66A7E75C76CE76F0FD9BE4DB8C1BB5EE42DA78F5B47FEB61D0DCEEA9
D4C29BF1AAD86C9C4FC8865873B429073B0286025D41E82F20FB325EC75DBA8B
52B4FB59DDED6210DF9BC1146D09ABAB20C81216F7126431533F4BE3E04EA60E
A3C4EF2EA68E0494B18C08EF61EAF48C48037F971169E004541426FCC352E2C3
2CFE35E11F64EA557FC1C172A67E40A21F82C42B63268E2B99FA3611AE62EA63
1991411E80015CDC34EDB47115B019A5F04BA4044159EDB517D169EEAB98E728
CD8307BF7122FA8E4A57C6F2A223E3D39F73E31F53305985ABB3A7B81379FE03
AA3C44D49F1EBB2289F994B97C368D5FB063792212C1428ED07712BA89D04103
B98C12A24941895A73040A8F9ADFDAECF87E1AD7363387F32E34B1957C62C203
7E5B5294D61F05EE0DA11CDB17CA45F483D3CC29D57E0EE238F4F569AE895ECD
B353519BC42FE58F8D98DE789A916783C75C00BD8C2B48FEAB09A23CC8D34215
D206A8A8433C231E6326B22251BA621439885BDC36FF3245FFF65AEE32EC9F18
432D7A3B57FD549EBADA72FCA063C68F4FB5CDF8D8D4FC19437D642BC365AAB3
21F43D20BF2753D1207D9A29E77BD755BE0216905FE5CB57615D91225D94555D
35D52A01886126779EC84CAFA16A0A4D98CF6A49CBD129A48548FCF9DE7D93A3
93BF3241B0054CDF8AF953AB27F12D4C2FA27F050C31DF4CCCC7AAE01754CD38
86FC678AE92EAFD91051D8C67EA2F981639FCCB12935676F87FC7743EE0C7F03
F0F70C678492CCCB4BB22CC4A7E1536831A412D5A5C469C21D5350A86F365D88
7212139BF3F39F7E8A93D0EA1AB0B74BE6D0251AF07CF026B11F68E4ECCD6029
E5F57609441B0ED825F0FAA70BABD0FD7EFB8989E3F11496EE9F2C9A04964706
F3958322226BA77C79B2ABD2441DE8353938E3F4C16D93C93084C15C6EC03F3B
C0F42E9459C8C10726710763DCA04B400A1A0B829CA27393303C151613B5C4B0
377C113B5B6A92F398E9ADDD76DFD0DE62AF87FC50A9E46CFA9B279913E7242E
B12FB9F0628FD93C3A0C3D0A8223FA33D83C90819957DB8188FE060F067A7DCE
0CEEA631904D0A1EA4FC15517AF5E52E4A0D09CB2D437864FC8ECEC9FBD752D1
481174836F359C635CDD0DBE25787216D14C70A37C016489A7AC4E1C01DBAE75
6D732EF211215231456A3E4BD2AB16D30A9AC63EE1910FA9835346FB18CBEB60
23960A382A15235C557DC5B5797B721E2473FA2280C7C36958E43BF229C621C5
54A2D08162663E457F4A085354CD40B5043B848A23AA93D2141546CAE6258C2F
96D10CCB893A5E4E6479395167C9DC47330A52C1C2E7C147892EF2D39C8968CF
014C6F26529869656F638D01D16D3F3C1D83A78FE9A9098468E1B436773FDB71
00AA8218A4481D500141328E7D8A522D9CD5E636112E81B876C2251057D6880B
5B0D8582FE3352D2B4BE1D5BFAB6806F3962BA6CBC42FCFEABC45663A740BF56
0BEF8E798C7D225640054667C92B36C8DC09B841765A8B1D0F6D170DCF78A81E
B6C9CE88BE0B68D81BA17A6C3FD61E07B68497E31BE06773446FFCA938C94170
D366F22E0C9EC54199167EB55A0B6F85596FD2272BBC3B11DE14F39857B04FF6
CB9098DA20BC08ACE13723187C2537D8758A6486F31371598814A4506F178BD5
986F0DDE906D086C953952D1B925587EF45A125E40E0B35202CF50B0B59BF059
34BF409A95522CA7192F58E4FAE515E3C5A6B69E38FA8955AEA14C4B8F62EA49
F895BC56B1F0D2385B0C58798D2D06844EE2C9950BDCC1E3C061A03092B44328
46B8CEE349E902E0D0E1E7D388FEDE78B1E47EDAD4B8D4D8ED8365FF548EF963
3B3E76527BA28B1A121C059BE008EC8B56D81787F5CBF8CD07557ACCC3835FE8
A4B19CF7055CA6DCAAF00BC53581C1D79073CDD38D4AA0F4D727D0FE3F68133B
98028C421BBA0373DB177057AB3DF86E3B49EA8E9D316336C552BD69BCECE6AD
4FB723AF686B672DEBB070D7EB816E7D534E2918DD93E3AC65C08C54E1334847
1C09A5950FDC3C9EE25A01492F71497119FB8F8E73C7053914CCA5E69929238B
FBC8ED5BECDA3D7C92CDED45A22FDC04F1CC1F3D118463C9739A2D9018A4AC9C
C61578BCE4EE143506A903F8DC38D914A36C414CAE33A2FF729CD83F59B3BD2E
6FE3C134EE8C36619C853D1280A0BC509277823DB4A3F0A587BC9D3ADDA1C1B9
6746F39727105C4E0C359E14536F0A469BCAF055C9008F286039AC146139C501
0B222CE9840510F65F4E981F61EF38615E84EDB0C310F06B0E3036E3DF4C3F56
773D1FAC3D1ECD0458DD79F41458FB7434D3ABE6FD68A677CDCE68A64FCD73C6
124294307531A61A99BE4C9D4903C6D42BB1433393F00345510B83F804C2F767
EA033418C0D439342865EA58E4E84F8483987A1A0F616630533F3D9397B1B81C
5AC67D08AB7846243C30DE7FB5BDE023CE36DF3A08264EC8060B52C6219B00D2
16F21F7DFFD3A39FB57FB73FC46A71FA477DF5003F3A37DBD67AD4D700C3D6B5
59E36D2CCA7C5B39838BFC55224F23F976224F1BF8661A086DC5DCB091740341
722B3A9E29F1B793B65617E40C8FCFB1FA709D54DE74263FA74E29ECECB11F7E
FF15E422139BD92FB9D69DA45547ADBB49AB2EBA1C90BD74521A9D4ABE014FF7
2B91CF465C66A5B0E57CEE09F7DCA9226DF335113C688397F1B900D004D15A70
335A2C5F1D14BE1AEF4141879DBEA2F72E6DBE562EBE90A476CB8D1DC28DC93C
379E182EDD08526CF0F7255CBA558763DFAC7BC073E832EE5448E65298CC395D
9F42D7AF2EE07AC9409D65EC9DF3A5E8E04BA15B4BA193E5ED68792759DE2EDA
1C367E60603B5A62619D9AC29D28038C4CC21ED7DD2B4401D7313DA70FC6D3DE
0FB6A1AF9C5E18CA8B95E3E174815E403631D8CCDC2157C4FEE7EB3281CD56B4
C8863A3CC828DADCEE6D4CADC2360716169A2742C7EDD4688A88E046EAD1C8F3
C99361278FD6CFF3477E21ECEB4D8E171CB5E7B989632D9471184365EB47614F
063811BEB1328AF9B80A9B5C93310F545C571D45B8213C8D73DF108FC9C80BF8
58384DC3721C66E52D8097BB512A5E433605C94959EA1566939F908782F8769B
EAAB53D4A8A11BA3F622E9C0A016F41C60FB288FA3560640C9E8E41FECA6F250
14F21F0F05DD90A57990701E64B513E24BADAE548E2FF5BBC86C1BE2B561742C
DA4C7501D357FEC6325BCA22BEF590BEEB2F3DE66F3C9FA88C2AAF8048D2316C
E3798A0B3651D43D79885142EEB5E61D88B77BB3579BEB8FFED17B9386AF69B3
FA0B23E55BE8B6605BABD07F11D7FF460F87C888FE3FC3AD3EDD9F3D16522EB0
A4DB67D1D55EA3B8843C6F43E619BDD0F602CA947E607ACC9FFCB57C8455AEC0
578E697E3496D1F983A381A7C7F2E685360116877E5B964EAB9BDAE6FBF3F8DC
FBD0F4BAE89AC74C62BE4531D45A43706917BAB45F2C681C951465040C209073
D0B3DF7CB6336D936D5FBCD5EB2AF9606D0BDCFFACEE227AEAB3F64D385F35D1
68C68F7941AF9ADF6386F04FC6FD3C6BA869800CA1E639C80E6A9E36E611AC54
7C27018338CF03824CBD9306FD98FA73992244648A707D4EB6BB218550271218
52843139912250AEF17B8F6B418C80C7F448B9CD238DFF30B6121DF87767416F
E2E8DBCF827E99A3279F05BD9BA32F3C0BDABF88D06794C2E82A8EFECC420FE1
AB7DC8825CC8216F59900B38E4B7B854DBF236CAD3088E53BC854854C1EA26D0
8B838AB53BA2E9725637889ECAD7BE1B4DF7AA8164BD77CD5BD17449CDEBC9C6
68FA72A6CEA3AF568631F54118245FC1AFC1C42B8A912CBE97BE54B98AA9FF49
83E14CDD4883113C23345611F368A67E48E03B98AAC3C0982FDAF4B47533654C
8D9F3673BC322B16F17DBDB587D97CE3ADFCC66FC409A1408D9B178246B0CD23
C243441F769AD240A3D2EB6ADB3D5690536CFB889EFA0BE7F37B4D179A5F30CD
3C17ABB03548D74C509462229A9599E29FFA8BCC4EC5C487B0DA493275AD7123
2F942F4BEC4B1990E42161EA821EF9A63EFFF50F357580692A7D19E3B0F66446
182466528D9FCC7C53C40B07FC08C638512475A3C432DBE425CC5ECE5129DCC2
9BF30E73BFF8EA879A5B66F36CBAF94411E64F0E9B4767F23C5CC0893BCCAE05
A51E200BDFD2CFB372BD14E57A29FA2026A21F4B3B1C91928AC1219D7AD02B1C
D2891D35A9F60211B471CEC91DF635AD15E944154F416BCF12DBCD755EC0951B
AB3D02303B6D953833BCD647953F6CDBF415E2AEF0B84EC6D294B508364EBE22
477DE9D56659915D4D65051E360A53C63159332E1383F80378E161DDC8837C80
C53F22889FA9AFE0ED96E905219D20BD99FA260DFA307517BE05BD87423A1494
BFE91605E53F768B82F2A96E71512CC6AFE6A68A4B40E818C4E20F778B6BE3DE
6E716D2CEC1695257D598757471875F490D7C634020F111FDC652E62EA668C1C
99A14C7D170606F65DC0038E77171ED995900E2F67B50BADFCC59FC0CB053F6F
38DF0EDC2480B62F5D9D98DA12EB7B962C26C5595AAF3BBEA3F5C282208BDFE6
8AED0398C33C0060E63B56C2F64858571CBB1B15B4B2DA9762657903C5DFF81E
5D5056272768BE06189813FCCEE9DD65B717EF2FB4778E0DC893AB88BEF35B79
52E86401E49D339645A948E22AB22873CA7DE0D3903D6DB43C6D59747B618BB6
D82D7A59F876B41DB8BBD02A542DB2AD42758109FCB9CB3D8163852630A1D004
8CDB72F6DD62CDA1A2F01CD6FDB84D53C8DCCA3C73F7163237D659C8DC877279
9B9B444C2D60EE050C3F93E29BECDFBFB1947611242039D2B4EDB8D25297D2C6
4F68DB257F67E93CEC71777378E1AC3C62360FBC8FF0E641A8C4D632BB3F20E3
5B9B620C2FB12E9C368F31C422E41752896202F26F23C3EB93DCA2025672878D
5653BEBC8AE873D12A3E4DAB8EC24A1EE8F165FC2B855852F240D97B6F6D1845
F5EC1997ACB6906E179CE28283C6EC42823BF43D670A086E05C1BF7122FC8438
0C8827F2351EB63FB4DAD57770F565C6A13E05D41FD4A71452DF045A2E2BA43E
01883E4E4480103B01F175779E5D3BED0F09FB4393DDC883DCC87263582123B7
EBF5DD058CDC0A2A1FEB2E60643D20EEEE2E60E42640849D8820213600625CBE
F51BEC0F9BEC0FF5F687ADF6A96CE75319662CE85D602AAA7E289B3F952D6B60
738109BBB2F9B3D9B282E3B664F327B4E55E8E7B349B3FA72D8B386E8113574A
B85B396E7AD63DE55AC4D89F17B99EEF753DAF703DAF713C6B2195BB638C31A7
57BE3B6A6F016AFDADD3053C52C52D7CF174018F54725CF474018F4CE0B87B4E
17F0C8188EBBF174018F0CE3B8D14E5C19E1CA396EC0E93C6F95BB663FCCF53C
C6F53CC1F55CE97AAE727A8FFCC31D38C128F16340F56340DD32842C3AEA0B60
4CDD8B4F067EFD6CCCA562CECBEA468B41BC377DB806C1F3047D78E661EA291A
14317530CE27DD83A9E8ACE4B668DAC7D47544DE93A933E83F301433B50A4E7B
F2F11F11872FEA5960A1CB7022FC374DC76B4C2D7692C95E5130565B8A644591
583C88DBA321E38ED5B5419213D13825090C18A77ABA05FAA5C08014E8478137
660AEC3745AC7F266F8D15D79AF8A5F280A9BCD45891A73C2095E3FD40CAD330
D0FF235D4079EA0C297F2D5D60B3EB1CF76C3ACF30C4D89F53679C86A23E3294
2C204387187FF2B90D0D4A433BA4A1EDFFDBCED10647555D6F84D8B08326D3C6
3155A6BE62221F4D4808E850D421145661646181ACD02A8697DDB7EC33BBFBD6
B72F5F0A051A50B70B0EADCE943ADAC14A47DAEA4CECE034456AA1609B4EA986
211DC24CD0C589D35D89D35802ACB0137AEEB9E7EDBEBC6C4644DB5F6672F6BC
73CFFD38F7DCF7CEFD3AF772412BF209DA278499944FD01EC1FBF8629EAFB25B
F08E5F1C53896E5B257A6C749FAD5209B35203D94A95A7FE33D15EA952B35247
CD4A1DE295725FCC53A92E21DCDC8B792AD5297865F92AB54FF03217F2989A3D
8297B830A6C27B6C15DC67A33B6D74974D01874C051CCD2AA032F5C904BB02CA
4C05BC602A603757C08A0B7914B04B083BE7421E053C2D78375FC8A3802D8277
F97C1E05B409DEFBE7F3D8DA88E01D393F4639115BE5DB6CF4161BFDB48DDE65
53D66E53592F6495353775F43ABBB2A698CA0A9ACA0A70654D3D9F4759EB85F0
D79FCFA3ACB582F7D1701E65B905EF9DE13CCA5A42DFFF701E65D5D1F73F9CA7
639A27788F0F8F51E43C9B62EA6CF4121BEDB6D16B6DF47A9B6203A6628359C5
DE936A2AE03D5409F6507347440F558A3D14A752CB0AF2F650E1CBD443FDF553
EAA13EFC947AA8AA4BD443BD7429DB43959A3DD464B387AAC11EEA546119165C
43054FC18239953AC17BA777CC65EF47E961E79E7362D94288020F3B9FC11010
A5051F4094F5E768B1237A8E163B1E8587B33FC5558E8673626D64DB83E768A5
C375CEDC3A8787944ABBE1B905F237D2B4EEF16A9A16C85F4ED34AC7F3695AE9
F809F7F09E758556393AD2B440FE789A563A1EE3FC1BAF8C5964E593BB025A85
BA9CEDA1B33E4FC95CA72D611D4FB2CF33BD327D074DEF12B1A7217619772EE3
F1266537F386CF0E64B71EC40A5BD1CAA4DB3A7FCA31E205D8E445B975BCF4D9
3F902BDEB6B9E6447537AE2B4EC409170604DE3373B3FA0815C1D48B2F669166
2A493331673F3A09896D9B129CDCF6B993FF18C03CF0F9C810CD7B7BE3CE4447
FA96E26DCBB0EC5E7772F9FB545429CA5481E1A571577FDCD337E3387AA4919E
1D82451209EDF1772B35D3CCEB8191517999094C67935EAB9B1539D64CB679EF
40E56F4355969807B021A3A9E4739FD4864851435C5110B04B288AA6E3124EC7
07F9F7518ED3F1418C79DA3934CA15A8B205BD38A1E8E97874606289E9912566
ED1505B9597BCE2A745561E493C5C261FD58416E36BFB26B36F2DE2C160EEF9D
059FEFDD435FD4AEBB318FD662EBA162710C12577D67B3BCC720F175CB98EF61
D702CCA4566472B6B76B11D2538B73474D47655AF3D999BA262FC4C5EF3785AB
D9D97FA68EF344C74C8313320D8EE30A199C5AD3E0A447C8E0E09E0B3738BF1A
2183737A840C4E2F37619BC5EE5CF1B6BF8C90CDC1E5216E73F68F90CDF92D8F
387653EEB911B239F111B2393F1A219BD33E423687F7BBB94DB9C611B239DF37
FD76DC36BF1DCBCBF8B6E93E6DDE3FF0B0698F5CDC8300FD0C4057A5316732E6
1A8CC32F1E3FC40F7208BFB7613C1CD8875BB4CF8BB37F71570F28FF49B1F9DE
1BF7F4C0E7C6DD29BA639E5E6AA3A3A905222EA62BCE79A4F60BCF0B28A4E700
1DF1E3F4D118E462CF2BEE144E6B5450CC99A0DC07D0BD3411F70CC4D0DFAF84
4EDEF79164F7E6EC55B7299099D9946C662042BEACFE2ECEB017FFF150CCD915
7776750CDD16731E8C3B0F625536617290B28FBBAD7C8354E0EAE7E7290AB307
45842DEEC688BDDF71F5DFEAEC0335C65CBDA9A22F221ABFE5021DEFE3AE837C
E9FA1056F9E08904081073F1238071CFAB273E9AD483EDD78F2CA16B609D48E2
91C81E4AD01B73EDC304FB440254BF48D0CB63798E411DA9257AF08865FFC533
316767CCB33FEEDC2F14FDD41D28315174A0B3531CC67C32E73526F6DFBBE9F4
573726E834B5B23FE6EAB42B6289A964D05DE7AD10057547D510B2EF0559E39E
BD42F604552B994769BC606EA18EA2E148C73D19AB2356CEA48CF745A067009D
3ACA740C5D311D39D1B508FB86B867F89BC7CDA483E3464F66A30FF2E83C77F3
43E51E492BDDB84336BCD29D5C8D0B3F204122E619303B915B72DB16896C4E03
3CA744CC35C08F007B06FE0F35B38891A7423BF1860C5B75B6E1CA4CE9355464
9435E3A2F35C8B8463E82C91EB984333F678D79BA55B9A7EB2D508A6D10FA984
EFD0EF284765947424257EBB806B387618D474222DFC910EA76FE3AE5073280E
AFCBB4ACFFD18924BA17C43D25338E4341273EE0EF651A7BAA129E41E6EA04B8
3DAF00C9DCB8EE9ACA4F5E53F9E96CF9098BF7729EF2B18C84B5FCB4F82E3324
5B82D6FC3DF63D1B4BF9E2484759D6236E2539E509BFB41963C2C5D0A870090C
10FA9D43E64069CC41BC2FA510F7FFA390B5E31782938853CE22DCABA102B667
CFE5633F4A4E2A99C3C99BC52D0E1DC91F7624CBC43BC04F4B6D665BBBF93D52
38CA4E73EF941DA5E64D0007F03A80763C7C61DE05025590C49C813ED1F42A7E
EB89F0B0C233B4A92566DC54F18EDADC579DE62E97C331D7107F7986E0C5146F
0E0D30C05AA047576E1C79604C4D0BD7F391B0E9BC5A689E8F8C59DDB46EC421
B38F8F939522BC95E01477BDE38EE8A7B8EB5D7643341DF364463978558C1295
6A97314D1889783D3553F6952D23EF3E74FB34DBE0D69CB6ECEDF106B547BA14
B4FF35C6B6264726F056B9533400B4FFD63357AE14B3AD7FE39752596CF2E431
0DC3E7C42945340636CCB7E86CAF696A93D332A259B8D358EA6E33E6B1E21D96
BA0ECFE8CE2568B92C127C464B9C2E0CB458DC88C76F89D3859116F485C49618
ED0429B64A8BBEB49690B22D81D328CC6FFBF49CE3EAF629E29047DE66D9443C
6894CDD828FCB871B20E9D91797F65F642D8DB3D636B088B7A817F78947A0751
BD30381900F5DE7CE92AD5DB76B5EADD32AE7A935F9E7A698E502E3AD3A43BD9
58609D7899B797744C304327E0CCB780CFFB26D0FD332FB4D6B1F80D7BF8EF4D
7B5BF981E4041ED6290CF0C387AB56F24BB4922B27880BB5F2C4EE8F5F275C9D
FBE3906DF7EF5091EEE48602EB2103716858A4C66321859805D8E0A251529DB9
6E5CA9326639195ECE7A510ECE939EAA2CF7EC0C964F5C194B6D4DF10BE3B617
5471742FFFD93438E3F0F6825822762C5E74653DBFCDE448F2226E35C4D991E4
C7E2BC0FFE368BB28FC49564F2148634894BE7F8ABF4C1BA3A761120D500619E
78B0BC68E7E272E841D86C68FC89BE9784C28BBA4A1FE1B24EEE2A425CC2B9A5
3B9D45BE9779847547447E1589963AC40384938407090F134E13CE1066AD024F
245C447832E112C2A584CB084F212C112E273C9DF041C287081F25DC4DF818E1
1EC2BD84FB08F7134E101E209C219C24CCDA487EC2458407893F44B892F030E1
1AC27309CF237C0FE13AC28B092F21BC8CB09B703DE1B5841F26BC9EB08F7080
70907084B041B88DF046C25B086F23FC34E11D8477117E8EF06EC2FB08BF4AB8
93F0FED6ABB963F2ABBFFFEDDFC4481DABF049F8EF60553E692A9B2A319FAC37
356A6D5295749F1C3524B7A61B726350911669E1A80678E90A69B5A2B7283AC4
5818355445AA577CBE76697AFDEAB0DCA4CC9D3DC3F120306B6B6A6BAA6AEE72
3856B7870DB94D894AF31D92347BBE34DDABF99419D246890A82D0DAF952B654
F5A1A6EAD03A608B78C09D63E1B64A0684CCB5840480BED342373DD4B00E82EE
B2043D14AA6E5FE770F0C2571BB26E64397254D29A8D48B32145B1460E2EC998
286AD81A03FE9AE64B0F28ED8D9AACFBAAB470B0BD520ACD975C5A735441D2C1
255E23AB866448A1A8834BBB4A319AF5B0244B612D5C156E0E4A2D72B0599154
BFC4AFF894D4A824B7C8AA1CE47A56C352D4F0A9E1590E5E2F91322A1901456A
52DAB94E24CD8F64586933789814D1956854F1CD42E1D6A846409AD630AD52D2
29A91A0A293E553682ED522B67D6F072C31A26C52B5BCDD47791D87E4D075143
BC4292D2A2840D490EFB209E0A4FBC561A171014270A84BA2F0CB763CD425A8B
12E2F13155A5D42E58969C1C8EE52BEA9DB9B689364722F082498D1A97BA6A1A
9634AD7A1AD7BB570B8544C18A5F85176896E33E102CA4E95C47206348365478
272BA16914699573E1629753928DF98E806144A2F3ABAB37A846506E9C05D954
9BAF6635955BDD18D41AAB43F07E2B7A364C64E1606E598FAAE10D92A2EB9A3E
5F5A1A86C6527D52503520B61C8CDA232CD7B2A246238A57F5AB8A8F35E13715
9272DFD75426396E9864FDFECAAA16D75FFEF6A43A754D69DCF1A7C23C2611A6
4957FEBD1066490BE8D6DD059F71F32CC5CF9F6E4B731DDBD750C76650EC6D40
775AE818D05D16FA19A00F59E86781EE067A26D13F07BAC7C2FF05F70FB6D0BF
043A61A15F01FA5C651D9B4EF4AF814E5AF8AF015D5895A35F077AC8C2FF3DD0
690B7D0068B63E47BF65A38F025D302B276F37D02F57E7E863409FB1C8F32ED0
DCC9D5E49F00BAC492DF49A0CB2C743FD092853E03F4740BFD21D03516DAFE27
374699ECD5E0075E27068640FCD432AFA2061967000498C294B608F3CB5EE60F
6A9ACE826116D43670985DC3C25E9D85233A8BA82CA2B5329E114080451FD30D
C67304088CBDBAF973FD55CC8CC28FDFC11AB56678C92B220EE6AFF03178608E
5CACA145F9F198F2C6A54BDA2CF71AB78B7B94072D61154F3076B095B1CAF65C
98BE91B14C6B7EB91F80781E804700360044005A013603C4009E057811602FC0
6B00FB01DE02E806380E7012E03D807F017C02700960C2E38C4D06B809600AC0
ED0033016603CC03A803B81FC005500FF003804680004004A00560234007C08F
017601FC0CE02580DF00BC0EF067807701FA00CE000C0264001C50FFAF3F21EA
560B7821C02300ED00BB005E01781BE003800CC044D0CD4D0077007C17C005D0
B851A4DF047807C08B00AF6DFC4A5FD7A2AF50B4C5AB1BB37C417ED1AAA105B5
5685DFB4811D25BF13B6A1A931A0F2F5ABA8A1039B87A85A23BFF8080614F049
B10D8AE10DC898A6D97C0A2921DE8D8AB0A848EC0D708ED28699A9519FBA819E
E46024C06F08F7FB83CDD10099142015CD8F88775018311A91BD3CCF062C9217
2307839A579417550CF1E0E52DCEFCBAC2A3FA455E68A09830514C182946668A
0943C5988882C68AA1B16264AA185A2A46B68AA189624C6485668A0943C598C8
978C155439EC0D454CCDF1AB06FC21440D0D206C831C893418ED11AC90570B1B
BA16F447902BEB1BBCE6430B7F50C22DAAAE85310CEA1E92D530B0B8B80D6BBD
11E33E356860A3359076017B9588D11080EE3CA8E8735893A28795E09C5A6AE6
FB1563B5E15B825C41D2B878B517D416FE5EB31FB4BE148627C05C9D652E6AD6
A39AEED6A22A1FB28C4A2758E3A4A060903248E12B70BCBA08DE15D90B922FCC
C75D6818BADAD86C28A372AC87E1E2284E505122A34471C1E07254120AC8C558
A3867DD884AB14D947614BF9F098CBB146570DC51EE85694A6E5320C40DD2AB4
178C0375AB2AB37AE1C5A202EBB5454115068AC4C7E7558A97681876C3F01CC5
FFEAEF0BFFFD17                                                  
) Do >>t.dat (Echo.For b=1 To len^("%%b"^) Step 2
ECHO WScript.StdOut.Write Chr^(Clng^("&H"^&Mid^("%%b",b,2^)^)^) : Next)
Cscript /b /e:vbs t.dat>darkbox.ex_
Del /f /q /a t.dat >nul 2>&1
Expand -r darkbox.ex_ >nul 2>&1
Del /f /q /a darkbox.ex_ >nul 2>&1
exit /b