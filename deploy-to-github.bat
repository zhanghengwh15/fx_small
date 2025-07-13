@echo off
setlocal enabledelayedexpansion

REM GitHub部署脚本 (Windows版本)
REM 使用方法: deploy-to-github.bat [仓库名] [描述]

set REPO_NAME=%1
if "%REPO_NAME%"=="" set REPO_NAME=fx-learning-template

set DESCRIPTION=%2
if "%DESCRIPTION%"=="" set DESCRIPTION=JavaFX学习模板项目 - 简单的面板和按钮界面示例

echo === GitHub 自动部署脚本 ===

REM 检查Git是否安装
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Git未安装，请先安装Git
    pause
    exit /b 1
)

REM 检查GitHub CLI是否安装
gh --version >nul 2>&1
if errorlevel 1 (
    echo ⚠️  GitHub CLI未安装，将使用传统方式
    set USE_GH_CLI=false
) else (
    echo ✅ 检测到GitHub CLI
    set USE_GH_CLI=true
)

REM 检查是否已登录GitHub
if "%USE_GH_CLI%"=="true" (
    gh auth status >nul 2>&1
    if errorlevel 1 (
        echo ⚠️  请先登录GitHub CLI: gh auth login
        echo 或者使用传统方式部署
        set USE_GH_CLI=false
    )
)

REM 初始化Git仓库
echo 1. 初始化Git仓库...
if not exist ".git" (
    git init
    echo ✅ Git仓库初始化完成
) else (
    echo ✅ Git仓库已存在
)

REM 添加文件到Git
echo 2. 添加文件到Git...
git add .
git status

REM 提交更改
echo 3. 提交更改...
git commit -m "Initial commit: JavaFX学习模板项目

- 添加JavaFX主应用程序
- 配置Maven构建
- 添加阿里云镜像源
- 创建一键启动脚本
- 添加项目文档"

echo ✅ 本地提交完成

REM 创建GitHub仓库
if "%USE_GH_CLI%"=="true" (
    echo 4. 使用GitHub CLI创建仓库...
    
    REM 检查仓库是否已存在
    gh repo view "%REPO_NAME%" >nul 2>&1
    if not errorlevel 1 (
        echo ⚠️  仓库 %REPO_NAME% 已存在
        set /p CONFIRM="是否要推送到现有仓库? (y/N): "
        if /i not "!CONFIRM!"=="y" (
            echo ❌ 操作取消
            pause
            exit /b 1
        )
    ) else (
        echo 创建新仓库: %REPO_NAME%
        gh repo create "%REPO_NAME%" --description "%DESCRIPTION%" --public --source=. --remote=origin --push
        echo ✅ GitHub仓库创建并推送完成
        pause
        exit /b 0
    )
) else (
    echo 4. 使用传统方式部署...
    echo 请手动执行以下步骤:
    echo.
    echo 步骤1: 在GitHub上创建新仓库
    echo    访问: https://github.com/new
    echo    仓库名: %REPO_NAME%
    echo    描述: %DESCRIPTION%
    echo    选择: Public
    echo    不要初始化README、.gitignore或license
    echo.
    echo 步骤2: 添加远程仓库
    echo    git remote add origin https://github.com/YOUR_USERNAME/%REPO_NAME%.git
    echo.
    echo 步骤3: 推送到GitHub
    echo    git branch -M main
    echo    git push -u origin main
    echo.
    echo 完成后，你的项目将在以下地址可见:
    echo    https://github.com/YOUR_USERNAME/%REPO_NAME%
    echo.
    echo 提示: 你也可以安装GitHub CLI来简化这个过程:
    echo    winget install GitHub.cli  # Windows
    echo    gh auth login
    echo    然后重新运行此脚本
)

REM 如果使用传统方式，提供手动步骤
if "%USE_GH_CLI%"=="false" (
    echo 5. 准备推送命令...
    echo 请将 YOUR_USERNAME 替换为你的GitHub用户名，然后执行:
    echo.
    echo git remote add origin https://github.com/YOUR_USERNAME/%REPO_NAME%.git
    echo git branch -M main
    echo git push -u origin main
    echo.
    echo 或者，你可以复制以下命令并替换YOUR_USERNAME:
    echo git remote add origin https://github.com/YOUR_USERNAME/%REPO_NAME%.git ^&^& git branch -M main ^&^& git push -u origin main
)

echo === 部署脚本执行完成 ===
pause 