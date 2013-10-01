# ISUCONセットアップ用ツール

## 起動方法

### 1. vmの立ち上げ
```
$ ./setup_vms.rb	
``` 
### 2. hostの設定
```
$ vi etc/hosts

54.250.xxx.xxx rp 
54.250.yyy.yyy app1 
... 
```
### 3. applicationのデプロイ
```
$ ./setup_apps.rb
```

### 4. vmの削除
```
$ ./shutdown.rb
```

