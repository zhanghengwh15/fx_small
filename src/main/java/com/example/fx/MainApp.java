package com.example.fx;

import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.VBox;
import javafx.scene.layout.HBox;
import javafx.stage.Stage;

/**
 * JavaFX学习模板主应用程序
 * 
 * @author 开发者
 * @since 1.0.0
 */
public class MainApp extends Application {

    private Label messageLabel;
    private int clickCount = 0;

    @Override
    public void start(Stage primaryStage) {
        // 设置窗口标题
        primaryStage.setTitle("JavaFX 学习模板");

        // 创建主容器
        VBox root = new VBox(20);
        root.setAlignment(Pos.CENTER);
        root.setPadding(new Insets(20));

        // 创建标题标签
        Label titleLabel = new Label("欢迎使用 JavaFX 学习模板");
        titleLabel.setStyle("-fx-font-size: 18px; -fx-font-weight: bold;");

        // 创建消息显示标签
        messageLabel = new Label("点击按钮开始学习！");
        messageLabel.setStyle("-fx-font-size: 14px;");

        // 创建按钮容器
        HBox buttonBox = new HBox(10);
        buttonBox.setAlignment(Pos.CENTER);

        // 创建按钮
        Button helloButton = new Button("打招呼");
        Button countButton = new Button("计数");
        Button clearButton = new Button("清空");

        // 设置按钮样式
        String buttonStyle = "-fx-font-size: 12px; -fx-min-width: 80px; -fx-min-height: 30px;";
        helloButton.setStyle(buttonStyle);
        countButton.setStyle(buttonStyle);
        clearButton.setStyle(buttonStyle);

        // 添加按钮事件处理
        helloButton.setOnAction(e -> showHello());
        countButton.setOnAction(e -> incrementCount());
        clearButton.setOnAction(e -> clearCount());

        // 将按钮添加到容器
        buttonBox.getChildren().addAll(helloButton, countButton, clearButton);

        // 将所有组件添加到主容器
        root.getChildren().addAll(titleLabel, messageLabel, buttonBox);

        // 创建场景
        Scene scene = new Scene(root, 400, 300);
        primaryStage.setScene(scene);

        // 显示窗口
        primaryStage.show();
    }

    /**
     * 显示打招呼消息
     */
    private void showHello() {
        messageLabel.setText("你好！欢迎学习 JavaFX！");
    }

    /**
     * 增加计数
     */
    private void incrementCount() {
        clickCount++;
        messageLabel.setText("按钮点击次数: " + clickCount);
    }

    /**
     * 清空计数
     */
    private void clearCount() {
        clickCount = 0;
        messageLabel.setText("计数已清空！");
    }

    /**
     * 程序入口
     * 
     * @param args 命令行参数
     */
    public static void main(String[] args) {
        launch(args);
    }
} 