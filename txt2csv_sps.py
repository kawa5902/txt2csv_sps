#!/usr/bin/python
# coding=utf-8

import csv
import sys

def getsps(sps):
    """
    sps fileを読む。
    """
    start_list = []
    end_list = []
    var_list = []
    try:
        with open(sps, "rb") as file:
            for textbr in file:
                text = textbr.decode("utf-8", "ignore")
                spss = text.strip(" /.\n")
                line = spss.replace("-", " - ")
                if len(line.split()) >= 4:
                    if line.split()[1].isdigit() and line.split()[3].isdigit():
                        start_list.append(line.split()[1])
                        end_list.append(line.split()[3])
                        var_list.append(line.split()[0])
    except FileNotFoundError:
        print(f"{sps} ファイルが見つかりません。ファイルパスを確認してください。")
        sys.exit(1)

    return [start_list, end_list, var_list]

def convert(txt, sps, filename="output"):
    """
    txtファイルをcsvに変換
    """
    start_list, end_list, var_list = getsps(sps)

    try:
        with open(txt, "r") as txtfile, open(filename + ".csv", "w", newline="") as csvfile:
            writer = csv.writer(csvfile)
            writer.writerow(var_list)
            num = 0
            num_lines = sum(1 for line in open(txt))
            print("[{}]を変換中・・・".format(txt))
            for line in txtfile:
                pisadata = []
                for (start, end) in zip(start_list, end_list):
                    pisadata.append(line[int(start) - 1 : int(end)])
                writer.writerow(pisadata)
                num += 1
                if num % 100 == 0 or num == num_lines:  # 100行ごと、または最後に更新
                    prog = num / num_lines * 100
                    print("\r進捗: {:.0f}% ({}/{})".format(prog, num, num_lines), end="")
            print("\ncsvファイルの生成が終了しました。")
    except FileNotFoundError:
        print(f"{txt} ファイルが見つかりません。ファイルパスを確認してください。")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("使用法: ./txt2csv_sps.py <txtファイル> <spsファイル> <出力ファイル名>")
        sys.exit(1)
    else:
        txt_file = sys.argv[1]
        sps_file = sys.argv[2]
        output_file = sys.argv[3]

        # TXTファイルからCSVへの変換
        convert(txt_file, sps_file, output_file)
