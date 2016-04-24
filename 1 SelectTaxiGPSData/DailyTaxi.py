#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os

# RAW_DATA_PATH为数据原始数据路径
RAW_DATA_PATH = "D:\\QGrid\\Rawdata\\taxi"

# 获取RAW_DATA_PATH中所有文件名
def getAllRawDataFile():
	try:
		fileList = os.listdir(RAW_DATA_PATH)
	except:
		print("Failed to open \"%s\"" % APP_DIR)
		sys.exit(-1)
	return fileList

# 对每行数据进行处理
def lineData2File(line):
	try:
		# 将每行数据按“,”拆分，存入data中（数据格式：list）
		data = line.split(",")
		# 获取data[6]的值，即为时间日期
		oriTimestamp = data[6]
		# 获取日期和时间，并将时间转化为秒
		oriDate = oriTimestamp.split()[0]
		oriTime = oriTimestamp.split()[1]
		timeList = oriTime.split(":")
		seconds = int(timeList[0])*3600 + int(timeList[1])*60 + int(timeList[2])
		# 将日期中的“-”去掉，并以其命名，将数据写入其中
		# 数据包括车辆ID、经度、纬度、速度和秒数
		outputFileName = oriDate.replace("-", "")
		outputFilePath = outputFileName + ".txt"
		fp = open(outputFilePath, "a")
		fp.write(data[1] + "," + data[2] + "," + data[3] + "," + data[4] + "," + str(seconds) + ",\n")
		fp.close()
	except:
		print(data)

# 依次读取RAW_DATA_PATH中每个文件，并将需要的数据写入对应日期为文件名的文件中
def readRawData():
	fileList = getAllRawDataFile()
	for file in fileList:
		filePath = RAW_DATA_PATH + "\\" + file
		fp = open(filePath, "r")
		for line in fp:
			lineData2File(line)
		fp.close()

def main():
	readRawData()
	
if __name__ == '__main__':
	main()
