# txt2csv_sps

## 概要
`txt2csv_sps`は、TXTファイルとSPSファイルを使用してCSVファイルを生成するPythonスクリプトです。初期のPISAやTIMSSはtxtファイルしか公開されていないので，Rの分析に利用するために作成しました。

## 主な機能
- TXTファイルとSPSファイルからCSVを作成します。
- PISA2000からPISA2012，TIMSS1995，TIMSS1999に対応しています。

## インストール
1. **Python**：Python 3が必要です。
2. **スクリプトのダウンロード**：`txt2csv_sps.py`を任意のプロジェクトフォルダにダウンロードして保存してください。

## 使用方法
以下のコマンド形式で実行します：

```bash
python3 txt2csv_sps.py <txtファイル> <spsファイル> <出力ファイル名>
```


## シェルスクリプトのサンプル
スクリプト例として，`demo.sh`が付属しています。こちらを実行すると，PISA2000の学校ファイルとTIMSS1995の日本の児童ファイルが作成されます。なお，TIMSS1995はTIMSS2003以降と比較するために能力値が再計算されていますので，そちらのデータと結合するための`timss1995.R`ファイルも付属しています。


## PISA・TIMSSデータの入手について

### PISA
PISA2015以降はSPSSファイルが用意されています。
- [PISA2000 Database](https://www.oecd.org/en/data/datasets/pisa-2000-database.html)
- [PISA2003 Database](https://www.oecd.org/en/data/datasets/pisa-2003-database.html)
- [PISA2006 Database](https://www.oecd.org/en/data/datasets/pisa-2006-database.html)
- [PISA2009 Database](https://www.oecd.org/en/data/datasets/pisa-2009-database.html)
- [PISA2012 Database](https://www.oecd.org/en/data/datasets/pisa-2012-database.html)

### TIMSS
TIMSSS2003以降はSPSSファイルが用意されています。
- [TIMSS1995 Database](https://timss.bc.edu/timss1995i/Database.html)
- [TIMSS1999 Database](https://timssandpirls.bc.edu/timss1999i/database.html)
