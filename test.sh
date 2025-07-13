#!/bin/bash

echo "=== JavaFX 学习模板测试脚本 ==="

# 检查Java版本
echo "1. 检查Java版本..."
java -version
if [ $? -eq 0 ]; then
    echo "✅ Java环境正常"
else
    echo "❌ Java环境异常"
    exit 1
fi

# 检查Maven版本
echo "2. 检查Maven版本..."
mvn -version
if [ $? -eq 0 ]; then
    echo "✅ Maven环境正常"
else
    echo "❌ Maven环境异常"
    exit 1
fi

# 编译项目
echo "3. 编译项目..."
mvn clean compile
if [ $? -eq 0 ]; then
    echo "✅ 项目编译成功"
else
    echo "❌ 项目编译失败"
    exit 1
fi

# 检查生成的文件
echo "4. 检查生成的文件..."
if [ -f "target/classes/com/example/fx/MainApp.class" ]; then
    echo "✅ 类文件生成成功"
else
    echo "❌ 类文件生成失败"
    exit 1
fi

echo "=== 测试完成 ==="
echo "项目配置正常，可以运行 ./start.sh 启动应用程序" 