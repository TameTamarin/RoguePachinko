xcopy src\ bin\build\ /S /Y
rmdir bin\dist\ /s /q
mkdir bin\dist\
@echo "Creating dist..."
tar.exe -C bin\build\ -a -c -f bin\dist\ChessHustlers.zip *.*
@echo "Opening Game..."
"C:\Program Files\LOVE\love.exe" "bin\dist\ChessHustlers.zip"