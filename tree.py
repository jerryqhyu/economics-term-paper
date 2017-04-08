import csv
import numpy as np
from sklearn.tree import DecisionTreeRegressor
from sklearn.metrics import r2_score

def process_data(infile):
    labels = []
    data = []
    capacity = {}
    for i in range(366):
        capacity[i] = 0
    with open(infile, newline='') as datafile:
        reader = csv.reader(datafile, delimiter=',')
        for row in reader:
            row[0] = float(eval(row[0]))
            row[1] = float(eval(row[1]))
            row[2] = float(eval(row[2]))
            row[3] = float(eval(row[3]))
            row[4] = float(eval(row[4]))
            row[5] = float(eval(row[5]))
            row[6] = float(eval(row[6]))
            row[7] = float(eval(row[7]))
            row[8] = float(eval(row[8]))
            row[9] = float(eval(row[9]))
            row[10] = float(eval(row[10]))
            row[11] = float(eval(row[11]))
            row[12] = float(eval(row[12]))
            row[13] = float(eval(row[13]))
            row[14] = float(eval(row[14]))
            row[15] = float(eval(row[15]))
            row[16] = float(eval(row[16]))
            row[17] = float(eval(row[17]))
            row[18] = float(eval(row[18]))
            row[19] = float(eval(row[19]))
            row[20] = float(eval(row[20]))
            row[21] = float(eval(row[21]))
            row[22] = float(eval(row[22]))
            row[23] = float(eval(row[23]))
            row[24] = float(eval(row[24]))
            row[25] = float(eval(row[25]))
            row[26] = float(eval(row[26]))
            row[27] = float(eval(row[27]))
            row[28] = float(eval(row[28]))

            if row[0] != 0 and capacity[row[0]] < 200:
                labels.append(row[0])
                data.append(row[1:])
                capacity[row[0]] += 1
    return data, labels

if __name__ == '__main__':
    data, labels = process_data("./data/processed.csv")
    data = np.asarray(data, dtype=np.float64)
    labels = np.asarray(labels, dtype=np.float64)
    print(data)
    print(labels.shape)

    clf = DecisionTreeRegressor(max_depth=10)


    print("-----Training-----")
    try:
        clf.fit(data, labels)
    except KeyboardInterrupt:
        pass

    print("-----Predicting-----")
    pred = clf.predict(data)
    print(labels)
    print(pred)
    print ('R2:', r2_score(labels, pred))
