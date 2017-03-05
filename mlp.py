import csv
import numpy as np
from sknn.mlp import Regressor
from sknn.mlp import Layer
from sklearn.metrics import r2_score

def process_data(infile):
    labels = []
    data = []
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

            labels.append(row[0])
            data.append(row[1:])
    return data, labels

if __name__ == '__main__':
    data, labels = process_data("./data/processed.csv")
    data = np.asarray(data, dtype=np.float64)
    labels = np.asarray(labels, dtype=np.float64)
    print(data.shape)
    print(labels.shape)

    layers = [Layer(type='Rectifier', units=30),
     Layer(type='Rectifier', units=64),
     Layer(type='Rectifier', units=128),
     Layer(type='Rectifier', units=64),
     Layer(type='Rectifier', units=1)]

    clf = Regressor(
        layers,
        learning_rule='rmsprop',
        learning_rate=1e-5,
        learning_momentum=0.9,
        batch_size=100,
        verbose=True
    )


    print("-----Training-----")
    try:
        clf.fit(data, labels)
    except KeyboardInterrupt:
        pass

    print("-----Predicting-----")
    pred = clf.predict(data)
    print(pred)
    print(labels)
    print ('R2:', r2_score(labels, pred))
