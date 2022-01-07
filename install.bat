echo off
REM 声明采用UTF-8编码
chcp 65001
:unzip
echo unzip InstallTinyTexAndPackages
powershell -Command ".\join.ps1"
powershell -Command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('InstallTinyTexAndPackages.zip', '.'); }"
echo unzip NPUThesisFonts
powershell -Command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('NPUThesisFonts.zip', '.'); }"
echo unzip NPUThesisTexTemplate
powershell -Command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('NPUThesisTexTemplate.zip', '.'); }"
:run
pushd InstallTinyTexAndPackages
call install_tinytex_windows.bat
echo unzip SumatraPDF
powershell -Command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('SumatraPDF-3.3.3-64.zip', '.'); }"
echo "推荐使用Sumatra PDF浏览PDF，因为TeX编译出新的PDF后，Sumatra PDF自动刷新PDF"
echo "TinyTex已经安装完毕"
popd
pushd NPUThesisTexTemplate
echo "开始安装TeX宏包"
powershell -executionpolicy remotesigned -File install_packages.ps1
echo "TeX宏包安装完毕"
popd
pushd NPUThesisFonts
echo "开始配置字体"
call install.bat
echo "配置字体完毕"
popd
pushd NPUThesisTexTemplate
echo "开始编译样例PDF"
REM  powershell -executionpolicy remotesigned -File compile.ps1
call compile.bat
echo "样例PDF编译完毕"
echo "使用Sumatra PDF打开样例PDF"
popd
InstallTinyTexAndPackages\SumatraPDF-3.3.3-64.exe NPUThesisTexTemplate\output\document.pdf
echo "平时编译PDF，可双击compile.bat执行编译"
echo "也可打开命令行进入NPUThesisTexTemplate目录执行脚本compile.ps1或compile.bat"
pause

