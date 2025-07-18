@echo off
echo Setting up KNIME HTML Table Reader Extension for Windows
echo ========================================================

REM Create virtual environment
if not exist "venv" (
    echo Creating virtual environment...
    python -m venv venv
)

REM Activate virtual environment
call venv\Scripts\activate.bat

REM Upgrade pip
echo Upgrading pip...
python -m pip install --upgrade pip

REM Install requirements
echo Installing requirements...
pip install pandas beautifulsoup4 lxml chardet openpyxl

REM Try to install KNIME packages
echo Attempting to install KNIME packages...
pip install knime-extension knime-python-base 2>nul || echo Note: KNIME packages not available via pip

REM Get Python path
for /f "tokens=*" %%i in ('where python') do set PYTHON_PATH=%%i

REM Create config.yml
echo Creating config.yml...
(
echo # Auto-generated configuration for Windows
echo org.community.html.html_table_reader:
echo   src: %CD%\src
echo   python_executable: %PYTHON_PATH%
echo   debug_mode: true
) > config.yml

echo.
echo Setup complete!
echo.
echo Add this line to your knime.ini:
echo -Dknime.python.extension.config=%CD%\config.yml
echo.
echo Python executable: %PYTHON_PATH%
pause
