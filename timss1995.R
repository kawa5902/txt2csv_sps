# =====================================================
# TIMSS 1995 日本データの読み込みと平均得点の計算
# =====================================================

# -----------------------------------------------------
# 1. 固定幅ファイル（fwf）の列幅と列名の設定
# -----------------------------------------------------

# 各列の幅を指定します
width95 <- c(5, 10, 40, 35, 35, 35, 35, 40, 35, 35, 35)

# 各列の名前
name95 <- c(
  "idcntry", # 国ID
  "idstud", # 生徒ID
  "asmmat",
  "asmwho",
  "asmfap",
  "asmgem",
  "asmdap",
  "asssci",
  "asseas",
  "asslis",
  "assphs"
)

# -----------------------------------------------------
# 2. 固定幅ファイルの読み込み
# -----------------------------------------------------
jpn95score <- read.fwf(
  "ASVJPN1.DAT", # データファイルのパス
  widths = width95, # 各列の幅
  col.names = name95, # 各列の名前
  stringsAsFactors = FALSE, # 文字列をファクターに変換しない
  colClasses = "character" # 全ての列を文字列として読み込む
)

# -----------------------------------------------------
# 3. ID列を数値型に変換
# -----------------------------------------------------
# 生徒IDと国IDの列を数値型に変換します
jpn95score$idstud <- as.numeric(jpn95score$idstud)
jpn95score$idcntry <- as.numeric(jpn95score$idcntry)

# -----------------------------------------------------
# 4. PVs抽出関数
# -----------------------------------------------------
asd <- function(l) {
  # 1. 文字列をスペースで分割
  d <- strsplit(l, " ")
  # 2. 空文字列を除外し、数値に変換
  d <- lapply(d, function(x) as.numeric(x[x != ""]))
  # 3. 欠損値を除外し、行列に変換
  do.call(rbind, lapply(d, function(x) x[complete.cases(x)]))
}

# -----------------------------------------------------
# 5. PVsデータの作成
# -----------------------------------------------------
jpn95score2 <- as.data.frame(
  do.call(
    cbind,
    lapply(jpn95score[, -c(1, 2)], asd) # ID列以外に関数を適用
  )
)

# PVsの列名を設定
names(jpn95score2) <- unlist(
  lapply(name95[-c(1, 2)], function(x) {
    paste0(x, 1:5) # 例えば "asmmat1", "asmmat2", ..., "asmmat5"
  })
)

# -----------------------------------------------------
# 6. PVsデータの結合
# -----------------------------------------------------
# データを結合し、列名を大文字に変換
jpn95score <- cbind(jpn95score[, 1:2], jpn95score2)
names(jpn95score) <- toupper(names(jpn95score))

# -----------------------------------------------------
# 7. メインデータを読み込み
# -----------------------------------------------------
# TIMSS 1995の日本のデータをCSVファイルから読み込み
jpn95 <- read.csv("timss1995asgjpn.csv", stringsAsFactors = FALSE)
# JKINDIC を JKREP にリネーム
names(jpn95)[names(jpn95) == "JKINDIC"] <- "JKREP"

# -----------------------------------------------------
# 8. メインデータとPVsの結合
# -----------------------------------------------------
# Pvsデータを、国IDと生徒IDで結合
jpn95 <- merge(jpn95, jpn95score, by = c("IDCNTRY", "IDSTUD"))

# -----------------------------------------------------
# 9. intsvy
# -----------------------------------------------------
intsvy::timss.mean("ASMMAT1", data = jpn95)
intsvy::timss.mean.pv(pvlabel = paste0("ASMPV0", 1:5), data = jpn95)
intsvy::timss.mean.pv(pvlabel = paste0("ASMMAT", 1:5), data = jpn95)
