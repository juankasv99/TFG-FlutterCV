import os

file1 = open('labels.txt', 'r')
lines = file1.readlines()

count = 0

for line in lines:
    path_test = "./data/test/"+line.strip()
    path_train = "./data/train/"+line.strip()
    path_valid = "./data/valid/"+line.strip()
    try:
        os.mkdir(path_test)
        os.mkdir(path_train)
        os.mkdir(path_valid)
    except OSError:
        print ("Creation of the directory %s failed" % line.strip())
    else:
        print ("Successfully created the directory %s " % line.strip())