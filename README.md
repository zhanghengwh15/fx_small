# JavaFX 学习模板

一个简单的JavaFX学习模板项目，包含基本的UI组件和事件处理示例。

## 项目特性

- ✅ JDK 8 兼容
- ✅ Maven 构建管理
- ✅ 阿里云镜像源配置
- ✅ 一键启动脚本
- ✅ 简单的面板和按钮界面
- ✅ 事件处理示例

## 环境要求

- JDK 8 或更高版本
- Maven 3.6 或更高版本

## 快速开始

### 方式一：使用启动脚本（推荐）

**Linux/Mac:**
```bash
chmod +x start.sh
./start.sh
```

**Windows:**
```cmd
start.bat
```

### 方式二：手动启动

```bash
# 编译项目
mvn clean compile

# 运行项目
mvn exec:java
```

### 方式三：打包后运行

```bash
# 打包项目
mvn clean package

# 运行jar包
java -jar target/fx-learning-template-1.0.0.jar
```

## 项目结构

```
fx-learning-template/
├── src/main/java/com/example/fx/
│   └── MainApp.java          # 主应用程序类
├── pom.xml                   # Maven配置文件
├── start.sh                  # Linux/Mac启动脚本
├── start.bat                 # Windows启动脚本
├── test.sh                   # 项目测试脚本
├── .gitignore                # Git忽略文件
└── README.md                 # 项目说明文档
```

## 功能说明

应用程序包含以下功能：

1. **打招呼按钮**: 显示欢迎消息
2. **计数按钮**: 统计点击次数
3. **清空按钮**: 重置计数器

## 学习要点

- JavaFX应用程序的基本结构
- 布局容器的使用（VBox、HBox）
- 控件的创建和样式设置
- 事件处理（按钮点击）
- 状态管理（计数器）

## 扩展建议

可以基于此模板学习：

- 更多JavaFX控件（TextField、ComboBox等）
- 布局管理（GridPane、BorderPane等）
- CSS样式定制
- 场景切换
- 数据绑定
- 自定义控件

## 注意事项

- 确保已安装JDK 8或更高版本
- 确保Maven已正确配置
- 首次运行可能需要下载依赖，请保持网络连接

## 许可证

本项目仅供学习使用。 # fx_small
