#!/bin/bash

# GitHub部署脚本
# 使用方法: ./deploy-to-github.sh [仓库名] [描述]

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 默认值
REPO_NAME=${1:-"fx-learning-template"}
DESCRIPTION=${2:-"JavaFX学习模板项目 - 简单的面板和按钮界面示例"}

echo -e "${BLUE}=== GitHub 自动部署脚本 ===${NC}"

# 检查Git是否安装
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git未安装，请先安装Git${NC}"
    exit 1
fi

# 检查GitHub CLI是否安装
if ! command -v gh &> /dev/null; then
    echo -e "${YELLOW}⚠️  GitHub CLI未安装，将使用传统方式${NC}"
    USE_GH_CLI=false
else
    echo -e "${GREEN}✅ 检测到GitHub CLI${NC}"
    USE_GH_CLI=true
fi

# 检查是否已登录GitHub
if [ "$USE_GH_CLI" = true ]; then
    if ! gh auth status &> /dev/null; then
        echo -e "${YELLOW}⚠️  请先登录GitHub CLI: gh auth login${NC}"
        echo -e "${BLUE}或者使用传统方式部署${NC}"
        USE_GH_CLI=false
    fi
fi

# 初始化Git仓库
echo -e "${BLUE}1. 初始化Git仓库...${NC}"
if [ ! -d ".git" ]; then
    git init
    echo -e "${GREEN}✅ Git仓库初始化完成${NC}"
else
    echo -e "${GREEN}✅ Git仓库已存在${NC}"
fi

# 添加文件到Git
echo -e "${BLUE}2. 添加文件到Git...${NC}"
git add .
git status

# 提交更改
echo -e "${BLUE}3. 提交更改...${NC}"
git commit -m "Initial commit: JavaFX学习模板项目

- 添加JavaFX主应用程序
- 配置Maven构建
- 添加阿里云镜像源
- 创建一键启动脚本
- 添加项目文档"

echo -e "${GREEN}✅ 本地提交完成${NC}"

# 创建GitHub仓库
if [ "$USE_GH_CLI" = true ]; then
    echo -e "${BLUE}4. 使用GitHub CLI创建仓库...${NC}"
    
    # 检查仓库是否已存在
    if gh repo view "$REPO_NAME" &> /dev/null; then
        echo -e "${YELLOW}⚠️  仓库 $REPO_NAME 已存在${NC}"
        read -p "是否要推送到现有仓库? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${RED}❌ 操作取消${NC}"
            exit 1
        fi
    else
        echo -e "${BLUE}创建新仓库: $REPO_NAME${NC}"
        gh repo create "$REPO_NAME" \
            --description "$DESCRIPTION" \
            --public \
            --source=. \
            --remote=origin \
            --push
        echo -e "${GREEN}✅ GitHub仓库创建并推送完成${NC}"
        exit 0
    fi
else
    echo -e "${BLUE}4. 使用传统方式部署...${NC}"
    echo -e "${YELLOW}请手动执行以下步骤:${NC}"
    echo
    echo -e "${BLUE}步骤1: 在GitHub上创建新仓库${NC}"
    echo -e "   访问: https://github.com/new"
    echo -e "   仓库名: $REPO_NAME"
    echo -e "   描述: $DESCRIPTION"
    echo -e "   选择: Public"
    echo -e "   不要初始化README、.gitignore或license"
    echo
    echo -e "${BLUE}步骤2: 添加远程仓库${NC}"
    echo -e "   git remote add origin https://github.com/YOUR_USERNAME/$REPO_NAME.git"
    echo
    echo -e "${BLUE}步骤3: 推送到GitHub${NC}"
    echo -e "   git branch -M main"
    echo -e "   git push -u origin main"
    echo
    echo -e "${GREEN}完成后，你的项目将在以下地址可见:${NC}"
    echo -e "   https://github.com/YOUR_USERNAME/$REPO_NAME"
    echo
    echo -e "${YELLOW}提示: 你也可以安装GitHub CLI来简化这个过程:${NC}"
    echo -e "   brew install gh  # macOS"
    echo -e "   gh auth login"
    echo -e "   然后重新运行此脚本"
fi

# 如果使用传统方式，提供手动步骤
if [ "$USE_GH_CLI" = false ]; then
    echo -e "${BLUE}5. 准备推送命令...${NC}"
    echo -e "${GREEN}请将 YOUR_USERNAME 替换为你的GitHub用户名，然后执行:${NC}"
    echo
    echo -e "${YELLOW}git remote add origin https://github.com/YOUR_USERNAME/$REPO_NAME.git${NC}"
    echo -e "${YELLOW}git branch -M main${NC}"
    echo -e "${YELLOW}git push -u origin main${NC}"
    echo
    echo -e "${GREEN}或者，你可以复制以下命令并替换YOUR_USERNAME:${NC}"
    echo -e "${BLUE}git remote add origin https://github.com/YOUR_USERNAME/$REPO_NAME.git && git branch -M main && git push -u origin main${NC}"
fi

echo -e "${GREEN}=== 部署脚本执行完成 ===${NC}" 