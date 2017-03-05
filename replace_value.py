import csv
import numpy as np
from sklearn.neural_network import MLPRegressor, MLPClassifier
from sklearn import ensemble
from sklearn import neighbors
from sklearn import tree
from sklearn import neighbors
from sklearn.svm import SVR
from sklearn import linear_model
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import normalize
from sklearn.metrics.regression import r2_score

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
            # if row[0] == 0.0:
            #     labels.append(0)
            # else:
            #     labels.append(1)
            labels.append(row[0])
            data.append(row[1:])
    return data, labels

if __name__ == '__main__':
    data, labels = process_data("./data/processed.csv")
    data = np.asarray(data, dtype=np.float64)
    labels = np.asarray(labels, dtype=np.float64)
    # data = normalize(data)
    # labels = normalize(labels)
    print(data.shape)
    print(labels.shape)

    #preclf = linear_model.LinearRegression()

    clf = MLPRegressor(
        hidden_layer_sizes=(32, 32,), activation='identity', solver='sgd', alpha=0, batch_size=50, learning_rate='adaptive', learning_rate_init=1e-11, max_iter=50000, shuffle=True, random_state=None, tol=-10, verbose=True, warm_start=True, momentum=0.99, nesterovs_momentum=True, early_stopping=False, validation_fraction=0.1, beta_1=0.9, beta_2=0.999, epsilon=1e-08
    )

    #clf = SVR(verbose=True)

    #clf = linear_model.Lasso(alpha = 0.1)

    #clf = ensemble.ExtraTreesClassifier(n_estimators=8, verbose=1)

    #clf = tree.DecisionTreeClassifier(criterion='entropy', max_depth=16)

    #clf = neighbors.KNeighborsClassifier(n_neighbors=128)

    #clf = neighbors.KNeighborsRegressor()

    print("-----Training-----")
    try:
        clf.fit(data, labels)
    except KeyboardInterrupt:
        pass

    print("-----Predicting-----")
    pred = clf.predict(data)
    print(pred)
    print(labels)
    print ('Accuracy:', clf.score(data, labels))
