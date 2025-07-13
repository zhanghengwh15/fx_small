#!/bin/bash

echo "=== JavaFX 学习模板启动脚本 ==="
echo "正在启动 JavaFX 应用程序..."

# 检查Java版本
echo "检查Java版本..."
java -version

# 编译项目
echo "编译项目..."
mvn clean compile

# 运行项目
echo "启动应用程序..."
mvn exec:java

echo "应用程序已启动！" 