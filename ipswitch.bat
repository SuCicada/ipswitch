@echo off&color 1E&title IP��ַ�����л���
echo ������������������������������������������������������������
echo ��                                                        ��
echo ��         �л����绷���������뵱ǰ����λ��               ��
echo ��                                                        ��
echo ������������������������������������������������������������
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

:choice
set choice=
set /p choice=����������ѡ��1������������ѡ��2 :[1,2]?
if %choice%==2 goto school_lan
if %choice%==1 (goto lab_lan) else (echo �����������������&goto choice)


:lab_lan
set eth="��������"
set ip=10.0.0.
set netmask=255.255.255.0
set gw=10.0.0.1
set dns1=8.8.8.8
set dns2=
echo.
echo �л����������߻���
echo.
goto switch


:school_lan
set eth="��������"
set ip=10.90.6.
set netmask=255.255.255.0
set gw=10.90.6.254
set dns1=202.207.208.8
set dns2=202.99.192.68
echo.
echo �л���ѧУ��������
echo.
goto switch

:switch
set code=
set /p code= ���IP������[3-254]�� %ip%
set "ip=%ip%%code%"
echo ��������IP��ַ %ip%
netsh interface ip set address %eth% static %ip% %netmask% %gw% 1
echo ����������ѡDNS������ %dns1%
netsh interface ip set dns %eth% static %dns1% register=PRIMARY validate=no
if defined dns2 (
    echo �������ñ���DNS������ %dns2%
    netsh interface ip add dns %eth% %dns2% index=2 validate=no
)
echo.
echo ����IP��ַ�л��ɹ�����ǰIP��ַΪ%ip%
echo.
goto end


:public
echo ��������IP��ַΪ�Զ����
netsh interface ip set address %eth% dhcp
echo ������ѡDNS������Ϊ�Զ����
netsh interface ip set dns %eth% dhcp
echo   �����Զ���ȡIP�����Ժ�...
echo.
for /L %%x in (1 1 10) do set /p gu=��<nul&ping /n 2 127.1>nul
echo 100%%
echo.
echo ����IP��ַ���л��ɹ�,��ǰIP��ַΪ�Զ���ȡ
echo.
goto end

:end
@echo on
@pause
